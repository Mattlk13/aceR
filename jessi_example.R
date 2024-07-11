##Template for processing data with aceR
##See the analysis resources on https://sites.google.com/view/ace-explorer-researchers/ for more details and tutorials on aceR
##Last updated 2021-04-23 by Jessica Younger
##Last updated 2021-05-18 by Jessica Younger to reflect improvements to post_reduce_cols function 
##Last updated 2021-05-18 by Jessica Younger to reflect minor update in some functions (specifically edit SAAT to SAATIMPULSIVE and SAATSUSTAINED in trim_rt_trials_sd and add 'app_type' argument to post_clean_low_trials)

######Set-up: Please make sure all data files from all tasks are within 1 folder on the computer (data can be sectioned off into subfolders within this master program)
####New to R? Simply place your curser on a line of code and press CTRL+Enter on Windows or Command+Enter on a Mac
# The # sign denotes a comment and is not a line of code to be run. You can highlight multiple lines at once and they will run sequentially, skipping anything commented with the # sign. 

#install aceR package
devtools::install_github("joaquinanguera/aceR@development")

##You only need to install once, afterwards simply turn the package on
#However, to update the package, run the above code again
library(aceR)


#########Quick and Easy Analysis: use the summary function to process data according to our suggested best practices

#Specify the file path to the folder with your ace data
path=("~/Desktop/Ace Reports 08-30-2023")
path2=("~/Desktop/LegacyReports")
#Use the summary wrapper function to process the data and get summary metrics for each module 
#Use ?proc_ace_complete to see additional options 
data=proc_ace_complete(path, data_type="nexus")
#a csv file will be saved in the parent directory of the path if no output directory is specified. That's it!

###########Step by Step Processing: walk through each step to customize the processing steps
##Proc_ace_complete calls each of the below functions 

####Read in Raw Data from ACE output
#path to folder with raw data output
path=("~/path/to/data")
data=load_ace_bulk(path, data_type = 'nexus')
data=unnest_ace_raw(data, app_type="explorer")
write.csv(data, file="~/Desktop/newreports.csv")

data2=load_ace_bulk(path2, data_type = 'explorer')
data2=unnest_ace_raw(data, app_type="explorer")
#OPTIONAL data cleaning: Use the trim_rt_trials functions to specify min and max RTs that should be included and/or a value for 
#standard deviation to remove trials outside of the specified number of standard deviations outside of an individual's mean RT
#Trials with an RT < 150ms are already excluded, and Backward and Forward Spatial Span (Gem Chaser) will be excluded from RT cleaning (since RT is not relevant for this task)
#To exclude additional modules from cleaning, simply enter the module name in quotes in the 'exclude' argument.
#We recommend excluding SAAT data from outlier RT cleaning, as these outliers are a key factor
#in assessing SAAT performance. To perform cleaning for this module, remove "SAAT" from the 'exclude' arugment
data=trim_rt_trials_range(data, cutoff_min =200, cutoff_max=NA, exclude=c())
data=trim_rt_trials_sd(data, cutoff=3, exclude=c("SAATIMPULSIVE", "SAATSUSTAINED"))

#Feed the data variable from above directly in the proc_by_module script
#do processing on data, assign to a variable. See proc_by_module documentation for more options
data_averages = proc_by_module(data, verbose=TRUE, app_type = 'explorer')

####Data Cleaning####
###If skipping any optional steps, please make sure you change the variable names appropriately.
#For example, if you skip line 54, line 59 will need 'data_averages' in place of 'data_averages_scrub'  

#OPTIONAL data cleaning: Use post_clean_low_trials to replace data that has fewer than the specified number of trials per condition with NA
data_averages_scrub = post_clean_low_trials(data_averages, extra_demos = c(), min_trials = 5, app_type="explorer")

#OPTIONAL data cleaning: Use post_clean_chance to replace data with NA if subject performed AT or BELOW a given cut off level on a given module
#Please enter the minimum acceptable accuracy for each type of response, dprime, two-option forced choice, and four-option forced choice
#also specify if you want criteria to be evaluated based on overall accuracy of the module (overall = TRUE)  or the easy condition only (overall = FALSE)
data_averages_rmchance = post_clean_chance(data_averages_scrub, app_type="explorer", extra_demos = c(), overall = TRUE, cutoff_dprime = 0, cutoff_2choice = 0.5, cutoff_4choice = 0.25)

#OPTIONAL: Use post_reduce_cols to select only the metrics of interest. You can add or subtract to these names.
#Enter demographic related data that are constant across modules and that should be preserved in the reduced data frame
#You can use names(data_averages) to get a sense of how columns are named. This script will select the columns that match the strings entered into the function

#The code here will output only the suggested metrics of interest for each module. You can edit the metrics_names options to be more general to get additional info for each module. For example, use "rt_mean.correct" to get mean rt for all modules 
data_averages_reduced = post_reduce_cols(data_averages_rmchance,  demo_names = c("pid", "age", "handedness", "bid"), 
                                         metric_names =  c("BRT.rt_mean.correct", "SAATIMPULSIVE.rt_mean.correct", "SAATSUSTAINED.rt_mean.correct", "TNT.rt_mean.correct", "object_count_span.overall", "FILTER.k", "rcs.overall"), metric_names_exclude = c("TNT.rt_mean.correct.", "FILTER.rcs"))

#Write out your processed data 
write.csv(data_averages_reduced, file=paste("~/Desktop/ACE_averaged_data_", Sys.Date(), ".csv", sep=""),row.names=FALSE)
