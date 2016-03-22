#Subsetting atomic vectors with [ 
x <- c(2.1, 4.2, 3.3, 5.4)
order(x)
x[c(3, 1)]
x[-c(3, 1)]
x[x > 3]
#logical vectors that are shorter are recycled
x[c(TRUE, FALSE)]
#nothing returns the original
x[]
#zero returns a zero-length vector
#note indexing starts at 1
x[0]
#can index by name in named vectors
y <- setNames(x, letters[1:4])
y[c("d", "c", "a")]

#using [] on a list always returns a list

#Subsetting Matrices and Arrays
a <- matrix(1:9, nrow=3)
colnames(a) <- c("A", "B", "C")
a
a[1:2, ]
a[c(T, F, T), c("B", "A")]

#note that since arrays are just vectors we can index by a single vector
#the count goes down columns first
vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
vals[c(4, 15)]

#Data frames
#when a single vector is used to subset it behaves like a list
#if with two vectors, they behave like matrices

#S4 objects
#@ is equivalent to $, slot() to [[]]

#Exercises
#Fix each of the common data frame subsetting errors:
mtcars[mtcars$cyl == 4, ]
mtcars[-(1:4), ]
mtcars[mtcars$cyl <= 5, ]
mtcars[mtcars$cyl == 4 | mtcars$cyl == 6, ]
#Why does x <- 1:5; x[NA] yield five missing values? (Hint: why is it different from x[NA_real_]?)
x <- 1:5
x[NA]
x[NA_real_]
  #The NA defaults to a logical vector and thus is recycled whereas NA_real_ is not
#What does upper.tri() return? How does subsetting a vector with it work?
#Do we need any additional subsetting rules to describe its behaviour?
x <- outer(1:5, 1:5, FUN = "*")
x[upper.tri(x)]
  #upper.tri(x) gives a matrix of logical values in the upper right triangle
  #subsetting a matrix will return those values occurring in those spots
  #this is explained by treating both as regular vectors, no new rules needed
#Why does mtcars[1:20] return an error? How does it differ from mtcars[1:20, ]?
  #mtcars[1:20] is trying to select the first 20 columns
    #we have less than 20 columans
    #note a data frame is a list of vectors, so indexing it as a list gives the column vectors
  #the latter mtcars[1:20, ] says take the first 20 rows with all columns
#Implement your own function that extracts the diagonal entries from a matrix.
my_diag <- function(x) {
  cur <- 1
  d <- NULL
  while(cur <= length(x)) {
    d <- c(d, cur)
    cur <- cur + nrow(x) + 1
  }
  return(x[d])
}
#What does df[is.na(df)] <- 0 do? How does it work?
  #It first subsets the vector by the logical vector of where NAs are located
  #then those NAs are replaced by 0

#[[]] and $
#[[]] allows you to pull pieces out of a list
# $ is shorthand for [[]] combined with character subsetting
a <- list(a = 1, b = 2)
a[[1]]
a[["a"]]
#can be used to extract columns from data frames

#Preserving vs simplifying
  #preserving means you get the same type of output as the input
  #simplifying differs on data types
    #atomic vector: removes names
    #list: return the object inside the list, not a single element list
    #factor: drops any unused levels
    #matrix/array: if a dim has length 1, that dimension is dropped
    #dataframe: if output is a single column, returns a vector instead of a data frame
  #note x[1, , drop=F] for array and dataframe for preserving behavior

#x$y is equivalent to x[["y", exact = FALSE]]
#one difference is that $ does partial matching

#Exercises
#Given mod <- lm(mpg ~ wt, data = mtcars), extract the residual degrees of freedom.
#Extract R squared from summary(mod).
mod <- lm(mpg ~ wt, data = mtcars)
mod$df.residual
summary(mod)$r.squared

#All subsetting operators can be combined with assignment to modify selected values.

#Subsetting with nothing can be useful with assignment
#it will preserve the original object class and structure
mtcars[] <- lapply(mtcars, as.integer)
mtcars <- lapply(mtcars, as.integer)
data(mtcars)

