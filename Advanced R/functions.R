#Function components
  #All R functions have three parts
    #body() 
    #formals() - arguments
    #environment() - location of the function's variables

#Primitive functions
  #sum() is an example, calls C code and thus the above are all NULL

#Exercises
#What function allows you to tell if an object is a function?
#What functions allows you to tell if a function is a function is a primitive function?
  #class()
  #.Primitive()
x <- function (x) x
body(x)
class(x)
class(sum)
is.primitive(sum)
#Which base function has the most arguments?
#How many base functions have no arguments? What's special about these functions?
#How could you adapt the code to find all primitive functions?
objs <- mget(ls("package:base"), inherits = TRUE)
funs <- Filter(is.function, objs)
arguments <- lapply(funs, formals)
length_of_arguments <- unlist(lapply(arguments, length))
length_of_arguments[order(length_of_arguments)]
#scan has the most
table(length_of_arguments)
#225 have no arguments
table(lapply(funs, is.primitive) == TRUE)
#183 are primitive
  #if you're primitive, you have NULL arguments
primitive_funs <- Filter(is.primitive, objs)
#for fun, the functions with no arguments that aren't primitive
funs[length_of_arguments == 0 & lapply(funs, is.primitive) == FALSE]
#What are the three important components of a function?
  #body()
  #formals()
  #environment()
#When does printing a function not show what environment it was created in?
  #when it was created in the global environment

# Lexical scoping
  # Four basic principles of R's lexical scoping
    # name masking
    # functions vs variables
    # a fresh start
    # dynamic lookup

# Name masking
  # the usual: finding names by looking around, then around the around, ...

# Functions vs variables
  # functions are looked for the same as variables
  # except in the case where it's clear you're calling a function like f(3)
  # then R will ignore variables...but don't double name things anyway

# A fresh start
  # every time a function is called a new environment is created to host execution

# Dynamic lookup 
  # R looks for values when the function is run, not when it's created

# Exercises

# What does the following code return? Why?
# What does each of the three c's mean?
c <- 10
c(c = c)
# The first c is the concatenate operator
# the next one names the value to be put in the vector
# the third one is supposed to be value and so R goes looking for it
# What are the four principles that govern how R looks for values?
  # name masking
  # dynamic lookup
  # functions vs variables
  # a fresh start
# What does the following function return? 
f <- function(x) {
  f <- function(x) {
    f <- function(x) {
      x ^ 2
    }
    f(x) + 1
  }
  f(x) * 2
}
f(10)
# 202

# Every operation is a function call
  # a backtick lets you refer to functions or variables that have reserved or illegal names

sapply(1:5, `+`, 3)
x <- list(1:3, 4:9, 10:12)
sapply(x, "[", 2)
# which is equivalent to
sapply(x, function(x) x[2])

# Function arguments

# Calling functions
  # arguments can be specified by position, complete/partial name
  # order: exact name -> prefix matching -> position

# do.call lets you pass lists of arguments
# e.g. do.call(mean, list(1:10, na.rm = TRUE))
# is the same as mean(1:10, na.rm = TRUE)

# Default and missing arguments
  # arguments in R are evaluated lazily, thus default values can be set in terms of other arguments
  # missing() lets you know if an argument was supplied
  # NULL for default values and is.null() check if the default is complex

# Lazy evaluation
  # arguments are only evaluted if used
  # force() can force an argument to evaluate
  # an unevaluated argument is a promise
    # made up of the expression which gives rise to the delayed computation (accessed via substitute())
    # the environment where the expression was created and where it should be evlauated

# The special argument ...
  # will match arguments not otherwise matched
  # can capture ... in list(...)

# Exercises
# Clarify the following list of odd function calls
x <- sample(replace = TRUE, 20, x = c(1:10, NA))
x <- sample(c(1:10, NA), 20, replace = TRUE)
y <- runif(min = 0, max = 1, 20)
y <- runif(20, min = 0, max = 1)
cor(m = "k", y = y, u = "p", x = x)
cor(x, y, use="p", method="k")
# What does this function return? Why? Which principle does it illustrate?
f1 <- function(x = {y <- 1; 2}, y = 0) {
  print(y == 0)
  print(x)
  print(y == 0)
  x + y
}
f1()
# y first would take the value 0, but it's reassigned when x is evaluated
f2 <- function(x = z) {
  z <- 100
  x
}
f2()
# lazy evaluation allows z to be assigned before x is needed

