loaddata <- function(data.filepath,
                     data.localpath = ".\\",
                     verbose = FALSE,
                     ...) {
   # Loads data used for plotting, using spec given at
   # https://github.com/EricByrnes/ExData_Plotting1/blob/master/README.md
   #
   # Args:
   #   data.filepath (string) - path to file containing data in the 'Electric
   #     power consumption' format.
   #   data.localpath (string) - path to file or directory where local downloaded
   #     data will be stored.
   #   verbose (boolean) - if TRUE, the function emits verbose diagnostic
   #     messages.
   #
   # Returns:
   #   data.frame - data frame containing filtered data.
   #
   # Example:
   #   loaddata("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip",
   #            verbose = TRUE)
   
   # check for valid input file
   if (is.null(data.filepath) || data.filepath == "")
      stop("data.filepath is required")
   
   # directory/file/extension extraction regex
   path.regex <- "(.*[\\\\\\/])([^.]+)(\\.[[:alnum:]]+)$"
   
   # get default fileinfo for download file, i.e. ".zip" for default extension
   #  adapted from http://stackoverflow.com/questions/15073753/regex-return-file-name-remove-path-and-file-extension
   data.filepath.name <- sub(path.regex, "\\2", data.filepath)
   data.filepath.ext <- sub(path.regex, "\\3", data.filepath)
   #
   #  set default local storage
   data.localpath.dir <- ".\\"
   data.localpath.name <- URLdecode(data.filepath.name)
   data.localpath.ext <- data.filepath.ext
   if (!is.null(data.localpath) && data.localpath != "") {
      # get default file info for local version of the file
      data.localpath.dir <- sub(path.regex, "\\1", data.localpath)
#      cat("  Extracting path dir [", data.localpath.dir, "] ",
#          "from [", data.localpath, "]\n", sep = "")
      data.localpath.name <- sub(path.regex, "\\2", data.localpath)
#      cat("  Extracting path name [", data.localpath.name, "] ",
#          "from [", data.localpath, "]\n", sep = "")
      if (data.localpath == data.localpath.name)
         data.localpath.name <- URLdecode(data.filepath.name)
      data.localpath.ext <- sub(path.regex, "\\3", data.localpath)
#      cat("  Extracting path ext [", data.localpath.ext, "] ",
#          "from [", data.localpath, "]\n", sep = "")
      if (data.localpath == data.localpath.ext)
         data.localpath.ext <- data.filepath.ext
   }
   data.localpath <- paste0(c(data.localpath.dir,
                              data.localpath.name,
                              data.localpath.ext))
   if (verbose) {
      cat(" Storing local file to dir [", data.localpath.dir, "],",
          " name [", data.localpath.name, "],",
          " extension [", data.localpath.ext, "],\n",
          "  full path [", data.localpath, "]\n", sep = "")
   }
   
   # create data directory, if necessary
   data.localpath.dir <- sub("(.*)[\\\\\\/]$", "\\1", data.localpath.dir)
   if (!file.exists(data.localpath.dir)) {
      if (verbose)
         cat(" Creating directory [", data.localpath.dir, "]\n", sep = "")
      dir.create(data.localpath.dir)
   }
   
   # download the file if necessary - check whether the file path starts with
   # 'http://', 'https://', 'ftp://'
   if (grepl("^(http://|https://|ftp://)", data.filepath)) {
      # construct download target filename
      data.downloaded <- paste0(data.localpath.dir,
                                data.localpath.name,
                                data.localpath.ext)
      
      # a URL was provided, so download the file (use quiet option to match
      # output detail to our own verbose flag)
      if (verbose)
         cat(" Downloading filename [", data.filepath, "]\n", sep = "")
      download.file(data.filepath, data.downloaded, "curl",
                    quiet = !verbose)
      data.filepath <- data.downloaded
   }
   
   # unzip the file if the extension is ".zip"
   if (data.filepath.ext == ".zip") {
      if (verbose)
         cat(" Unzipping filename [", data.filepath, "]\n", sep = "")
      data.filepaths <- unzip(data.filepath, junkpaths = TRUE,
                              exdir = data.localpath.dir)
      if (verbose)
         cat(" Extracted ",length(data.filepaths), " file(s)\n", sep = "")
   }
   
   # if there is more than one file in the zip, just return filenames
   if (length(data.filepaths) > 1) {
      return (data.filepaths)
   }

   data.filepath <- data.filepaths[1]
   #  read the given text file - warn if there is a problem
   this.data <- NULL
   if (verbose) {
      cat(" Reading filename [", data.filepath, "]", sep = "")
      #  explicitly trap the most likely error - file doesn't exist
      if (!file.exists(data.filepath)) {
         cat(" - WARNING: Invalid data file\n")
      } else {
         #  perform read - trap any errors or warnings
         tryCatch({
            this.data <- read.table(data.filepath, ...)
            cat(" - OK,", nrow(this.data), "frames\n")
         },
         warning = function(w) {
            cat(" - WARNING: File load warning\n")
            print(w)
         },
         error = function(e) {
            cat(" - WARNING: File load error\n")
            print(e)
         })
      }
   } else {
      # read data from file
      this.data <- read.table(data.filepath, ...)
   }
   
   this.data
}
