#' Clear the \pkg{pysty} Environments
#'
#' Clear the imports from the \pkg{pysty} environments as well as any functions
#' with those package name(s) from the global enviroment.
#'
#' @param \ldots Quoted package names to remove from the \pkg{pysty} environments
#' as well as any functions with those package name(s) from the global enviroment.
#' @param pos Where to do the assignment.  If no arguments are passed all
#' enviroments will be cleared.
#' @param envir The \code{\link[base]{environment}} to use.
#' @export
#' @seealso \code{\link[base]{assign}},
#' \code{\link[base]{get}}
#' @examples
#' \dontrun{
#' add_imports('import dplyr as dp', 'from lattice import xyplot, qq')
#' get_imports(); get_imports_functions();ls(pattern='^(qq|xyplot)$')
#' clear_imports()
#' get_imports(); get_imports_functions();ls(pattern='^(qq|xyplot)$')
#' }
clear_imports <- function(..., pos = 1, envir = as.environment(pos)){
    removes <- unlist(list(...))

    rmpres <- is.null(removes)
    if (rmpres) removes <- ls(.pps)
    funs <- unlist(as.list(.ppsf))
    if (!is.null(funs)){
        if(!rmpres){
            rm(list = names(funs[funs %in% removes]), envir = envir)
            rm(list = names(funs[funs %in% removes]), envir = .ppsf)
        } else {
            rm(list = ls(.ppsf), envir = envir)
            rm(list = ls(.ppsf), envir = .ppsf)
        }
    }
    suppressWarnings(rm(list = removes, envir = .pps))
}

