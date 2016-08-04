# environments for storing pysty info
.pps <- new.env(hash=TRUE, parent = emptyenv())
.ppsf <- new.env(hash=TRUE, parent = emptyenv())

## parsing tool to check that commands meet specification
parse_check <- function(...){

    lib <- gsub("\\s+", " ", trimws(strsplit(gsub("^\\s*\n|\n\\s*$", "", paste(unlist(list(...)), collapse = ";")), "\\s*(;|\n)\\s*")[[1]]))

    impfro <- grepl("^(import|from)", lib)

    if (any(!impfro)) {
        stop(paste0(
            "The following import commands are malformed:\n",
            paste(paste0("   - ", grep("^(import|from)", lib, value=TRUE, invert=TRUE)), collapse = "\n"),
            "\n\nStart commands with either `import` OR `from`"
        ))
    }

    lib <- gsub("^import\\s+", "", lib)
    libfroms <- grep("^from ", lib, value = TRUE)
    lib <- grep("^from ", lib, value = TRUE, invert = TRUE)

    #check lib spaces
    extra_coms <- !grepl("\\sas\\s", lib) & grepl("\\s", lib)
    if (any(extra_coms)) {
        stop(paste0(
            "The following import commands are malformed:\n\n",
            paste(paste0("   - ", lib[extra_coms]), collapse = "\n"),
            "\n\n`import` commands sould not have multiple spaces unless using an `as` alias\n\nUse the form: `import PACKAGE`"
        ))
    }

    #check lib spaces2
    extra_coms <- grepl("\\sas\\s", lib) & sapply(strsplit(lib, "\\s+"), length) > 3
    if (any(extra_coms)) {
        stop(paste0(
            "The following import commands are malformed:\n\n",
            paste(paste0("   - ", lib[extra_coms]), collapse = "\n"),
            "\n\n`import` with `as` alias should only have commands sould not have > 3 space.\n\nUse the form: `import PACKAGE as ALIAS`"
        ))
    }

    funs <- !grepl("^from [^ ]+ import ([^ ,]+)", libfroms)
    if (any(funs)) {
        stop(paste0(
            "The following from + import commands are malformed:\n\n",
            paste(paste0("   - ", libfroms[funs]), collapse = "\n"),
            "\n\n`from` with `import` uses the form: `from PACKAGE import FUN1, FUN2, FUN_N`"
        ))
    }
}
