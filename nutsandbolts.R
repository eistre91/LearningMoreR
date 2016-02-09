x <- factor(x("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no"))

attributes(x)

is.na(x)

is.nan(x)

#NA values have a class
#NaN values are also NA
#not the converse

x <- c(1, 2, NA, 10, 3)
is.na(x)
#FALSE FALSE TRUE FALSE FALSE
is.nan(x)
#FALSE FALSE FALSE FALSE FALSE

x <- data.frame(foo = 1:4, bar = c(T, T, F, F))
print(x)
names(x) <- c("foo2", "bar2")
row.names(x) <- c("a", "b", "C", "d")
print(x)

x <- 1:3
names(x) <- c("New York", "Seattle", "Los Angeles")
print(x)

x <- list("Los Angeles" = 1, Boston = 2, London = 3)
print(x)

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
print(m)
colnames(m) <- c("h", "f")
rownames(m) <- c("x", "z")

#note matrices vs data frame naming functions
#to set column names in a df, names()
#to set row names in a df, row.names()