install.packages(
  c("stringr",
    "glue",
    "httr",
    "jsonlite",
    "janitor",
    "tibble",
    "dplyr",
    "readr",
    "usethis",
    "devtools",
    "purrr"
  ),
  repos = "https://packagemanager.rstudio.com/all/__linux__/bionic/latest"
)

devtools::load_all()
source("data-raw/scraping_matches.R")

matches_2024 <- purrr::map_dfr(1:38, scraper_ge_2024)

matches_2024 <- matches_2024 |>
  dplyr::mutate(
    dplyr::across(c(home, away), fix_names)
  )

matches <- matches |>
  dplyr::left_join(
    matches_2024,
    by = c("season", "home", "away"),
    suffix = c("", "_new")
  ) |>
  dplyr::mutate(
    date = dplyr::case_when(
      !is.na(date_new) ~ date_new,
      TRUE ~ date
    ),
    score = ifelse(!is.na(score_new), score_new, score)
  ) |>
  dplyr::select(-dplyr::ends_with("new"))

readr::write_csv(matches, "data-raw/csv/matches.csv")

usethis::use_data(matches, overwrite = TRUE)
