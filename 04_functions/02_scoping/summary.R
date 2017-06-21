####################
# Lexical scopting #
####################
#
# The set of rules that govern how R looks up the value of a symbol.
#
x <- 10
#
# Type of scoping R provides:
#   * Lexical scoping
#   * Dynamic scoping

##
# Lexical scoping
##
#
# Lexical scoping looks up symbol values based on how functions were nested
# when they were CREATED, not how they are nested when they are called.
#
# 4 Principles behind implementation of lexical scoping:
#   * Name masking
#   * Function vs. variables
#   * A fresh start
#   * Dynamic lookup
#

## Name masking
#
# Example:
f <- function(){
  x <- 1
  y <- 2
  c(x, y)
}
f()
rm(f)
#
# If a name is not defined inside a function, $ will look one level up:
#
x <- 2
g <- function(){
  y <- 1
  c(x, y)
}
g()
rm(x, g)
#
# Same rule apply with composite function:
#
x <- 1
h <- function(){
  y <- 2
  i <- function(){
    z <- 3
    c(x, y, z)
  }
  i()
}
h()
rm(x, h)
#
# The same rules apply to closures
# Closures: functions created by other functions
#
j <- function(x){
  y <- 2
  function(){
    c(x, y)
  }
}
k <- j(1)
k()
rm(j, k)
#
# The previous code works because k preserves the environment in which it was
# definded and because the environment inclyudes the value of y
#

## Function vs. variables
#
# Finding function works exactly the same way as finding variables.
l <- function(x) x + 1
m <- function(){
  l <- function(x) x * 2
  l(10)
}
m() # 20
l(10) # 11
rm(m, l)
#
# (!) If using a name in context where it cannot be other thing that function
# e.g. f(3), R will ignore objets that are not functions while it is searching:
#
n <- function(x) x / 2
o <- function(){
  n <- 10
  n(n)
}
o()
rm(n, o)
#

## A fresh start
#
# Example:
#
j <- function(){
  if (!exists('a'))
    a <- 1
  else a <- a + 1
  a
}
j()
#
# The variable a is lost after the function call. Thus the call of function j
# alway return the value 1. Instead if a is created in the Global env level:
#
a <- j()
#
# in the previous call, the value 1 is added in turn into a function call by
# function call
#
rm(a, j)
#
# (?) What happens if the value of a is created and updated to Global env
# from the body of the function ? -> To test after chapter of environment.

## Dynamic lookup
#

#
# R looks for values when the function is RUN, not when the function is created.
#
f <- function() x + 0
x <- 15
f() # 15
x <- 33
f() # 33

#
# (!) With this kind of code, the function is no longer self contain.
# It might be dangerous because some bug can occurs due to versatile environment.
# a way to check:
#
codetools::findGlobals(f)
#
# It returns what is not self contained by the function:
#   * '+'
#   * 'x'
#
# Another way to debug is to assign empty env as the function environment.
# But it brings some other bug because a function cannot be full self contained.
# It generally uses some others functions which depend on other environment.
# It is the case with the function f which uses the function `+`
#
environment(f) <- emptyenv()
f()
# Error in x + 0 : could not find function "+"
# 