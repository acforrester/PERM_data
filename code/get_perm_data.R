## Get PERM data

# load packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, glue)

# Collect the historical PERM data ----------------------------------------

# url for the OFLC
url_base <- "https://www.flcdatacenter.com/download"

# get the zip files
lapply(2000:2007, function(year){
  download.file(paste0(url_base, "/", "Perm_FY", year, ".zip"),
                paste0("./data", "/", "Perm_FY", year, ".zip"),
                mode = "wb")
})

# Collect the more recent PERM data ---------------------------------------


# url for the OFLC
url_base <- "https://www.dol.gov/sites/dolgov/files/ETA/oflc/pdfs"

file_list <- list(
  list("PERM_Disclosure_Data_FY2020.xlsx"     , "PERM_FY2020.xlsx"),
  list("PERM_FY2019.xlsx"                     , "PERM_FY2019.xlsx"),
  list("PERM_Disclosure_Data_FY2018_EOY.xlsx" , "PERM_FY2018.xlsx"),
  list("PERM_Disclosure_Data_FY17.xlsx"       , "PERM_FY2017.xlsx"),
  list("PERM_Disclosure_Data_FY16.xlsx"       , "PERM_FY2016.xlsx"),
  list("PERM_Disclosure_Data_FY15_Q4.xlsx"    , "PERM_FY2015.xlsx"),
  list("PERM_FY14_Q4.xlsx"                    , "PERM_FY2014.xlsx"),
  list("PERM_FY2013.xlsx"                     , "PERM_FY2013.xlsx"),
  list("PERM_FY2012_Q4.xlsx"                  , "PERM_FY2012.xlsx"),
  list("PERM_FY2011.xlsx"                     , "PERM_FY2011.xlsx"),
  list("PERM_FY2010.xlsx"                     , "PERM_FY2010.xlsx"),
  list("PERM_FY2009.xlsx"                     , "PERM_FY2009.xlsx"),
  list("PERM_FY2008.xlsx"                     , "PERM_FY2008.xlsx")
)

# collect files
for(i in 1:length(file_list)){
  download.file(paste0(url_base, "/", file_list[[i]][[1]]),
                paste0("./data/raw/", file_list[[i]][[2]]),
                mode = "wb")
}

## EOF
