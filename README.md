
<!-- README.md is generated from README.Rmd. Please edit that file -->

# brasileirao

R Package with the Brazilian National Soccer League (Brasileirão)
matches from 2003 to 2022.

<a href="https://raw.githubusercontent.com/williamorim/brasileirao/master/data-raw/csv/matches.csv" download="matches.csv">Click
here</a> to download the matches table in CSV.

<a href="https://raw.githubusercontent.com/williamorim/brasileirao/master/data-raw/csv/stats.csv" download="matches.csv">Click
here</a> to download the stats table in CSV.

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
#> # A tibble: 380 × 6
#>    id_match season date       home        score away         
#>       <int>  <dbl> <date>     <chr>       <chr> <chr>        
#>  1     6887   2020 2020-08-08 Fortaleza   0x2   Athletico PR 
#>  2     6888   2020 2020-08-08 Coritiba    0x1   Internacional
#>  3     6889   2020 2020-08-08 Sport       3x2   Ceará        
#>  4     6890   2020 2020-08-09 Flamengo    0x1   Atlético MG  
#>  5     6891   2020 2020-08-09 Santos      1x1   Bragantino   
#>  6     6892   2020 2020-08-09 Grêmio      1x0   Fluminense   
#>  7     6893   2020 2020-09-30 Botafogo    1x2   Bahia        
#>  8     6894   2020 2020-09-30 Corinthians 0x0   Atlético GO  
#>  9     6895   2020 2020-12-03 Goiás       0x3   São Paulo    
#> 10     6896   2020 2021-01-26 Palmeiras   1x1   Vasco da Gama
#> # … with 370 more rows
```

## Sources

-   Data from 2003 to 2019: <http://www.chancedegol.com.br/>

-   Data from 2020 to 2024:
    [globoesporte.globo.com](https://globoesporte.globo.com/futebol/brasileirao-serie-a/)

## Warranty

The data in this package was not validated by any means and has no
warranty.

If you find any bug or wrong information, please [open a
issue](https://github.com/williamorim/brasileirao/issues).

## Next steps

-   Update the data every Monday and Thursday at 11:59 pm using GitHub
    Actions.
