library(magrittr)

#' Determine if the given integer is even or odd
#'
#' @param number Integer
#'
#' @return "even" or "odd"
#' @export
#'
#' @examples
#' parity(3) # odd
#' parity(4) # even
parity <- function(number) {
  list(parity = if (as.integer(number) %% 2 == 0) "even" else "odd")
}

#' A nullary function that returns the current version of R
#'
#' @return character
#' @export
#'
#' @examples
#' hello()
hello <- function() {
  list(response = paste("Hello from", version$version.string))
}


#' A function that takes json data and filters it for the value we want
#'
#' @return character
#' @importFrom magrittr %>%
#' @export
#' 
#' @examples
#' filterPosts()

filterPosts <- function(userid) {
  # link to the API output as a JSON file
  url_json <- "https://jsonplaceholder.typicode.com/posts"
  
  # get the raw json into R
  raw_json <- jsonlite::fromJSON(url_json)
  
  #filter out for the userid
  raw_json %<>% 
    dplyr::filter(userId == userid) %>%
    dplyr::select(body)
  
  #return data
  list(response = jsonlite::toJSON(raw_json))
} 


