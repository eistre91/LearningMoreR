x <- runif(1, 0, 10)
if(x > 3) {
  y <- 10
} else {
  y <- 0
}
y <- if(x > 3) {
  10
} else {
  0
}

for(i in 1:10) {
  print(i)
}

x <- c("a", "b", "c", "d")
for(i in seq_along(x)) {
  print(x[i])
}
for(letter in x) {
  print(letter)
}

#repeat loop which is an infinite
#will only stop on a break call

#note on & vs &&
#& will perform elementwise comparisons on vectors
#&& will only compare the first element of vectors
