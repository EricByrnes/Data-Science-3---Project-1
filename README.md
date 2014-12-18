## Introduction

Original data set used for this project comes from the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine-Learning Repository</a>, named "Human Activity Recognition Using Smartphones". The data set is cached to the Coursera "Getting and Cleaning Data" course web site:

* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip">Human Activity Recognition Using Smartphones</a> [59.6Mb]

* <b>Description</b>: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. A full description is <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">available here</a> and in the README.md file within the downloaded data.

The run_analysis.R file performs the following analysis steps:

<ol>
<li><b>Downloading</b>: Data is downloaded from the known URL above</li>
<li><b>Extraction</b>: Extracts the downloaded zip to the directory ./data by default</li>
<li><b>Constructs subject data set</b>: Constructs a subject data set containing subject ID and group (train or test); this is stored separately since the subject group is an attribute of the subject and
is redundant in the full data set</li>
<li><b>Constructs tidy data set</b>: Constructs a master data set from the collection of files in the data set (note: this is a large data set, currently over 100MB)</li>
<li><b>Extracts means and standard deviations</b>: Mean and standard deviation measurement columns are extracted</li>
<li><b>Extracts means by subject and activity</b>: Mean values are calculated by subject and activity type</li>
</ol>

The analysis produces several table files (loadable with read.table):
<ol>
<li><b>subjects.txt</b>: Subject number and grouping</li>
<li><b>data.txt</b>: Full data set with all variables and observations (omitted from the source due to size)</li>
<li><b>short_data.txt</b>: Observations containing mean and standard deviation data</li>
<li><b>means_data.txt</b>: Variable mean values by subject and activity</li>
</ol>

The following setup variables may be modified to change the behavior of the script. 
<ol>
<li><b>data.filepath</b>: URL to download the data set ZIP file; the default should work fine</li>
<li><b>data.localpath</b>: Local directory to extract downloaded data to; the directory is created if necessary</li>
<li><b>data.outpath</b>: Directory to output tidy data sets to</li>
<li><b>write.full.data</b>: If TRUE, write the (large) full tidy data set</li>
<li><b>verbose</b>: If TRUE, emit progress and diagnostic messages</li>
</ol>