# Special calls
# Infix functions
  # all user created infix functions must start and end with %
`%+%` <- function(a, b) paste0(a, b)
"new" %+% " string"
  # another useful example
`%||%` <- function(a, b) if (!is.null(a)) a else b
#function_that_might_return_null() %||% default value

# Replacement functions
  # have the special name xxx<-
`second<-` <- function(x, value) {
  x[2] <- value
  x
}
x <- 1:10
second(x) <- 5L
  # for additonal arguments, they go between x and value
`modify<-` <- function(x, position, value) {
  x[position] <- value
  x
}
modify(x, 1) <- 10

# Exercises
objs <- mget(ls("package:base"), inherits = TRUE)
funs <- Filter(is.function, objs)
# Create a list of all replacement functions found in the base package.
# Which ones are primitive functions?
grep(".*<-", names(funs))
#replacement functions
names(funs[grep(".*<-", names(funs))])
replacement_functions <- funs[grep(".*<-", names(funs))]
#primitive replacement functions
replacement_functions[lapply(replacement_functions, is.primitive) == TRUE]
# What are valid names for user-created infix functions?
  # anything except those containing % 
  # special characters need to be escaped
# Create an infix xor() operator.
`%xor%` <- function(x, y) xor(x, y)
xor(TRUE, FALSE)
xor(TRUE, TRUE)
TRUE %xor% FALSE
TRUE %xor% TRUE
# Create infix versions of the set functions intersect(), union() and setdiff()
`%intersect%` <- function(x, y) intersect(x, y)
`%union%` <- function(x, y) union(x, y)
`%setdiff%` <- function(x, y) setdiff(x, y)
# Create a replacement function that modifies a random location in a vector.
`chaos<-` <- function(x, value) {
  x[sample(length(x), size=1)] <- value
  x
}
x <- c(1, 2, 3)
x
chaos(x) <- 5
x
chaos(x) <- 6
x

# Return values
  # reserve use of explicit return() when returning early or a simple case of the function
  # most R objects copy-on-modify
f <- function(x) {
  x$a <- 2
  x
}
x <- list(a = 1)
f(x)
x$a
  # most base R functions are pure
  # can return invisible values which aren't printed by default
  # wrapping an invisible value in parantheses forces evaluation
  # note: <- has invisible return, but does return the value assigned

# On exit
  # code in on.exit is run when a function exits regardless of how it exits
  # use add = TRUE to stack multiple lines to run on exit

# Exercises
# How does the chdir parameter of source() compare to in_dir()? Why might one be preferable?
  # the working directory is temporarily changed of chdir is TRUE
  # in_dir() as written always changes the directory during evaluation
  # source() can save us from some unforeseen consequences of changing the directory happening without explicitly coding for them
# What function undoes the action of library?
  # detach()
# How do you save and restore the values of options() and par()?
  # options() gives a list, so that list could be saved to be returned to
  # same for par()
# Write a function that opens a graphics device, runs the code, and closes the graphics device.
temp_graphic_action <- function(code) {
  dev.new()
  on.exit(dev.off())
  force(code)
}
# Capture.output2 vs 1
capture.output2 <- function(code) {
  temp <- tempfile()
  on.exit(file.remove(temp), add = TRUE)
  
  sink(temp)
  on.exit(sink(), add = TRUE)
  
  force(code)
  readLines(temp)
}
capture.output2(cat("a", "b", "c", sep = "\n"))
# Compare capture.output() to capture.output2(). How do the functions differ? 
# What features have I removed to make the key ideas easier to see? 
# How have I rewritten the key ideas to be easier to understand?

# output2 is explicit that the file opened and dumped to
# then exit actions are taken to remove the file and end the sink diversion
