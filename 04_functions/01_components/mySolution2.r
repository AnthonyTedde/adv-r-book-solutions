# 2
objs <- mget(ls('package:base'), inherits = T)
funs <- Filter(is.function, objs)

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