f <- function() {}
class(f)
f()

f <- function(num = 1) {
  hello <- "Hello, world!\n"
  for(i in seq_len(num)) {
    cat(hello)
  }
  chars <- nchar(hello) * num
  chars 
}
meaningoflife <- f(3)
print(meaningoflife)

#there is a return(), but it is rarely used

formals(f)

f <- function(a, b = 1, c = 2, d = NULL) {
  if(is.null(d)) {
    print("oh no")
  }
}
f()

#arguments are lazily evaluated in R

myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
}
args(paste)
