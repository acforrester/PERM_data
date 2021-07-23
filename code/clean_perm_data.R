## Clean PERM data

# load packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, glue)

# PERM: clean 2000-2004 ---------------------------------------------------

lapply(2000:2004, function(year){
  
  read_csv(glue("./data/raw/Perm_external_FY{year}.txt"), 
           col_names = T,
           col_types = cols(.default = "c")) %>% 
    # combine into df
    bind_rows(.) %>% 
    # names to lowercase
    rename_all(tolower) %>% 
    # drop cols
    select(
      -state_case_num,
      -reduction_in_recruit,
      -region_id,
      -contact_first,
      -contact_last,
      -att_firm_name,
      -att_last,
      -att_first,
      -att_city,
      -att_state,
      -unit_of_pay_prev
    ) %>% 
    # col renames
    rename(
      case_status     = last_sig_event,
      decision_date   = last_event_date,
      employer_name   = emp_name,
      employer_city   = emp_city,
      employer_state  = emp_state,
      pw_soc_code     = occ_code,
      pw_soc_title    = occ_title,
      pw_level        = prevail_wage,
      pw_amount       = prevail_wage,
      wage_per        = unit_of_pay,
      wage_offer_from = salary
    ) %>% 
    # edited variables
    mutate(
      wage_per = case_when(
        wage_per == "H" ~ "Hour",
        wage_per == "W" ~ "Week",
        wage_per == "M" ~ "Month",
        wage_per == "A" ~ "Year"
      )
    ) %>% 
    # write to csv
    write_csv(., glue("./data/clean/PERM_FY{year}.csv"), na = "")
  
  })

# PERM: Clean 2005 --------------------------------------------------------

dat05 <- read_csv(glue("./data/raw/Perm_external_FY2005.txt"), 
                  col_names = T,
                  col_types = cols(.default = "c")) %>% 
  # names to lowercase
  rename_all(tolower) %>% 
  # edited variables
  mutate(
    # application type
    application_type = "PERM"
  ) %>% 
  # col renames
  rename(
    case_status        = final_case_status,
    decision_date      = certified_date,
    pw_soc_code        = prevailing_wage_soc_code,
    pw_soc_title       = prevailing_wage_soc_title,
    pw_level           = prevailing_wage_level,
    pw_amount          = prevailing_wage_amount
  ) %>% 
  # drop cols
  select(
    -prevailing_wage_source,
    -prevailing_wage_other_source
  ) %>% 
  # write to csv
  write_csv(., glue("./data/clean/PERM_FY2005.csv"), na = "")


# PERM: clean 2006-2007 ---------------------------------------------------

dat06 <- read_csv(glue("./data/raw/Perm_external_FY2006.txt"),
                  col_names = T,
                  col_types = cols(.default = "c")) %>% 
  # names to lowercase
  rename_all(tolower) %>% 
  # column renames
  rename(
    case_status    = final_case_status,
    pw_soc_code    = prevailing_wage_soc_code,
    pw_soc_title   = prevailing_wage_soc_title,
    pw_level       = prevailing_wage_level,
    pw_amount      = prevailing_wage_amount
  ) %>% 
  # edited variables
  mutate(
    # application type
    application_type = "PERM",
    # decision date
    decision_date = if_else(is.na(certified_date), denied_date, certified_date)
  ) %>% 
  # subset cols
  select(
    -certified_date,
    -denied_date,
    -prevailing_wage_job_title,
    -prevailing_wage_source,
    -prevailing_wage_other_source
  ) %>% 
  # write to csv
  write_csv(., glue("./data/clean/PERM_FY2006.csv"), na = "")

dat07 <- read_csv(glue("./data/raw/Perm_external_FY2007.txt"),
                  col_names = T,
                  col_types = cols(.default = "c")) %>% 
  # names to lowercase
  rename_all(tolower) %>% 
  # column renames
  rename(
    pw_soc_title    = pw_job_title_9089,
    pw_level        = pw_level_9089,
    pw_amount       = pw_amount_9089,
    wage_offer_from = wage_offer_from_9089,
    wage_offer_to   = wage_offer_to_9089,
    wage_per        = wage_offer_unit_of_pay_9089,
    naics_code      = `2007_naics_us_code`,
    naics_title     = `2007_naics_us_title`
  ) %>% 
  # subset columns
  select(
    -us_economic_sector,
    -ends_with("_9089")
  ) %>% 
  # make some vars
  mutate(
    processing_center = case_when(
      substr(case_no, 1, 1) == "A" ~ "Atlanta Processing Center",
      substr(case_no, 1, 1) == "C" ~ "Chicago Processing Center"
    ),
    wage_per = case_when(
      wage_per == "hr"  ~ "Hour",
      wage_per == "wk"  ~ "Week",
      wage_per == "bi"  ~ "Bi-Weekly",
      wage_per == "mth" ~ "Month",
      wage_per == "yr"  ~ "Year"
    )
  ) %>% 
  # write to csv
  write_csv(., glue("./data/clean/PERM_FY2007.csv"), na = "")

## EOF