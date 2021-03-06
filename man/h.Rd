% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/help.R
\name{h}
\alias{h}
\title{Help for Unexported Functions/Packages}
\usage{
h(topic, ...)
}
\arguments{
\item{topic}{Usually, a name or character string specifying the topic for which help is sought.}

\item{\ldots}{ignored.}
}
\description{
Get help for unexported functions or packages.
}
\examples{
\dontrun{
library(pysty)

add_imports('

import dplyr as dp
import MASS as m
import ggplot2 as gg
import tidyr
from plyr import l_ply, rbind.fill

')

h(dp::select)
h(m::select)
h(dp)
}
}
