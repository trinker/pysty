#' Import Packages & Functions
#'
#' Import packages & functions Python style.  Use the forms \code{import PACKAGE},
#' \code{import PACKAGE as ALIAS}, or \code{from PACKAGE import FUN1, FUN2, FUN_N}.
#' Note that if a package is not installed \code{add_imports} will attempt to
#' install from CRAN.  The \code{from PACKAGE import FUN1, FUN2, FUN_N} even
#' allows importing non-exported functions into the global environment.
#'
#' @param \ldots Python style commands for importing packages and functions.
#' @param options A list of named arguments to pass to
#' \code{\link[utils]{install.packages}}.
#' @param pos Where to do the assignment.
#' @param envir The \code{\link[base]{environment}} to use.
#' @export
#' @importFrom utils install.packages
#' @importFrom stats setNames
#' @seealso \code{\link[utils]{install.packages}}
#' @examples
#' \dontrun{
#' add_imports('import lattice as lat')
#' lat::xyplot
#' get_imports()
#'
#' file_ext
#' add_imports('from lattice import xyplot, qq')
#' file_ext
#' get_imports_functions()
#'
#' ## Removing packages and functions
#' get_imports()
#' get_imports_functions()
#' clear_imports()
#' get_imports()
#' get_imports_functions()
#' lat::xyplot
#' file_ext
#'
#' ## Options
#' add_imports(list(repos = "http://cran.us.r-project.org"),
#'   'import dplyr as dp', 'import ggplot2 as gg'
#' )
#' clear_imports()
#'
#' ## Mutli-line
#' add_imports('
#'
#' import dplyr as dp
#' import ggplot2 as gg
#' import tidyr
#' from plyr import l_ply, rbind.fill
#'
#' ')
#'
#' l_ply
#' dp::arrange
#' dp:::wrap
#'
#' clear_imports()
#' }
add_imports <- function(..., options = NULL, pos = 1, envir = as.environment(pos)){

    parse_check(...)

    lib <- gsub("^import\\s+", "", gsub("\\s+", " ", trimws(strsplit(gsub("^\\s*\n|\n\\s*$", "", paste(unlist(list(...)), collapse = ";")), "\\s*(;|\n)\\s*")[[1]])))

    libfroms <- grep("^from ", lib, value = TRUE)
    lib <- grep("^from ", lib, value = TRUE, invert = TRUE)

    packs <- lapply(lib, function(x){
        y <- unlist(strsplit(x, " as "))
        if (length(y) == 1) y[2] <- y[1]
        imps <- get_imports()
        if (y[[1]] %in% imps[['package']]) {
            clear_imports(imps[imps[['package']] %in% y[[1]], 'alias'])
        }
        assign(y[2], y[1], envir = .pps)
    })

    froms <- length(libfroms) > 0
    if (froms) {
        libfroms <- gsub("^from " , "", libfroms)
        libfroms <- strsplit(sub("\\simport\\s", "<<<.splithere.>>>", libfroms), "<<<\\.splithere\\.>>>")
        libs2 <- sapply(libfroms, `[[`, 1)
        funs <- setNames(lapply(sapply(libfroms, `[[`, 2), function(x) strsplit(x, "\\s*,\\s*")[[1]]), libs2)
        packs <- c(packs, libs2)
    }

    avail <- list.files(.libPaths())
    .install_packages <-  install.packages

    if (!is.null(options)){
        invisible(lapply(seq_along(options), function(i) {
            formals(.install_packages)[[names(options)[i]]] <<- options[[i]]
        }))
    }

    checks <- invisible(lapply(sapply(packs, `[`, 1), function(x){
        if (!x %in% avail) {
            try(suppressWarnings(.install_packages(x)), silent=TRUE)
        }
    }))

    non_imports <- sapply(packs, `[`, 1)[!sapply(packs, `[`, 1) %in% avail]
    if (length(non_imports) > 0) {
        warning(paste0("\nThe following package(s) could not be imported:\n\n", paste(non_imports, collapse = ", "), "\n"))
        clear_imports(non_imports)
    }

    if (froms) {

        assigns <- invisible(lapply(seq_along(funs), function(i) {

            lapply(funs[[i]], function(x){
                try(assign(
                    x,
                    get(x, envir = asNamespace(names(funs)[i]), inherits = FALSE),
                    envir = envir
                ), silent=TRUE)
            })
        }))

        fun_df <- data.frame(
            package = rep(names(funs), sapply(funs, length)),
            fun = unlist(funs, use.names = FALSE),
            error = sapply(unlist(assigns, recursive = FALSE), inherits, "try-error"),
            stringsAsFactors = FALSE
        )

        if (any(fun_df[['error']])) {
            errors <- fun_df[fun_df[['error']], ]
            nons <- paste(errors[['package']], errors[['fun']], sep = "::", collapse = ", ")
            warning(paste0("\nThe following functions were not able to be imported:\n\n  ", nons, "\n"))
        }

        fun_df <- fun_df[!fun_df[['error']], ]
        invisible(Map(function(x, y){
            assign(y, x, envir = .ppsf)
        }, fun_df[['package']], fun_df[['fun']]))
    }
}

