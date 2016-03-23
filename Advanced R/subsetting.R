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

#Applications
#Lookup tables
x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup[x]
unname(lookup[x])
#Matching and merging by hand
grades <- c(1, 2, 2, 3, 1)
info <- data.frame(
  grade = 3:1,
  desc = c("Excellent", "Good", "Poor"),
  fail = c(F, F, T)
)
id <- match(grades, info$grade)
info[id, ]
rownames(info) <- info$grade
info[as.character(grades), ]
#Random samples
df <- data.frame(x = rep(1:3, each = 2), y = 6:1, z = letters[1:6])
set.seed(10)
df[sample(nrow(df)), ]
df[sample(nrow(df), 3), ]
df[sample(nrow(df), 6, rep = T), ]
#Ordering
x <- c("b", "c", "a")
x[order(x)]
#Expanding aggregated counts
df <- data.frame(x = c(2, 4, 1), y = c(9, 11, 6), n = c(3, 5, 1))
df[rep(1:nrow(df), df$n), ]
#Removing columns from data frames
#Selecting rows based on a condition
  #Remember to use & and | which are vector boolean operators
  #These don't short circuit like && and ||, use those in if statements
mtcars[mtcars$gear == 5 & mtcars$cyl == 4, ]
subset(mtcars, gear == 5 & cyl == 4)
#Boolean algebra vs sets
#which converts booleans to integer indices
x <- sample(10) < 4
unwhich <- function(x, n) {
  out <- rep_len(FALSE, n)
  out[x] <- TRUE
  out
}
unwhich(which(x), 10)

#Exercises
#How would you randomly permute the columns of a data frame? 
#Can you simultaneously permute the rows and columns in one step?
mtcars[, sample(ncol(mtcars))]
mtcars[sample(nrow(mtcars)), sample(ncol(mtcars))]
#How would you select a random sample of m rows from a data farme?
#What if the sample had to be contiguous?
mtcars[sample(nrow(mtcars), 5), ]
first <- sample(nrow(mtcars), 1)
last <- first + 5
mtcars[first:last,]
#How would you put the columns in a data frame in alphabetical order?
names(mtcars)
mtcars[, order(names(mtcars))]
