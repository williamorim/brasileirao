## code to prepare `temp_scrape_ge` dataset goes here

url <- "https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-seriea-2020/rodada/22/jogos/"

res <- url %>%
  httr::GET()

cont <- httr::content(res, type = "text/json", encoding = "latin1")

cont %>%
  jsonlite::fromJSON() %>%
  janitor::clean_names() %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
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
    date,
    home,
    score,
    away
  )


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
    dplyr::filter(!is.na(placar_oficial_mandante)) %>%
    dplyr::mutate(
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
