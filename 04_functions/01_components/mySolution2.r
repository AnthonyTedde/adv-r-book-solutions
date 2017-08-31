#################################################################
# 2 This code makes a list of all functions in the base package.
#################################################################

objs <- mget(ls('package:base'), inherits = T)
funs <- Filter(is.function, objs)

################### 
# Decrypt the code
################### 

# List all components of the base package:
list_base_package <- ls('package:base')

# How many components are listed in this package:
length(list_base_package) # 1220

# mget function
# -> Search by name for an object (get) or [0,n] objets (mget)
#
# Example of get (it will return the function source.)
# formals, body and environment could be called for the return of that get
#
s <- get('source')
formals(s)
body(s)
environment(s)
class(s) # function
typeof(s) # closure
str(s) # function(all args listed)
# 
# Example of mget
# 
function_list <- mget(list_base_package, inherits = T)
# if inherit is not provided, I get the following error:
# [inherit]: Should the enclosing frames of the environment be searched?
mget(list_base_package, inherits = F)
# What information about mget return value:
str(function_list) # List of 1200
class(function_list) # "list"
typeof(function_list) # "list"
# How to get information about the list items of mget return value:
function_list[1]
function_list[[1]]
names(function_list[1])
 
################################################
# a. Which base function has the most arguments
################################################# 

args_1 <- args <- lapply(funs, function(x){formals(x)})
args_2 <- lapply(funs, formals)

mean(args_1 == args_2)
typeof(args_1)
args_1[[3]]

is.null(intersect(args_1, args_2))
mean(args_1 %in% args_2) 
# Previous line proove that even args_1 and args_2 are generated not the same way, there are equal.
# But interset give all data in args_1 and also in args_2

# args gives a list of all arguments of function of list funs.
len <- lapply(args, length)
len[len == max(unlist(len))] # Gives 'scan'
get('scan')
str(formals(scan)) # List of 22

# More concise method:
which.max(lapply(funs, function(x){length(formals(x))}))
length(formals(funs[[941]])) # 22
names(funs[941]) # scan


# Which have no argument
n <- which(sapply(funs, function(x){length(formals(x)) == 0 }))
names(n) # All functions with no argument.
mean(unlist(lapply(mget(names(n), inherits = T), is.primitive)))
# -> 80.97% are primitive functions.

# Other method:
funs[lapply(funs, function(x) length(formals(x))) == 0]
typeof(lapply(funs, function(x) length(formals(x)))==0)
class(lapply(funs, function(x) length(formals(x)))==0)
str(lapply(funs, function(x) length(formals(x)))==0)

# How to include .Primitive function:
# Because of .Primitive function return NULL we cannot use it:
formals(`-`)
# Following return the arguments of primitive function
args(`-`)
formals(args(`-`))
length(formals(args(`-`)))
# Let's apply it to script above:
funs[lapply(funs, function(x) length(formals(args(x)))) == 0]

# Which have no argument
n <- which(sapply(funs, function(x){length(formals(args(x))) == 0 }))
names(n) # All functions with no argument.
mean(unlist(lapply(mget(names(n), inherits = T), is.primitive)))
# -> 41.89% are primitive functions.

# Filter only the primitive function:
# objs <- mget(ls('package:base'), inherits = T)
primitive.funs <- Filter(is.primitive, objs)