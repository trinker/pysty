#' Get Functions Imported From Packages
#'
#' Look at the functions that are imported into the global environment from
#' packages.
#'
#' @param \ldots ignored.
#' @return Returns a data.frame of packages and functions.
#' @export
#' @examples
#' \dontrun{
#' add_imports('from lattice import xyplot, qq')
#' get_imports_functions()
#' }
get_imports_functions <- function(...){
    x <- as.list(.ppsf)
    out <- data.frame(package = unlist(x, use.names = FALSE), alias = names(x), stringsAsFactors = FALSE)
    if (nrow(out) == 0) return(out)
    out[order(out[['package']]), ]
}

