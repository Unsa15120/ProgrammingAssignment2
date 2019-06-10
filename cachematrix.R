#The cacheMatrix.R file contains two functions, makeCacheMatrix() and CacheSolve().

#First we talk about first function "makeCacheMatrix()".

#Step 1: Initialize objects
#First initialization of two objects, x and m.
#makeCacheMatrix(x = matrix()) {
#m <- NULL
#x is initialized as a function argument , m is set to NULL.
#Step 2: Define the "behaviors" or functions for objects of type makeCacheMatrix()
#After initializing key objects that store key information within makeCacheMatrix(), the code provides four basic behaviors that are typical for data elements within an object-oriented program. They're called "getters and settters,"
#First makeCacheMatrix() defines the set() function.
#set <- function(y) {
#   x <<- y
#    m <<- NULL
#}
#set() takes an argument that is named as y.
#Within set() we use the <<- form of the assignment operator, which assigns the value on the right side of the operator to an object in the parent environment named by the object on the left side of the operator.
#When set() is executed, it does two things:
#1)Assign the input argument to the x object in the parent environment, and
#2)Assign the value of NULL to the m object in the parent environment.
#Second, makeCacheMatrix() defines the getter for the matrix "x".
#get <- function() x
#This function takes advantage of the lexical scoping features in R. Since the symbol x is not defined within get(), R retrieves it from the parent environment of makeCacheMatrix().
#Third, makeCacheMatrix() defines the setter for the inverse of m.
#setInverse <- function(solve) m <<- solve
#Finally, makeCacaheMatrix() defines the getter for the inverse of m. Using lexical scoping to find the correct symbol m to retrieve its value.
#getInverse <- function() m
#The last section of code assigns each of these functions as an element within a list(), and returns it to the parent environment.
#list(set = set, get = get,setInverse = setInverse,getInverse=getInverse)

#Now we talk about second function cacheSolve()


#cacheSolve() is required retrieve the inverse of matrix from an object of type makeCacheMatrix().
#cacheSolve<- function(x, ...) {
#Function starts with a single argument, x, and an ellipsis that allows the caller to pass
#additional #arguments into the function.
#Next, the function attempts to retrieve a inverse from the object passed in as the argument. 
#First, it calls the getInverse() function on the input object.
#m <- x$getInverse()
#Then it checks to see whether the result is NULL. Since makeCacheVector() sets the cached 
#Inverse to NULL #whenever a new vector is set into the object, if the value here is not equal to NULL, 
#we have a valid, #cached inverse and can return it to the parent environment
#if(!is.null(m)) {
#         message("getting cached data")
#        return(m)
#  }
#If the result of !is.null(m) is FALSE, cacheSolve() gets the matrix from the input object, compute a inverse,
#uses the setInverse() function on the input object to set the inverse in the input object, and then 
#returns the value of the inverse to the parent environment by printing the inverse object.

#     data <- x$get()
#    m <- solve(data, ...)
#   x$setInverse(m)
#  m



## Write a short comment describing this function

## This Function create a special matrix object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
  
  m<-NULL
  set<-function(y){
    x<<-y
    m<<-NULL
  }
  
  get<-function()x
  setinverse<-function(solve) m<<-solve
  getinverse<-function()m
  list(set=set,get=get,setinverse=setinverse,getinverse=getinverse)
  
}


## Write a short comment describing this function

## This function computes the inverse of the special "matrix" returned by makeCacheMatrix() above.If the inverse has already been calculated then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  
  m<-x$getinverse()
  if(!is.null(m)){
    message("Getting cache data")
    return(m)
  }
  data<-x$get()
  m<-solve(data,...)
  x$setinverse(m)
  m
}


a<-makeCacheMatrix(matrix(c(1,2,3,4),nrow = 2,ncol = 2))
a$get()
a$getinverse()
cacheSolve(a)
cacheSolve(a)

a$set(matrix(c(5,6,7,8),nrow = 2,ncol = 2))
a$get()
cacheSolve(a)
