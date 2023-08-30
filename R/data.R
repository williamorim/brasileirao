#' Brazilian National Soccer League matches
#'
#' A dataset containing the matches Brazilian National Soccer League
#' (Brasileirão) matches from 2003 to 2020.
#'
#' @format A data frame with 5 variables:
#' \describe{
#'   \item{id_match}{Match id.} 
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

#' Teams of the \code{matches} dataset
#'
#' A dataset containing more information about each
#' one of the teams in the \code{matches} dataset.
#'
#' @format A data frame with 5 variables:
#' \describe{
#'   \item{team}{Team name.}
#'   \item{abbr}{Team name abbreviation.}
#'   \item{state}{The state where the club is based.}
#'   \item{color1}{The most frequent color in the team badge.}
#'   \item{color2}{The second more frequent color in the team badge.}
#' }
#' @source \url{https://github.com/williamorim/brasileirao}
"teams"


#' Winners of the Brazilian National Soccer League
#'
#' A dataset containing the final standings of the Brazilian National Soccer for
#' each season from 2003.
#'
#' @format A data frame with 9 variables:
#'   \describe{
#'     \item{season}{Year of the season.}
#'     \item{winner}{Winning team of the season.}
#'     \item{runnerup}{Runner-up team of the season.}
#'     \item{third_place}{Team in third place in the season.}
#'     \item{fourth_place}{Team in fourth place in the season.}
#'     \item{fifth_place}{Team in fifth place in the season.}
#'     \item{sixth_place}{Team in sixth place in the season.}
#'     \item{top_scorer}{Top scorer of the season.}
#'     \item{n_goals}{Number of goals scored by the top scorer.}
#'   }
#'
#' @source \url{https://pt.wikipedia.org/wiki/Lista_de_campe%C3%B5es_do_Campeonato_Brasileiro_de_Futebol}
"winners"