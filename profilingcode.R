#design first, then optimize
#remember: premature optimization is the root of all evil
#measure, don't guess

system.time(readLines("http://www.jhsph.edu"))

hilbert <- function(n) {
  i <- 1:n
  1 / outer(i-1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x))

system.time({
  n <- 1000
  r <- numeric(n)
  for(i in 1:n) {
    x <- rnorm(n)
    r[i] <- mean(x)
  }
})

#Rprof()
#summaryRProf()
#do not use this with system.time()

#usually only run a single function while RProf is going

#turn off with Rprof(NULL)