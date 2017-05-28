# NYT-PTSD
### Project examining the frequency of PTSD terms in news media using the New York Times Article Search API
### Adam Chekroud and Hieronimus Loho, [Yale University]

----------------------------------------


- This repository contains the python scraping scripts, raw data, processed data, and figures for our mental health in the media project. 

Folders:

1.**Scripts**:  
* benchmarker.py: Main scraping script that takes in a list of terms, searches the NYT Article Search API, and saves a CSV of each term,     stating the number of articles (hits) per quarter per year since 1900. 
* vets_plotter.R: Plots Figure 1. 
* Military_population_analysis.R: Plots Figure 2, does correlation anaylsis between US military population and all forms of PTSD mentions. 
* PreProcess.R: Takes the raw CSVs created by benchmarker.py, calculates the percentage of articles containing the term, binds data for     all the terms into one big RDS file.
* total_articles.py: Scrapes the NYT API Article Search for the total number of articles written by the NYT per quarter per year, just as   a reference point so that we can calculate the percentage (in the PreProcess.R script).

2.**CSVs** : Contains all of the CSVs created by benchmarker.py and total_articles.py.

3.**Processed Data** : Contains the aggregate RDS made by PreProcess.R that contains all terms. 

4.**Figures** 
* Figure 1
* Figure 2

Please feel free to email me if you have any questions, or if you spot anything that isn't working: hieronimus.loho@yale.edu
    