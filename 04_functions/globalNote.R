############
# Functions
############
# 
# Function components
# 
# * body()
# * formals()
# * environment()
# 
f <- function(x) x^2

body(f)
formals(f)
environment(f)

# Important note: The previous function does not work for primitive functions

# 
# Lexical function
# 
# -> Scopting is the set of rules that govern how R looks up the value of a symbol
#
# Two type of scoping: lexical / dynamic scoping.
# Here it will focus on lexical scoping
#

#
# Name Masking
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
x <- 2
g <- function(){
  y <- 3
  c(x, y)
}
g()
x <- 3
g()
rm(g)
# ---------------------------------------------------------------------------- #

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
x <- 1
h <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
  i() 
}
h()

# Or the following are equal:
x <- 1
h <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
}
h()()
# By the execution of the previous code, only x and h has been created
# in GlobalEnv
rm(list = ls())
# ---------------------------------------------------------------------------- #

# Closure are functions created by other functions:
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
j <- function(x) {
  y <- 2
  function(){
    c(x, y)
  }
}
k <- j(1)
k()
environment(k)
environmentName(k)
rm(list = ls())
# ---------------------------------------------------------------------------- #
# -> it works because k preserves the environment  in whinch it was defined.
# easily check with function: environment(k)


#
# Function VS Variables
#
# A fresh start
#
# Dynamic lookup


# Everything in a call
add <- function(x, y){x + y}
add(1,1)
n <- c(1,2,3,4,5)
sapply(n, add, 2) # 2 is the y argument.
#####################################################

l <- list(1:3, 5:6, 9:12)
sapply(l, `[`, 2) # Take the second of all stage of the list
# Same as:
sapply(l, function(x){x[2]})
##################################################### 

args <- list(1:10)
mean(args) # does not work as expected:
mean(1:10)

## first possibility:
mean(args[[1]]) 
## or:
do.call(mean, args)

## Other argument could be sent to the mean function (or other one):
args <- list(c(1,2,3,4,5,6,NA_integer_), na.rm = T)
# following will work:
do.call(mean, args)
# but following does not work
args <- list(c(1,2,3,4,5,6,NA_integer_))
do.call(mean, args) # return: NA, due to NA_integer_

## What if several stage in the list?
args <- list(1:10, 1:20, 5:50)
## Means of all separate different stage:
sapply(args, mean)
## with global mean:
mean(sapply(args, mean))

## Missing arguments:
f <- function(a){missing(a)}
f() # TRUE
f(1) # FALSE
# What about if default value has been defined:
f <- function(a = 1){missing(a)}
f() # TRUE
