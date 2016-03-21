#vectors
#either atomic vectors or list
#homogeneous vs heterogeneous

#three common properties
  #typeof()
  #length()
  #attributes

#four common types of atomic vectors
dbl_var <- c(1, 2.5, 4.5)
# With the L suffix, you get an integer rather than a double
int_var <- c(1L, 6L, 10L)
# Use TRUE and FALSE (or T and F) to create logical vectors
log_var <- c(TRUE, FALSE, T, F)
chr_var <- c("these are", "some strings")
#also rare types: complex and raw

typeof(dbl_var)
is.double(dbl_var)
#double vector are often called numeric 
#but is.numeric is for both int and doubles

as.numeric(log_var)
sum(log_var)

#lists can have elements of multiple types
x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(x)
#sometimes called recursive vectors

x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
#in the y assignment, the vector c(3, 4) is first coerced to a list

#unlist coerces a list to an atomic vector

#Exercises
#What are the six types of vector? How does a list differ from an atomic vector?
  #Integer, Double, Logical, Character, Complex, Raw
  #An atomic vector is has homogeneous types, the list has heterogeneous
#What makes is.vector() and is.numeric() fundamnetally different to is.list() and is.character()?
  #is.vector and is.numeric will apply to more than one type of thing
    #in the former, list or atomic vectors
    #in the latter, integers or doubles
  #is.character and is.list will work for specific types of objects
#Test your knowledge of vector coercion rules by predicting the output of the following uses of c():
c(1, FALSE)
#1, 0
c("a", 1)
#"a", "1"
c(list(1), "a")
#list(1, "a")
c(TRUE, 1L)
#1L, 1L
#Why do you need to use unlist() to convert a list to an atomic vector? Why doesn't as.vector() work?
  #as.vector will preserve a list as a list
#Why is 1 == "1" true? Why is -1 < FALSE true? Why is "one" < 2 false?
  #coercion
    #in the first, 1 goes to "1"
    #in the second, FALSE goes to 0
    #in the third, 2 goes to "2"
#Why is the default missing value, NA, a logical vector? What's special about logical vectors?
  #coercion will roll up to the most flexible type in an atomic vector
  #thus just as a logical value will generalize to the most flexible
  #so must the NA logical value

#All objects can have attributes which can be thought of as named lists
y <- 1:10
attr(y, "my_attribute") <- "This is a vector"
attr(y, "my_attribute")
str(attributes(y))

#most attributes are lost in modification except for
  #names - names()
  #dimensions - dim()
  #class - class()

#factors
#vector that can contain only predefined values and stores categorical data
x <- factor(c("a", "b", "b", "a"))
class(x)
levels(x)

sex_char <- c("m", "m", "m")
sex_factor <- factor(sex_char, levels = c("m", "f"))

table(sex_char)
table(sex_factor)

#if coercing numeric data that was read in as factor
#go from factor to character to double
#otherwise we get the levels of the factor as values

#note that factors are actually integers not characters

#Exercises
#An early draft used structure(1:5, comment="my attribute") but when you print
#that object you don't see the comment attribute. Why? Is the attribute missing
#or is there something else special about it?
structure(1:5, comment="my attribute")
attr(test, "comment")
#not missing, can still be accessed
#comment is an attribute that is treated specially
  #see ?attributes
structure(1:10, my_attribute = "This is a vector")
#What happens to a factor when you modify its levels?
  #it changes the ordering of the factor values
f1 <- factor(letters)
levels(f1) <- rev(levels(f1))
#What does this code do? How do f2 and f3 differ from f1?
f2 <- rev(factor(letters))
#the ordering is still the same for the levels, but the list has changed
f3 <- factor(letters, levels = rev(letters))
#the ordering of the letters factors is the same but the levels are reversed

#Matrices and arrays
#adding a dim() attribute to an atomic vector allows it to behave as a multi-dimensional array
#matrices are a special case of arrays with two dimensions

a <- matrix(1:6, ncol = 3, nrow = 2)
# One vector argument to describe all dimensions
b <- array(1:12, c(2, 3, 2))
b
# You can also modify an object in place by setting dim()
c <- 1:6
dim(c) <- c(3, 2)
dim(c) <- c(2, 3)

#nrow() and ncol() for matrices
#rownames() and colnames()
#cbind() and rbind() 
#t()

#Exercises
#What does dim() return when applied to a vector?
  #null for a vector
#If is.matrix() is TRUE, what will is.array() return?
  #TRUE
#How would you describe the following three objects? What makes them different to 1:5?
x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))
  #These are 3 dimensional arrays which each only have values along one dimensional axis.

#Data Frames
#A list of equal-length vectors, thus 2-dimensional
#names() is the same as colnames(), there's also rownames()
#length() is the same as ncol(), there's also nrow()

#data.frame() takes named vectors as input
df <- data.frame(x = 1:3, y = c("a", "b", "c"))
str(df)
#by default strings become factors, stringAsFactors=FALSE to suppress this

cbind(df, data.frame(z = 3:1))
rbind(df, data.frame(x = 10, y = "z"))

#Exercises
#What attributes does a data frame possess?
  #rownames, colnames
  #ncol, nrow
#What does as.matrix() do when applied to a data frame with columns of different types?
  #coerces all columns to the same type
#Can you have a data frame with 0 rows? What about 0 columns?
  #yes, there's the empty data.frame()