## code to prepare `update_matches` dataset goes here

devtools::load_all()
source("data-raw/scraping_matches.R")

matches_2020 <- purrr::map_dfr(1:38, scraper_ge_2020)

matches <- matches %>%
  dplyr::filter(season != 2020) %>%
  dplyr::bind_rows(matches_2020)

readr::write_csv(matches, "data-raw/csv/matches.csv")

usethis::use_data(matches, overwrite = TRUE)
