## Original Data Set

Original data set used for this project is the
<a href="https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip">Human Activity Recognition Using Smartphones</a> data set.  It is described at
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">Human Activity Recognition Using Smartphones description</a>.

## Data Sets Produced

<b>subjects.txt</b> - contains subject information:
<ol>
<li><b>subject</b> - subject number
<li><b>mode</b> - experimental group - "test" or "train"
</ol>

<b>short_data.txt</b> - this data set contains the following subset of variables from the main data set; see features.txt and features_info.txt in downloaded data for a complete list of fields and more information on their meanings (the numbers are the original column numbers from the features.txt data set):
<ol>
<li><b>1 tBodyAcc-mean()-X</b>
<li><b>2 tBodyAcc-mean()-Y</b>
<li><b>3 tBodyAcc-mean()-Z</b>
<li><b>4 tBodyAcc-std()-X</b>
<li><b>5 tBodyAcc-std()-Y</b>
<li><b>6 tBodyAcc-std()-Z</b>
<li><b>41 tGravityAcc-mean()-X</b>
<li><b>42 tGravityAcc-mean()-Y</b>
<li><b>43 tGravityAcc-mean()-Z</b>
<li><b>44 tGravityAcc-std()-X</b>
<li><b>45 tGravityAcc-std()-Y</b>
<li><b>46 tGravityAcc-std()-Z</b>
<li><b>81 tBodyAccJerk-mean()-X</b>
<li><b>82 tBodyAccJerk-mean()-Y</b>
<li><b>83 tBodyAccJerk-mean()-Z</b>
<li><b>84 tBodyAccJerk-std()-X</b>
<li><b>85 tBodyAccJerk-std()-Y</b>
<li><b>86 tBodyAccJerk-std()-Z</b>
<li><b>121 tBodyGyro-mean()-X</b>
<li><b>122 tBodyGyro-mean()-Y</b>
<li><b>123 tBodyGyro-mean()-Z</b>
<li><b>124 tBodyGyro-std()-X</b>
<li><b>125 tBodyGyro-std()-Y</b>
<li><b>126 tBodyGyro-std()-Z</b>
<li><b>161 tBodyGyroJerk-mean()-X</b>
<li><b>162 tBodyGyroJerk-mean()-Y</b>
<li><b>163 tBodyGyroJerk-mean()-Z</b>
<li><b>164 tBodyGyroJerk-std()-X</b>
<li><b>165 tBodyGyroJerk-std()-Y</b>
<li><b>166 tBodyGyroJerk-std()-Z</b>
<li><b>201 tBodyAccMag-mean()</b>
<li><b>202 tBodyAccMag-std()</b>
<li><b>214 tGravityAccMag-mean()</b>
<li><b>215 tGravityAccMag-std()</b>
<li><b>227 tBodyAccJerkMag-mean()</b>
<li><b>228 tBodyAccJerkMag-std()</b>
<li><b>240 tBodyGyroMag-mean()</b>
<li><b>241 tBodyGyroMag-std()</b>
<li><b>253 tBodyGyroJerkMag-mean()</b>
<li><b>254 tBodyGyroJerkMag-std()</b>
<li><b>266 fBodyAcc-mean()-X</b>
<li><b>267 fBodyAcc-mean()-Y</b>
<li><b>268 fBodyAcc-mean()-Z</b>
<li><b>269 fBodyAcc-std()-X</b>
<li><b>270 fBodyAcc-std()-Y</b>
<li><b>271 fBodyAcc-std()-Z</b>
<li><b>294 fBodyAcc-meanFreq()-X</b>
<li><b>295 fBodyAcc-meanFreq()-Y</b>
<li><b>296 fBodyAcc-meanFreq()-Z</b>
<li><b>345 fBodyAccJerk-mean()-X</b>
<li><b>346 fBodyAccJerk-mean()-Y</b>
<li><b>347 fBodyAccJerk-mean()-Z</b>
<li><b>348 fBodyAccJerk-std()-X</b>
<li><b>349 fBodyAccJerk-std()-Y</b>
<li><b>350 fBodyAccJerk-std()-Z</b>
<li><b>373 fBodyAccJerk-meanFreq()-X</b>
<li><b>374 fBodyAccJerk-meanFreq()-Y</b>
<li><b>375 fBodyAccJerk-meanFreq()-Z</b>
<li><b>424 fBodyGyro-mean()-X</b>
<li><b>425 fBodyGyro-mean()-Y</b>
<li><b>426 fBodyGyro-mean()-Z</b>
<li><b>427 fBodyGyro-std()-X</b>
<li><b>428 fBodyGyro-std()-Y</b>
<li><b>429 fBodyGyro-std()-Z</b>
<li><b>452 fBodyGyro-meanFreq()-X</b>
<li><b>453 fBodyGyro-meanFreq()-Y</b>
<li><b>454 fBodyGyro-meanFreq()-Z</b>
<li><b>503 fBodyAccMag-mean()</b>
<li><b>504 fBodyAccMag-std()</b>
<li><b>513 fBodyAccMag-meanFreq()</b>
<li><b>516 fBodyBodyAccJerkMag-mean()</b>
<li><b>517 fBodyBodyAccJerkMag-std()</b>
<li><b>526 fBodyBodyAccJerkMag-meanFreq()</b>
<li><b>529 fBodyBodyGyroMag-mean()</b>
<li><b>530 fBodyBodyGyroMag-std()</b>
<li><b>539 fBodyBodyGyroMag-meanFreq()</b>
<li><b>542 fBodyBodyGyroJerkMag-mean()</b>
<li><b>543 fBodyBodyGyroJerkMag-std()</b>
<li><b>552 fBodyBodyGyroJerkMag-meanFreq()</b>
</ol>

<b>mean_data.txt</b> - contains mean values by subject and activity for each of the values found in short_data.txt. The column/variable names used remain the same. All variables with the name pattern ".mean" (after conversion to column name format) are included in this set.
