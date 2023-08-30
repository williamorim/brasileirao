devtools::load_all()

url <- "https://pt.wikipedia.org/wiki/Lista_de_campe%C3%B5es_do_Campeonato_Brasileiro_de_Futebol"

res <- httr::GET(url)

# Extrair tabelas do HTML
tabelas <- res |> 
  httr::content() |> 
  rvest::html_table()

winners <- tabelas[[2]] |> 
  janitor::clean_names() |> 
  dplyr::rename_with(
    .fn = ~ stringr::str_extract(.x, "artilheiro"),
    .cols = dplyr::matches("artilheiro")
  ) |> 
  dplyr::mutate(
    ano = readr::parse_number(ano),
    dplyr::across(
      -c("ano", "artilheiro", "gols"),
      ~ stringr::str_remove(.x, " \\(.*\\)")
    ),
    dplyr::across(
      vencedor:sexto_colocado,
      fix_names
    ),
  ) |>
  dplyr::filter(
    ano >= 2003
  ) |> 
  dplyr::rename(
    season = ano,
    winner = vencedor,
    runnerup = vice,
    third_place = terceiro_colocado,
    fourth_place = quarto_colocado,
    fifth_place = quinto_colocado,
    sixth_place = sexto_colocado,
    top_scorer = artilheiro,
    n_goals = gols
  ) 

usethis::use_data(winners, overwrite = TRUE)
