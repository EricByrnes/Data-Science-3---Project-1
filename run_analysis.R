# Cleans and tidies smartphone accelerometer data, using spec given at
# https://github.com/EricByrnes/Smartphone_Accelerometer/blob/master/README.md
#
# Setup variables:
#   data.filepath (string) - path to file containing data in the 'Electric
#     power consumption' format. Several options are supported:
#     - if data.filepath starts with "http://", "https://" or "ftp://", the
#       function will attempt to download the file, otherwise it will attempt
#       to load the file locally
#     - if the file extension is ".zip", the file is unzipped to the current
#       directory and the first (or only) file is assumed to be the data file
#   verbose (boolean) - if TRUE, the function emits verbose diagnostic
#     messages.
#
# Dependencies: loaddata.R in the working directory
#
# Examples:
#   # perform analysis
#   data.filepath <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
#   verbose <- TRUE

# Setup variables
data.filepath <- "https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
data.localpath <- ".\\data\\"
data.outpath <- ".\\"
write.full.data <- TRUE
verbose <- TRUE

# BEGIN - Common file handling
source("loaddata.R")
this.data <- loaddata(data.filepath,
                      data.localpath,
                      verbose = verbose,
                      sep = ";", header = TRUE,
                      colClasses = "numeric")
# END - Common file handling

# BEGIN - Metadata
if (verbose)
   cat(" Reading feature column information", sep = "")
featureNames <- read.table(paste0(data.localpath, "features.txt"),
                           colClasses = c("integer", "character"))
if (verbose)
   cat(", done\n", sep = "")
if (verbose)
   cat(" Reading activity label information", sep = "")
activityNames <- read.table(paste0(data.localpath, "activity_labels.txt"),
                            colClasses = c("integer", "character"))
if (verbose)
   cat(", done\n", sep = "")
# END - Metadata

# BEGIN - Read data sets
tidy.subject <- data.frame(subject = vector(), mode = vector())
tidy.data <- data.frame()
for (subjectGroup in c("test", "train")) {
   if (verbose)
      cat(" Reading [", subjectGroup, "] experimental group files\n", sep = "")

   # load subject index
   if (verbose)
      cat("  Reading subject information", sep = "")
   subject <- read.table(paste0(data.localpath, "subject_", subjectGroup, ".txt"),
                         colClasses = "integer")
   obs.data <- data.frame(subject = subject[[1]])
   
   # create subject data
   subject.data <- cbind(unique(subject[[1]]), subjectGroup)
   colnames(subject.data) <- c("subject", "mode")
   rownames(subject.data) <- NULL
   tidy.subject <- rbind(tidy.subject, subject.data)
   if (verbose)
      cat(", OK, ", nrow(tidy.subject), " subjects loaded\n", sep = "")
   
   # load time/domain data
   if (verbose)
      cat("   Reading time/frequency data", sep = "")
   thisData <- read.table(paste0(data.localpath,
                                 "y_", subjectGroup,
                                 ".txt"),
                          colClasses = "integer")
   obs.data <- cbind(obs.data, activity = thisData[, 1])
   thisData <- read.table(paste0(data.localpath,
                                 "x_", subjectGroup,
                                 ".txt"),
                          colClasses = "numeric")
   colnames(thisData) <- make.names(featureNames[, 2])
   obs.data <- cbind(obs.data, thisData)
   if (verbose)
      cat(", OK, ", nrow(thisData), " observations loaded\n", sep = "")
   
   # load data groups - "total_acc", "body_acc", "body_gyro"
   for (sensorGroup in c("total_acc", "body_acc", "body_gyro")) {
      if (verbose)
         cat("  Reading [", sensorGroup, "] sensor group\n", sep = "")

      # load axis groups - "x", "y", "z"
      for (axisGroup in c("x", "y", "z")) {
         if (verbose)
            cat("   Reading ", axisGroup, " axis", sep = "")

         thisData <- read.table(paste0(data.localpath,
                                       sensorGroup, "_",
                                       axisGroup, "_",
                                       subjectGroup,
                                       ".txt"),
                                colClasses = "numeric")
         #  create column names for the observation array
         colnames(thisData) <- make.names(paste(sensorGroup,
                                                axisGroup,
                                                1:length(thisData)))
         thisData[, 1] <- as.integer(thisData[, 1])
         obs.data <- cbind(obs.data, thisData)

         if (verbose)
            cat(", OK, ", nrow(thisData), " observations loaded\n", sep = "")
      }

      if (verbose)
         cat("   Done reading sensor group ", sensorGroup, "\n", sep = "")
   }
   
   if (verbose)
      cat("  Adding ", nrow(obs.data), " rows to data set\n", sep = "")
   tidy.data <- rbind(tidy.data, obs.data)
}
rm(subjectGroup)
rm(sensorGroup)
rm(axisGroup)
rm(thisData)
rm(obs.data)
rm(subject)
rm(subject.data)
# END - Read data sets

# write subject data
if (verbose)
   cat("\n Writing tidy subject file", sep = "")
tidy.subject$subject <- as.integer(tidy.subject$subject)
write.table(tidy.subject,
            paste0(data.outpath, "subjects.txt"),
            row.name = FALSE)
if (verbose)
   cat(", OK, ", nrow(tidy.subject), " rows written\n", sep = "")

# general tidying
tidy.data$activity <- factor(as.character(tidy.data$activity),
                             levels = activityNames[, 1],
                             labels = activityNames[, 2])

if (write.full.data) {
   # write data
   if (verbose)
      cat("\n Writing full tidy data file", sep = "")
   write.table(tidy.data,
               paste0(data.outpath, "data.txt"),
               row.name = FALSE)
   if (verbose)
      cat(", OK, ", nrow(tidy.data), " rows written\n", sep = "")
}

# extract partial data and write
if (verbose)
   cat("\n Extracting set with means, standard deviations", sep = "")
extractNames <- c(1, 2,
                  grep("\\.(mean|std)", colnames(tidy.data)))
tidy.data.short <- tidy.data[, extractNames]
if (verbose)
   cat(", ", length(extractNames), " columns extracted\n", sep = "")
if (verbose)
   cat(" Writing abbreviated tidy data file", sep = "")
write.table(tidy.data.short,
            paste0(data.outpath, "short_data.txt"),
            row.name = FALSE)
if (verbose)
   cat(", OK, ", nrow(tidy.data.short), " rows written\n", sep = "")

# extract means data and write
if (verbose)
   cat("\n Calculating variable means\n", sep = "")
tidy.data.mean <- aggregate(. ~ subject + activity, tidy.data.short, mean)
if (verbose)
   cat(" Writing means tidy data file", sep = "")
write.table(tidy.data.mean,
            paste0(data.outpath, "means_data.txt"),
            row.name = FALSE)
if (verbose)
   cat(", OK, ", nrow(tidy.data.mean), " rows written\n", sep = "")
