*********
PERM Data
*********

This repo has codes to process PERM data from the Department of Labor.  The data contain microdata on employers' filed applications for permanent employment certification and the decision on each application made by DOL's Office of Foreign Labor Certification (OFLC).

These data are collected by fiscal year (Oct 1 through Mar 31); however, the data include original application and decision dates.

Data Sources
---------------

There are two sources for these data:

1. Current data : `Dept. of Labor <https://www.dol.gov/agencies/eta/foreign-labor/performance/>`_
2. Historical data: `FLC Data Center <https://www.flcdatacenter.com/CasePerm.aspx/>`_

Some Notes
----------

The data spanning fiscal years 2000 through 2007 were (in)conveniently only available in older formatted MS Access databases.  After a few attempts and frustrations trying load these in ``R`` via ``ODBC``, I manually loaded each table into MS Access (located in ``./data/access/Perm_compiled.accdb``) and exported each FY table as a comma delimited text file for further manipulation in ``R``.

While the data contain a few consistent fields, such as employer names and relevant SOC codes/titles, the available fields changed a lot by fiscal year.  The cleaning codes provided attempt to harmonize the data to make them more usable in a time series context.

Changelog
---------

- 2021-07-23 - Initial upload

*Caveat emptor*
---------------

The cleaned data are provided as-is and any any analyses should be careful to check the raw data.  I would caution users when using the FY2005 data, which appear to be incomplete.  I am not assigning a license to the repo and I hope these data and codes are helpful. If so, please feel to DM me and drop a citation.
