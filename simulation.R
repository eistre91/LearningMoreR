#dnorm(x, mean = 0, sd = 1, log = FALSE)
#pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
#qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
#rnorm(n, mean = 0, sd = 1)

#d for density, i.e. evaluate at a point(s)
#r for random number generation
#p for cumulative distribution
#q for quantile function

#set.seed()
#generally set a seed when doing a simulation

#simulate a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)

set.seed(1)
#sample from vectors
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
#get a permutation
sample(1:10)
#with replacement
sample(1:10, replace = TRUE)

library(datasets)
data(airquality)
set.seed(20)
idx <- seq_len(nrow(airquality))
samp <- sample(idx, 6)
airquality[samp, ]