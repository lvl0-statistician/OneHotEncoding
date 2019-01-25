# OneHotEncoding
one hot encoding using R data.table package

The R functions allows to cast text/string/factor values of a column(s) as new variables with 0/1 encoding.
It handles missingness, text string values seperated by another text string (e.g. "/" or "; ") or factorial variables.

The arguments of the function are:
 - datatable: a data frame or data table initial object containing features you want to cast and encode
 - columns: character or numeric vector of the target colums to be one-hot encoded
 - seperator = ", ": how to separate the text values in argument 'columns'
 - keep = F: 'keep' == F to throw the colums that were coded away, TRUE means keep the original columns in the dataset
 - factorise = F: 'factorise' == TRUE means that the finally produced oneHot encoded columns containing 0s and 1s will be coerced into factors, if false they will be numeric

```R
NOT RUN Example:
DF = data.frame(
  aColumn=rep(c("f", "b", "c"), 100000),
  xColumn=rep(c("N/W", "W", "R"), 100000), 
  yColumn=rep(c("A/B", "A/V", "B/G"), 100000))
  
str(DF)

out <- oneHotOnText(DF, columns = c("aColumn", "xColumn", "yColumn"), seperator="/", factorise = T)[] #data.table out is returned
```
