str(file)

con <- file("foo.txt")
open(con, "r")
data <- read.csv(con)
close(con)
#is the same as
data <- read.csv("foo.txt")

con <- gzfile("words.gz")
x <- readLines(con, 10)
x
#writeLines does the opposite
#takes a character vector and
#writes each element as a line

con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)