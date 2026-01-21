# bios731_hw1_taylor

## BIOS 731 Homework 1 Project Directory

This project is set up as a reproducible workflow for BIOS 731 Homework 1. 

The analysis uses Census American Community Survey (ACS) data at the county level to find associations between selected county demographics and average commute time.

## Structure

* `analysis/` contains the R Markdown files that implement and report the analyses for the project.
* `data/` is a subdirectory containing the raw and cleaned data
* `drafts/` could contain relevant paper drafts, but is empty in this analysis
* `literature/` could contain all references, but is also empty
* `results/` contains results exported by the analysis files
* `source/` contains bare scripts that perform the analysis, but do not report results

*project structured using the [projectr](https://github.com/julia-wrobel/projectr) package.*

## Key Files and Folders

### Data Folder

* *ACSSPP1Y2024.S0201_2026-01-20T132052.zip*: the zip file downloaded directly from data.census.gov, containing the American Community Survey S0201 table from 2024.
* *ACSSPP1Y2024.S0201_2026-01-20T132052*: a folder resulting from unzipping the zip file above.
* *acs_clean.rda*: the intermediate file created in the script *01_load_data.R*, which is a cleaned version of the data in the ACS zip file and folder.


