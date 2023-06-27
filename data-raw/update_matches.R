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

matches_2023 <- purrr::map_dfr(1:38, scraper_ge_2023)

matches_2023 <- matches_2023 |>
  dplyr::mutate(
    dplyr::across(c(home, away), fix_names)
  )

matches <- matches |>
  dplyr::left_join(
    matches_2023,
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
  dplyr::select(-dplyr::ends_with("new")) |>
  mutate(home_score = as.numeric(stringr::str_extract(score, "[:digit:]{1,2}(?=x)")),
         away_score = as.numeric(stringr::str_extract(score, "(?<=x)[:digit:]{1,2}")),
         home_points = case_when(home_score >  away_score ~ 3,
                                 home_score == away_score ~ 1,
                                 home_score <  away_score ~ 0),
         away_points = case_when(away_score >  home_score ~ 3,
                                 away_score == home_score ~ 1,
                                 away_score <  home_score ~ 0)) |>
  dplyr::left_join(teams_abbreviation, by = c("home" = "team") ) |>
  dplyr::left_join(teams_abbreviation, by = c("away" = "team")) |>
  dplyr::rename(
    "home_abbr" = "abbr.x",
    "away_abbr" = "abbr.y"
  )

readr::write_csv(matches, "data-raw/csv/matches.csv")

usethis::use_data(matches, overwrite = TRUE)
