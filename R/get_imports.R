#' View Imported Packages
#'
#' View imported packages (using \pkg{pysty}) and aliases.
#'
#' @param \ldots ignored.
#' @return Returns a data.frame of packages and aliases.
#' @export
#' @examples
#' \dontrun{
#' add_imports('import lattice as lat')
#' get_imports()
#' }
get_imports <- function(...){
    x <- as.list(.pps)
    out <- data.frame(package = unlist(x, use.names = FALSE), alias = names(x), stringsAsFactors = FALSE)
    if (nrow(out) == 0) return(out)
    out[order(out[['package']]), ]
}

