library(tidyverse)

usethis::create_package('../meuProjeto/')

usethis::use_data_raw("dados")

writexl::write_xlsx(tibble::rownames_to_column(mtcars, "model"), "data-raw/dados.xlsx")


dados <- "data-raw/dados.xlsx" %>%
  readxl::read_xlsx() %>%
  dplyr::filter(cyl > 4) %>%
  dplyr::mutate(
    brand = stringr::str_extract(model, "^[A-z]+")
  ) %>%
  dplyr::group_by(brand) %>%
  dplyr::summarise(
    mean_mpg = mean(mpg),
    prop_6_cyl = sum(cyl == 6)/dplyr::n()
  ) %>%
  dplyr::arrange(brand)

usethis::use_data(dados)

usethis::use_git()
usethis::use_git_config(
  user.name = 'Joao_Paulo',
  user.email = 'jpaulo.ufsj@gmail.com'
)
usethis::use_github()
usethis::create_github_token()
gitcreds::gitcreds_set()
