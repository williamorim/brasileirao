## code to prepare `teams` dataset goes here

devtools::load_all(".")

teams <- readxl::read_excel("data-raw/xlsx/teams.xlsx")

get_colors <- function(img_path, n = 8, cs = "RGB") {
  img_path %>%
    magick::image_read() %>%
    magick::image_quantize(max = n, colorspace = cs) %>%
    imager::magick2cimg() %>%
    imager::RGBtoHSV() %>%
    as.data.frame(wide = "c") %>%
    dplyr::mutate(
      hex = hsv(scales::rescale(c.1, from = c(0, 360)), c.2, c.3)
    ) %>%
    dplyr::count(hex) %>%
    dplyr::filter(hex != "#FFFFFF") %>%
    dplyr::slice_max(order_by = n, n = 2) %>%
    dplyr::pull(hex) %>%
    paste(collapse = "|")
}

teams <- teams %>%
  dplyr::mutate(
    badge_path = purrr::map_chr(teams, get_badge),
    colors = purrr::map_chr(badge_path, get_colors)
  ) %>% teams%>%
  tidyr::separate(
    colors,
    into = c("color1", "color2"),
    sep = "\\|"
  )

usethis::use_data(teams, overwrite = TRUE)
