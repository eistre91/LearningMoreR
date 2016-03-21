x <- c("a", "b", "c", "c", "d", "a")
x[1]
x[2]
x[1:4]
x[c(1, 3, 4)]

u <- x > "a"
u
x[u]
x[x > "a"]

x <- matrix(1:6, 2, 3)
x[1,2]
x[2,1]
x[1, ] #extract the first row
x[, 2] #extract the second column
x[1, 2, drop = FALSE]
x[1, , drop = FALSE]

x <- list(foo = 1:4, bar = 0.6)
x[[1]]
x[["bar"]]
x$bar

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- foo
x[[name]]
x$name #this doesn't give foo, gives NULL

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1,3)]]
x[[1]][[3]]

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1,3)]

# [] does multiple elements when multiple are listed
# [[]] can not do this and tries to index in further

x <- list(aardvark = 1:5)
x$a
x[["a"]]
x[["a", exact = FALSE]]

x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
print(bad)
x[!bad]
x[!is.na(x)]

x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good
x[good]
y[good]

head(airquality)
good <- complete.cases(airquality)