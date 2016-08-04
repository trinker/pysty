pysty   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Build
Status](https://travis-ci.org/trinker/pysty.svg?branch=master)](https://travis-ci.org/trinker/pysty)
[![Coverage
Status](https://coveralls.io/repos/trinker/pysty/badge.svg?branch=master)](https://coveralls.io/r/trinker/pysty?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
**pysty** a Python style packages importing using the common forms of:
`import PACKAGE`, `import PACKAGE as ALIAS`, or
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
- submit suggestions and bug-reports at: <https://github.com/trinker/pysty/issues>    
- send a pull request on: <https://github.com/trinker/pysty/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    


Table of Contents
============

-   [Installation](#installation)
-   [Contact](#contact)
-   [Functions](#functions)
-   [Usage](#usage)

Functions
============


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
    dp::arrange
    dp:::wrap
    ls()

    get_imports()
    get_imports_functions()

    clear_imports()

    ## It's all gone
    l_ply
    dp::arrange
    dp:::wrap
    ls()

    get_imports()
    get_imports_functions()