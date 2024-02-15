## code to prepare `teams` dataset goes here

devtools::load_all(".")

teams <- readxl::read_excel("data-raw/xlsx/teams.xlsx")

usethis::use_data(teams, overwrite = TRUE)
