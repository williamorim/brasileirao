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

  new_names <- c()
  for(t in teams) {
    aux <- switch(
      t,
      "Atl\u00e9tico PR" = "Athletico PR",
      Prudente = "Barueri",
      t
    )
    new_names <- c(new_names, aux)
  }

  return(new_names)

}
