# Defina o seu projeto no Google Cloud
basedosdados::set_billing_id("113512867473")

# Para carregar o dado direto no R
query <- basedosdados::bdplyr(
  "mundo_transfermarkt_competicoes.brasileirao_serie_a"
)

df <- basedosdados::bd_collect(query)

saveRDS(df, "data-raw/rds/brasileirao_basedosdados.rds")
