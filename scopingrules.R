search()

f <- function(x, y) {
  x^2 + y / z
}
#z is a free variable
#z will be searched for in the environment

make.power <- function(n) {
  pow <- function(x) {
    x^n
  }
  pow
}

cube <- make.power(3)
cube(3)
cube
ls(environment(cube))
get("n", environment(cube))

y <- 10
f <- function(x) {
  y <- 2
  y^2 + g(x)
}
g <- function(x) {
  x*y
}
f(3)
