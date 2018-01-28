# NYT-PTSD
### Project examining the frequency of PTSD terms in news media using the New York Times Article Search API
### Adam Chekroud and Hieronimus Loho, [Yale University]

----------------------------------------


- This repository contains the all of the code, data, and figures that were involved in our investigation of PTSD and the media.
- It is maintained by HL, who can be reached at {hieronimus.loho@yale.edu}



**Folders**:

1.**Scripts**:  
* check_hits_by_term.py: Main script that you give a list of specific queries, and it will: search the NYT Article Search API and save a CSV for each term that states the number of articles (hits) per quarter per year since 1900 (or any specified year).
* check_total_hits.py: This script will calculate the total number of articles in the database per quarter per year. You can use these values as a reference point to correct for the upward trend over time whereby more articles are published now than they used to.
* Military_population_analysis.R: Reproduces Figure 2, and confirms pearson correlation between US military population and all mentions of PTSD. 
* PreProcess.R: This script reads in the raw CSVs created by check_hits_by_term.py, corrects the timeseries for the total number of articles published that quarter, binds data for all terms into one data frame, and returns one (big) RDS file.
* Supplement_Table.R: Reproduces Supplemental Figure 1.
* vets_plotter.R: Reproduces main Figure 1. 


2.**CSVs** : 
* hits: Contains all of the CSVs created by check_hits_by_term.py and check_total_hits.py.
* other: Contains two CSVs: (1) Mil.vs.Total.Pop: the active duty military population and estimated total US population by year, (2) Supplment_table: Csv form of Supplemental Figure 1.

3.**Processed Data** :
* Contains the aggregated RDS files made by PreProcess.R.  

4.**Figures** 
* Figure 1
* Figure 2
* Supplemental Figure 1
* Supplemental Figure 2
* Supplemental Figure 3

5.**Terms of interest**
* veterans_terms.txt: a list of search terms that were used to query the API (using check_hits_by_term.py).
* veterans_disp_terms.txt: a list of terms that are just shorter (human readable) versions of the search queries.
* veterans_paper_terms.csv: csv file with a list of terms to be included in the Supplement Figure 1. 

Please feel free to email hieronimus.loho@yale.edu if you have any questions, or if you spot anything that isn't working. 

Please do not share or reuse these materials without permission.
We have no copyright, nor do we have money to pay lawyers to do anything about it,
but we will be sad, and [tweet](https://twitter.com/itschekkers) everyone we know to tell them you were naughty.
