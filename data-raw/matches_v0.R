## code to prepare `partidas` dataset goes here

source("data-raw/scraping_matches.R")

matches_2003_2019 <- purrr::map_dfr(2003:2019, scraper_change_gol)

matches_2003_2019 <- matches_2003_2019 |>
  tibble::add_row(
    season = 2019,
    date = as.Date("2019-09-25"),
    home = "São Paulo",
    score = "0x1",
    away = "Goiás"
  ) |>
  tibble::add_row(
    season = 2019,
    date = as.Date("2019-09-25"),
    home = "Ceará",
    score = "0x0",
    away = "Cruzeiro"
  ) |>
  tibble::add_row(
    season = 2019,
    date = as.Date("2019-09-25"),
    home = "Bahia",
    score = "2x0",
    away = "Botafogo"
  ) |>
  tibble::add_row(
    season = 2019,
    date = as.Date("2019-09-25"),
    home = "Flamengo",
    score = "3x1",
    away = "Internacional"
  ) |>
  dplyr::filter(
    !(date == "2005-05-08" & home == "Vasco"),
    !(date == "2005-07-02" & home == "Ponte Preta"),
    !(date == "2005-07-16" & home == "Paysandu"),
    !(date == "2005-07-24" & home == "Juventude"),
    !(date == "2005-07-31" & home == "Santos"),
    !(date == "2005-08-07" & home == "Vasco"),
    !(date == "2005-08-10" & home == "Cruzeiro"),
    !(date == "2005-08-14" & home == "Juventude"),
    !(date == "2005-08-21" & home == "Internacional"),
    !(date == "2005-09-07" & home == "São Paulo"),
    !(date == "2005-09-10" & home == "Fluminense")
  )

matches_2020 <- purrr::map_dfr(1:36, scraper_ge_2020)
# matches_2020 <- dplyr::filter(matches, season == 2020)

matches <- dplyr::bind_rows(matches_2003_2019, matches_2020)

readr::write_csv(matches, "data-raw/csv/matches.csv")

usethis::use_data(matches, overwrite = TRUE)
