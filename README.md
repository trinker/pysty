-   [Installation](#installation)
-   [Contact](#contact)
-   [Functions](#functions)
-   [Usage](#usage)
    -   [It's all gone: Try it!](#its-all-gone-try-it)

[![Build
Status](https://travis-ci.org/trinker/pysty.svg?branch=master)](https://travis-ci.org/trinker/pysty)
[![Coverage
Status](https://coveralls.io/repos/trinker/pysty/badge.svg?branch=master)](https://coveralls.io/r/trinker/pysty?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
**pysty** is a Python style packages importing using the common forms
of: `import PACKAGE`, `import PACKAGE as ALIAS`, or
`from PACKAGE import FUN1, FUN2, FUN_N`. The latter even allows for
importing non-exported functions into the global environment.

This package is a proof of concept that such light weight importing and
aliasing could be possible. A user would use **pysty** because one wants
to be explicit in all the functions used in a script as to what package
they come from. Aliasing package names is convenient for longer named
packages.

Installation
============

To download the development version of **pysty**:

Download the [zip ball](https://github.com/trinker/pysty/zipball/master)
or [tar ball](https://github.com/trinker/pysty/tarball/master),
decompress and run `R CMD INSTALL` on it, or use the **pacman** package
to install the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/pysty")

Contact
=======

You are welcome to:  
- submit suggestions and bug-reports at:
<https://github.com/trinker/pysty/issues>  
- send a pull request on: <https://github.com/trinker/pysty/>  
- compose a friendly e-mail to: <tyler.rinker@gmail.com>

Functions
=========

There are only a few functions in the package:

<table>
<thead>
<tr class="header">
<th align="left">Function</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>add_imports</code></td>
<td align="left">Python style importing</td>
</tr>
<tr class="even">
<td align="left"><code>clear_imports</code></td>
<td align="left">Remove a named import(s) or all imports</td>
</tr>
<tr class="odd">
<td align="left"><code>get_imports</code></td>
<td align="left">See imported packages</td>
</tr>
<tr class="even">
<td align="left"><code>get_imports_functions</code></td>
<td align="left">See imported functions</td>
</tr>
</tbody>
</table>

Usage
=====

    library(pysty)

    add_imports('

    import dplyr as dp
    import ggplot2 as gg
    import tidyr
    from plyr import l_ply, rbind.fill

    ')

    l_ply

    ## function (.data, .fun = NULL, ..., .progress = "none", .inform = FALSE, 
    ##     .print = FALSE, .parallel = FALSE, .paropts = NULL) 
    ## {
    ##     if (is.character(.fun) || is.list(.fun)) 
    ##         .fun <- each(.fun)
    ##     if (!is.function(.fun)) 
    ##         stop(".fun is not a function.")
    ##     pieces <- as.list(.data)
    ##     n <- length(pieces)
    ##     if (n == 0) 
    ##         return(invisible())
    ##     if (.parallel && .progress != "none") {
    ##         message("Progress disabled when using parallel plyr")
    ##         .progress <- "none"
    ##     }
    ##     progress <- create_progress_bar(.progress)
    ##     progress$init(n)
    ##     on.exit(progress$term())
    ##     if (.parallel && .print) {
    ##         message("Printing disabled for parallel processing")
    ##         .print <- FALSE
    ##     }
    ##     do.ply <- function(i) {
    ##         piece <- pieces[[i]]
    ##         if (.inform) {
    ##             res <- try(.fun(piece, ...))
    ##             if (inherits(res, "try-error")) {
    ##                 piece <- paste(utils::capture.output(print(piece)), 
    ##                   collapse = "\n")
    ##                 stop("with piece ", i, ": \n", piece, call. = FALSE)
    ##             }
    ##         }
    ##         else {
    ##             res <- .fun(piece, ...)
    ##         }
    ##         if (.print) {
    ##             print(res)
    ##         }
    ##         progress$step()
    ##     }
    ##     if (.parallel) {
    ##         setup_parallel()
    ##         .paropts$.combine <- function(...) NULL
    ##         i <- seq_len(n)
    ##         fe_call <- as.call(c(list(quote(foreach::foreach), i = i), 
    ##             .paropts))
    ##         fe <- eval(fe_call)
    ##         foreach::`%dopar%`(fe, do.ply(i))
    ##     }
    ##     else {
    ##         for (i in seq_len(n)) {
    ##             do.ply(i)
    ##         }
    ##     }
    ##     invisible()
    ## }
    ## <environment: namespace:plyr>

    dp::arrange

    ## function (.data, ...) 
    ## {
    ##     arrange_(.data, .dots = lazyeval::lazy_dots(...))
    ## }
    ## <environment: namespace:dplyr>

    dp:::wrap

    ## function (..., indent = 0) 
    ## {
    ##     x <- paste0(..., collapse = "")
    ##     wrapped <- strwrap(x, indent = indent, exdent = indent + 
    ##         2, width = getOption("width"))
    ##     paste0(wrapped, collapse = "\n")
    ## }
    ## <environment: namespace:dplyr>

    ls()

    ## [1] "desc"       "l_ply"      "loc"        "rbind.fill" "regex"     
    ## [6] "ver"        "verbadge"

    get_imports()

    ##   package alias
    ## 1   dplyr    dp
    ## 2 ggplot2    gg
    ## 3   tidyr tidyr

    get_imports_functions()

    ##   package      alias
    ## 1    plyr rbind.fill
    ## 2    plyr      l_ply

    clear_imports()

It's all gone: Try it!
----------------------

    l_ply
    dp::arrange
    dp:::wrap
    ls()

    get_imports()
    get_imports_functions()
