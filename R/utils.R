#' Standardize names
#'
#' Standardize the name of the teams to what is used nowadays.
#'
#' @param teams Character vector with the name of the teams you want
#' to standardize.
#'
#' @return Character vector with the standardized team names.
#' @export
#'
#' @examples
#' fix_names("Prudente")
#'
fix_names <- function(teams) {
  teams <- sub("-", " ", teams)
  teams <- sub(" FC", "", teams)
  teams <- sub(" EC", "", teams)
  teams <- sub(" SC", "", teams)
  teams <- sub("EC ", "", teams)
  teams <- sub("RB ", "", teams)
  teams <- sub(" DF", "", teams)

  new_names <- c()
  for(t in teams) {
    aux <- switch(
      t,
      "Atl\u00e9tico Mineiro" = "Atl\u00e9tico MG",
      "Atl\u00e9tico Paranaense" = "Athletico PR",
      "Atl\u00e9tico PR" = "Athletico PR",
      Prudente = "Barueri",
      Vasco = "Vasco da Gama",
      "Sport Recife" = "Sport",
      t
    )
    new_names <- c(new_names, aux)
  }

  return(new_names)

}

#' Get team badge
#'
#' Return the path to a badge image file.
#'
#' @param team A Brazilian team. See \code{badges} to see the available
#' badges in this packages. The function will remove accents, uppercase
#' letters and whitespaces.
#'
#' @return A string with the path to the badge image file.
#' @export
#'
#' @examples
#' get_badge("sao paulo")
#' get_badge("sao-paulo")
get_badge <- function(team) {
  team <- team |>
    fix_names() |>
    tolower() |>
    stringi::stri_trans_general("Latin-ASCII")

  team <- gsub(" ", "-", team)

  files <- list.files(
    system.file("badges", package = "brasileirao")
  )

  badge <- files[sub("[.].*", "", files) == team]

  system.file(paste0("badges/", badge), package = "brasileirao")
}
