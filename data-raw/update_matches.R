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

matches_2021 <- purrr::map_dfr(1:38, scraper_ge_2021)

matches <- matches %>%
  dplyr::filter(season != 2021) %>%
  dplyr::bind_rows(matches_2021)

readr::write_csv(matches, "data-raw/csv/matches.csv")

usethis::use_data(matches, overwrite = TRUE)
