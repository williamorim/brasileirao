xml_table <- function(x, header = NA, trim = TRUE, fill = FALSE, dec = ".") {
  if ("xml_nodeset" %in% class(x)) {
    return(lapply(x, xml_table, header = header, trim = trim, fill = fill, dec = dec))
  }

  stopifnot(xml2::xml_name(x) == "table")
  rows <- xml2::xml_find_all(x, ".//tr")
  n <- length(rows)
  cells <- lapply(rows, xml2::xml_find_all, xpath = ".//td|.//th")
  ncols <- lapply(cells, xml2::xml_attr, "colspan", default = "1")
  ncols <- lapply(ncols, as.integer)
  nrows <- lapply(cells, xml2::xml_attr, "rowspan", default = "1")
  nrows <- lapply(nrows, as.integer)
  p <- unique(vapply(ncols, sum, integer(1)))
  maxp <- max(p)
  if (length(p) > 1 & maxp * n != sum(unlist(nrows)) & maxp * n != sum(unlist(ncols))) {
    if (!fill) {
      stop("Table has inconsistent number of columns. ", "Do you want fill = TRUE?", call. = FALSE)
    }
  }
  values <- lapply(cells, xml2::xml_text, trim = trim)
  out <- matrix(NA_character_, nrow = n, ncol = maxp)
  for (i in seq_len(n)) {
    row <- values[[i]]
    ncol <- ncols[[i]]
    col <- 1
    for (j in seq_len(length(ncol))) {
      out[i, col:(col + ncol[j] - 1)] <- row[[j]]
      col <- col + ncol[j]
    }
  }
  for (i in seq_len(maxp)) {
    for (j in seq_len(n)) {
      rowspan <- nrows[[j]][i]
      colspan <- ncols[[j]][i]
      if (!is.na(rowspan) & (rowspan > 1)) {
        if (!is.na(colspan) & (colspan > 1)) {
          nrows[[j]] <- c(
            utils::head(nrows[[j]], i),
            rep(rowspan, colspan - 1),
            utils::tail(nrows[[j]], length(rowspan) - (i + 1))
          )
          rowspan <- nrows[[j]][i]
        }
        for (k in seq_len(rowspan - 1)) {
          l <- utils::head(out[j + k, ], i - 1)
          r <- utils::tail(out[j + k, ], maxp - i + 1)
          out[j + k, ] <- utils::head(c(l, out[j, i], r), maxp)
        }
      }
    }
  }
  if (is.na(header)) {
    header <- all(xml2::xml_name(cells[[1]]) == "th")
  }
  if (header) {
    col_names <- out[1, , drop = FALSE]
    out <- out[-1, , drop = FALSE]
  } else {
    col_names <- paste0("X", seq_len(ncol(out)))
  }
  df <- lapply(seq_len(maxp), function(i) {
    utils::type.convert(out[, i], as.is = TRUE, dec = dec)
  })
  names(df) <- col_names
  class(df) <- "data.frame"
  attr(df, "row.names") <- .set_row_names(length(df[[1]]))
  if (length(unique(col_names)) < length(col_names)) {
    warning("At least two columns have the same name")
  }
  df
}

scraper_change_gol <- function(year) {
  stopifnot(length(year) == 1)
  stopifnot(year %in% 2003:2019)
  edition <- stringi::stri_sub(year, 3, 4)
  url <- glue::glue("http://www.chancedegol.com.br/br{edition}.htm")
  url %>%
    httr::GET() %>%
    httr::content(encoding = "latin1") %>%
    xml2::xml_find_first(".//table") %>%
    xml_table( header = TRUE) %>%
    janitor::clean_names() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(
      season = year,
      data = as.Date(paste(data, year, sep = "/"), format = "%d/%m/%Y")
    ) %>%
    dplyr::select(
      season,
      date = data,
      home = mandante,
      score = x,
      away = visitante
    )
}

scraper_ge_2020 <- function(round) {
  round <- stringr::str_pad(round, 2, "left", "0")
  url <- glue::glue(
    "https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-seriea-2020/rodada/{round}/jogos/"
  )
  Sys.sleep(1)
  res <- httr::GET(url)
  tab <- res %>%
    httr::content(type = "text/json", encoding = "latin1") %>%
    jsonlite::fromJSON() %>%
    janitor::clean_names() %>%
    tibble::as_tibble()
  tab %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::starts_with("placar_oficial"),
        ~ tidyr::replace_na(.x, "")
      ),
      season = 2020,
      date = as.Date(data_realizacao),
      home = equipes$mandante$nome_popular,
      score = paste(
        placar_oficial_mandante,
        placar_oficial_visitante,
        sep = "x"
      ),
      away = equipes$visitante$nome_popular,
    ) %>%
    dplyr::select(
      season,
      date,
      home,
      score,
      away
    )
}
