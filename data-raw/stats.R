## code to prepare `stats` dataset goes here

stats_raw <- readr::read_rds("data-raw/rds/brasileirao_basedosdados.rds")

stats <- stats_raw |>
  dplyr::select(
    season = ano_campeonato,
    data,
    horario,
    rodada,
    estadio,
    arbitro,
    publico,
    publico_max,
    home = time_man,
    away = time_vis,
    tecnico_man,
    tecnico_vis,
    colocacao_man,
    colocacao_vis,
    valor_equipe_titular_man,
    valor_equipe_titular_vis,
    idade_media_titular_man,
    idade_media_titular_vis,
    gols_man,
    gols_vis,
    gols_1_tempo_man,
    gols_1_tempo_vis,
    escanteios_man,
    escanteios_vis,
    faltas_man,
    faltas_vis,
    chutes_bola_parada_man,
    chutes_bola_parada_vis,
    defesas_man,
    defesas_vis,
    impedimentos_man,
    impedimentos_vis,
    chutes_man,
    chutes_vis,
    chutes_fora_man,
    chutes_fora_vis
  ) |>
  dplyr::mutate(
    dplyr::across(c(home, away), fix_names)
  ) |>
  dplyr::left_join(
    dplyr::select(matches, id_match, season, home, away),
    by = c("season", "home", "away")
  ) |>
  dplyr::relocate(id_match) |>
  dplyr::arrange(id_match)

readr::write_csv(stats, "data-raw/csv/stats.csv")
