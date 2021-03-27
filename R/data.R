#' Brazilian National Soccer League matches
#'
#' A dataset containing the matches Brazilian National Soccer League
#' (Brasileirão) matches from 2003 to 2020.
#'
#' @format A data frame with 5 variables:
#' \describe{
#'   \item{season}{The year of national league edition.}
#'   \item{date}{The match date.}
#'   \item{home}{The home match team.}
#'   \item{score}{The score of the match in the format home x away.}
#'   \item{away}{The away match team.}
#' }
#' @source \url{https://github.com/williamorim/brasileirao}
"matches"


#' Badge file from each team in the matches data framse
#'
#' A dataset containing the filename from each team in the matches data frame.
#'
#' @format A data frame with 2 variables:
#' \describe{
#'   \item{team}{The team name.}
#'   \item{badge}{The badge filename that can be accessed with
#'   \code{system.file("badges/", package = "brasileirao")}}
#' }
#' @source \url{https://github.com/williamorim/brasileirao}
"badges"
