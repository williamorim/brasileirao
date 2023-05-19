## code to prepare `matches` dataset goes here

devtools::load_all()
source("data-raw/scraping_matches.R")

matches_2023 <- purrr::map_dfr(1:38, scraper_ge_2023)

new_id <- max(matches$id_match) + 1

matches_2023 <- matches_2023 |>
  dplyr::mutate(id_match = new_id:(new_id + dplyr::n() - 1))

matches <- matches |>
  dplyr::bind_rows(matches_2023)

usethis::use_data(matches, overwrite = TRUE)
