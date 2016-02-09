x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)
sapply(x, mean)

x <- 1:4
lapply(x, runif, min = 0, max = 10)

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) {elt [,1] })

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
split(x, f)
lapply(split(x, f), mean)

library(datasets)
head(airquality)
s <- split(airquality, airquality$Month)
str(s)
sapply(s, function(x) {
  colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE)
})
?colMeans

f1 <- gl(2, 5)
f2 <- gl(5, 2)
interaction(f1, f2)
x <- rnorm(10)
str(split(x, list(f1, f2), drop = TRUE))

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f
tapply(x, f, mean)
tapply(x, f, range)

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) #collapse rows and keep columns i.e. second dimension
apply(x, 1, mean) #vice versa

#optimized versions of apply
#rowSums
#rowMeans
#colSums
#colMeans

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs=c(0.25, 0.75))

mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
  rnorm(n, mean, sd)
}
mapply(noise, 1:5, 1:5, 2)
#same as
list(noise(1, 1, 2), noise(2, 2, 2),
     noise(3, 3, 2), noise(4, 4, 2),
     noise(5, 5, 2))

#can be used to vectorize functions
sumsq <- function(mu, sigma, x) {
  sum(((x - mu)/sigma)^2)
}
x <- rnorm(100)
mapply(sumsq, 1:10, 1:10, MoreArgs = list(x = x))
vsumsq <- Vectorize(sumsq, c("mu", "sigma"))
vsumq(1:10, 1:10, x)