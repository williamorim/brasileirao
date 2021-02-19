## code to prepare `partidas` dataset goes here

`%>%` <- magrittr::`%>%`
source("data-raw/scraping.R")

matches_2003_2019 <- purrr::map_dfr(2003:2019, scraper_change_gol)

matches_2020 <- purrr::map_dfr(1:36, scraper_ge_2020)

matches <- dplyr::bind_rows(matches_2003_2019, matches_2020)

readr::write_csv(matches, "data-raw/csv/matches.csv")

usethis::use_data(matches, overwrite = TRUE)