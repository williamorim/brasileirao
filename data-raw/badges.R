## code to prepare `badges` dataset goes here

badges <- tibble::tibble(
  team = unique(fix_names(matches$home)),
  badge = purrr::map_chr(team, ~basename(get_badge(.x)))
)

usethis::use_data(badges, overwrite = TRUE)
