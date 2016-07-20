## Example usage:
##
## matrix <- matrix(1:4, 3, 3)
## wrappedMatrix <- makeCacheMatrix(matrix)
## cacheSolve(wrappedMatrix)
## wrappedMatrix$getInverse()
## cacheSolve(wrappedMatrix) ## outputs message "getting cached inverse"

## Special Matrix object that adds functionality to set and get the inverse

makeCacheMatrix <- function(matrix = matrix()) {

    invertedMatrix <- NULL
    set <- function(newMatrix) {
        matrix <<- newMatrix
        invertedMatrix <<- NULL
    }
    get <- function() matrix
    setInverse <- function(newInvertedMatrix) invertedMatrix <<- newInvertedMatrix
    getInverse <- function() invertedMatrix
    
    list(set = set, 
         get = get, 
         setInverse = setInverse, 
         getInverse = getInverse)
}


## Helper function for the CacheMatrix object that calculates 
## inverse of matrix if not already calculated, and if already 
## calculated returns cached response.

cacheSolve <- function(invertibleMatrix, ...) {
    invertedMatrix <- invertibleMatrix$getInverse()
    
    if ( !is.null(invertedMatrix) ) {
        message("getting cached inverse")
        return(invertedMatrix)
    }
    
    invertedMatrix <- solve(invertibleMatrix$get())
    invertibleMatrix$setInverse(invertedMatrix)
}
