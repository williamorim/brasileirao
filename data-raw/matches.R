## code to prepare `matches` dataset goes here

devtools::load_all()
source("data-raw/scraping_matches.R")

matches_2025 <- purrr::map_dfr(1:38, scraper_ge_2025)

new_id <- max(matches$id_match) + 1

matches_2025 <- matches_2025 |>
  dplyr::mutate(
    id_match = new_id:(new_id + dplyr::n() - 1),
    dplyr::across(c(home, away), fix_names)
  )

matches <- matches |>
  dplyr::bind_rows(matches_2025)

readr::write_csv(matches, "data-raw/csv/matches.csv")
usethis::use_data(matches, overwrite = TRUE)
