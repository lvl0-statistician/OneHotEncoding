oneHotOnText <- function(datatable, #data frame or data.table
                         columns, #character vector or numeric vector of the target colums to be hot encoded
                         seperator = ", ", #how to separate the text values in argument 'columns'
                         keep = F, #'keep' == F to throw the colums that were coded, T means keep the original columns in the dataset
                         factorise = F) #'factorise' == T, means that the final produced oneHot encoded columns containing 0s and 1s will be coerced into factors, if false they will be numeric
  {
  if(! "data.table" %in% .packages()) if(!require(data.table)) { install.packages("data.table"); library(data.table) }
  if(! "data.table" %in% class(datatable)) TempDT <- as.data.table(datatable) else TempDT <- copy(datatable)
  counT <- 1L
  for(i in TempDT[, columns, with = F]){
    print(columns[counT])
    if(class(i) != "character") i <- as.character(i)
    uniqueValues <- unique(unlist(strsplit(unique(i), split = seperator)))
    if(any(uniqueValues %in% names(TempDT))) { print("Value/s of the selected column/s is/are present as variables name/s. Rename it/them.")
                                               rm(TempDT)
                                               break }
    if(factorise) for(j in uniqueValues) TempDT[, (paste0(columns[counT], "_", j)) := factor(ifelse(grepl(j, i), 1, 0))] else for(j in uniqueValues) TempDT[, (paste0(columns[counT], "_", j)) := ifelse(grepl(j, i), 1, 0)] 
    counT <- counT + 1L
  }
  if(keep == F) TempDT[, (columns) := NULL]
  if(any(grepl("_NA", names(TempDT)))) TempDT[, c(grep("_NA", names(TempDT), value = T)) := NULL] #remove NA columns (anyways in my so far testing containing most probably only NAs)
  if(exists("TempDT")) return(TempDT)
  }

#DF = data.frame(
#  aColumn=rep(c("f", "b", "c"), 100000),
#  xColumn=rep(c("N/W", "W", "R"), 100000), 
#  yColumn=rep(c("A/B", "A/V", "B/G"), 100000),

#str(DF)#  zColumn=rep(20:22, 100000))


#result<- oneHotOnText(DF, columns = c("aColumn", "xColumn", "yColumn"), seperator="/", factorise = T)[]
