getwd()
setwd("C:/RProgrammingforDataSci")

data <- read.table("foo.txt")

#a trick to give colClasses a value
initial <- read.table("datatable.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt", colClasses = classes)

#it helps to do rough calculations of memory usage prior to loading

#read.table, read.csv are mains
#Write.table is the inverse

install.packages("readr")
library(readr)
#read_table() and read_csv()
#work just like read.table but much faster

#writing data
dput()
dump()
#preserve the metadata

y <- data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
print(new.y)

x <- "foo"
y <- data.frame(a = 1L, b = "a")
dump(c("x", "y"), file = "data.R")
rm(x, y)
source("data.R")
str(y)
x

#use binary format for efficiency
#or to preserve precision
#or when textual is pointless

a <- data.frame(x = rnorm(100), y = runif(100))
b <- c(3, 4.4, 1 / 3)

save(a, b, file = "mydata.rda")
#.rda and .RData are common extensions

load("mydata.rda")

x <- list(1, 2, 3)
serialize(x, NULL)
#better to use save if sending this as a file
#but it doesn't lose precision or metadata
