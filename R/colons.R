#' Double & Triple Colon Operators
#'
#' Replaces the \pkg{base} colon operators with \pkg{pysty} varients that allow for
#' aliased package names.
#'
#' @param x A package or \pkg{pysty} alias.
#' @param y A function (exported or non-exported) in that package.
#' @export
#' @seealso \code{\link[base]{::}}
#' @rdname colons
#' @examples
#' \dontrun{
#' add_imports('import lattice as lat')
#' lat::xyplot
#' lat:::wireframe.matrix
#' }
'::' <- function(x, y) {
    pkg <- as.character(substitute(x))
    name <- as.character(substitute(y))
    if (is.null(.pps[[pkg]])) {
        return(getExportedValue(pkg, name))
    }
    getExportedValue(.pps[[pkg]], name)
}

#' @rdname colons
#' @export
`:::` <- function(x, y) {
    pkg <- as.character(substitute(x))
    name <- as.character(substitute(y))
    if (is.null(.pps[[pkg]])) {
        return(get(name, envir = asNamespace(pkg), inherits = FALSE))
    }
    get(name, envir = asNamespace(.pps[[pkg]]), inherits = FALSE)
}

