## code to prepare `matches` dataset goes here

devtools::load_all()

matches <- matches |>
  dplyr::mutate(
    id_match = dplyr::row_number()
  ) |>
  dplyr::relocate(id_match)

usethis::use_data(matches, overwrite = TRUE)
