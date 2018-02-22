#' Help for Unexported Functions/Packages
#'
#' Get help for unexported functions or packages.
#'
#' @param topic Usually, a name or character string specifying the topic for which help is sought.
#' @param \ldots ignored.
#' @export
#' @importFrom utils help
#' @examples
#' \dontrun{
#' library(pysty)
#'
#' add_imports('
#'
#' import dplyr as dp
#' import MASS as m
#' import ggplot2 as gg
#' import tidyr
#' from plyr import l_ply, rbind.fill
#'
#' ')
#'
#' h(dp::select)
#' h(m::select)
#' h(dp)
#' }
h <- function(topic, ...){

    e2 <- as.character(substitute(topic))

    if (length(e2) == 1) {
        hout <- try(utils::help(.pps[[e2]]), silent = TRUE)
        if (inherits(hout, 'try-error')) utils::help(e2)
    } else {
        utils::help(e2[3], .pps[[e2[2]]])
    }
}




