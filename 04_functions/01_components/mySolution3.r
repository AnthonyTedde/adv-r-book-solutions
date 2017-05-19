# 3. What are the three important components of a function?
# Code inside -> body()
# List of arguments -> formals() or formals(args(x)) for primitive function
# Location of function's variables -> environment()
# for example, with the function: matrix
body(matrix)
formals(matrix)
environment(matrix)

# Number of arguments of matrix:
length(formals(matrix))
