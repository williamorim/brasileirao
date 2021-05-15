
<!-- README.md is generated from README.Rmd. Please edit that file -->

# brasileirao

R Package with the Brazilian National Soccer League (Brasileirão)
matches from 2003 to 2020.

For Portuguese speakers: pacote com os resultados das partidas da Série A do Brasileirão de 2003 a 2020. Veja [aqui um post sobre como usar](https://blog.curso-r.com/posts/2021-03-02-brasileirao/).

<a href="https://raw.githubusercontent.com/williamorim/brasileirao/master/data-raw/csv/matches.csv" download="matches.csv">Click
here</a> to download all data in CSV.

## Installation

You can install this package from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("williamorim/brasileirao")
```

## Example

Data from the 2020 season:

``` r
library(brasileirao)

dplyr::filter(matches, season == 2020)
#> # A tibble: 276 x 5
#>    season date       home        score away         
#>     <dbl> <date>     <chr>       <chr> <chr>        
#>  1   2020 2020-08-08 Fortaleza   0x2   Athletico-PR 
#>  2   2020 2020-08-08 Coritiba    0x1   Internacional
#>  3   2020 2020-08-08 Sport       3x2   Ceará        
#>  4   2020 2020-08-09 Flamengo    0x1   Atlético-MG  
#>  5   2020 2020-08-09 Santos      1x1   Bragantino   
#>  6   2020 2020-08-09 Grêmio      1x0   Fluminense   
#>  7   2020 2020-09-30 Botafogo    1x2   Bahia        
#>  8   2020 2020-09-30 Corinthians 0x0   Atlético-GO  
#>  9   2020 2020-12-03 Goiás       0x3   São Paulo    
#> 10   2020 2020-08-12 Bragantino  1x1   Botafogo     
#> # ... with 266 more rows
```

## Sources

  - Data from 2003 to 2019: <http://www.chancedegol.com.br/>

  - Data from 2020 and 2021:
    [globoesporte.globo.com](https://globoesporte.globo.com/futebol/brasileirao-serie-a/)
    
The data is updated every day, using a GitHub Actions workflow. The workflow is disabled in months between seasons.

## Warranty

The data in this package was not validated by any means and has no
warranty.

If you find any bug or wrong information, please [open a
issue](https://github.com/williamorim/brasileirao/issues).

## Next steps

  - Gather more data from Serie A
  - Gather data from Serie B, C and D
