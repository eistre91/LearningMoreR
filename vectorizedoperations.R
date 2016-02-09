x <- 1:4
y <- 6:9
z <- x + y

x < 2

x <- matrix(1:4, 2, 2)
y <- matrix(rep(10, 4), 2, 2)
x * y
x %*% y #proper matrix multiplication