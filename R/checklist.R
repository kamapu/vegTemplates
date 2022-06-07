#' @name checklist
#'
#' @title Taxonomic Check-List
#'
#' @description
#' Template for a taxonomic check-list generated from [taxlist-class] objects.
#' The most important functions called in the source code are [print_name()],
#' [indented_list()], [write_rmd()], and [render_rmd()].
#'
#' @param object A [taxlist-class] object used as main input.
#' @param exclude A character vector including the name of taxonomic ranks that
#'     will be excluded of formatting in italics (excluded in the call to
#'     [print_name()]).
#' @param indent A character value indicating the single indentation, which
#'     will be multiplied by the taxonomic rank going from the top to the
#'     bottom. Indentation can be either cancellec by `indent = ""` or can be
#'     specified for determined taxonomic ranks by naming elements of the input
#'     vector after the ranks.
#' @param prefix A character value or character vector named by taxonomic ranks,
#'     which will be used as prefix.
#' @param suffix The same as `prefix` but it will be placed at the end of the
#'     line.
#' @param print_args A list with elements named after parameters (arguents) of
#'     the function [print_name()].
#' @param rmd_args A list with elements named after parameters (arguments) of
#'     the function [write_rmd()].
#' @param render_args A list with elements named after parameters (arguments) of
#'     the function [render_rmd()].
#' @param title A character value with the title of the document.
#' @param output A character value indicating the format of ouput using
#'     rmarkdown.
#' @param output_file Name of the rendered otuput file. It will be passed to
#'     [write_rmd()].
#' @param ... Further arguments. In taxlist-method they will be passed to the
#'     function [indented_list()].
#'
#' @rdname checklist
#' @export
checklist <- function(object, ...) {
  UseMethod("checklist", object)
}

#' @rdname checklist
#' @examples
#' \dontrun{
#' library(taxlist)
#'
#' ## Subset of family Piperaceae
#' Piperaceae <- subset(Easplist, TaxonName == "Piperaceae",
#'   slot = "taxonNames", keep_children = TRUE, keep_parents = TRUE
#' )
#'
#' ## Simple checklist
#' checklist(Piperaceae, output_file = "piperaceae", exclude = "family")
#'
#' ## Families as sections in document
#' checklist(Piperaceae,
#'   output_file = "piperaceae2", exclude = "family",
#'   prefix = c(family = "# ")
#' )
#'
#' ## Families as sections and small captions for the whole taxonomic list
#' checklist(Easplist,
#'   output_file = "ea-splist", exclude = "family",
#'   prefix = c(family = "# \\sc{"), suffix = c(family = "}")
#' )
#' }
#'
#' @aliases checklist,taxlist-method
#' @method checklist taxlist
#' @export
checklist.taxlist <- function(object, exclude, indent = "&nbsp;", prefix = "",
                              suffix = "",
                              print_args = list(),
                              rmd_args = list(
                                "header-includes" =
                                  "- \\setlength{\\parskip}{0pt}"
                              ),
                              render_args = list(),
                              title = "Taxonomic Checklist", output =
                                "pdf_document",
                              output_file = tempfile(), ...) {
  sp_names <- indented_list(object, print = FALSE, ...)
  if (!missing(exclude)) {
    idx <- !paste(sp_names$Level) %in% exclude
  } else {
    idx <- rep(TRUE, nrow(sp_names))
  }
  sp_names$formatted_name <- with(sp_names, {
    TaxonName[idx] <- do.call(
      print_name,
      c(list(object = TaxonName[idx]), print_args)
    )
    TaxonName
  })
  # Prefix
  if (length(indent) == 1 & is.null(names(indent))) {
    if (indent == "") {
      indent <- rep(indent, length(levels(sp_names$Level)))
    } else {
      indent <- sapply(rev(0:(length(levels(sp_names$Level)) - 1)),
        function(x, y) paste0(rep(y, x), collapse = ""),
        y = indent
      )
    }
    names(indent) <- levels(sp_names$Level)
  }
  no_indent <- rep("", length(levels(sp_names$Level)[
    !levels(sp_names$Level) %in% names(indent)
  ]))
  names(no_indent) <- levels(sp_names$Level)[!levels(sp_names$Level) %in%
    names(indent)]
  indent <- c(indent, no_indent)
  sp_names$indent <- replace_x(paste(sp_names$Level),
    old = names(indent),
    new = indent
  )
  # prefix
  if (length(prefix) == 1 & is.null(names(prefix))) {
    prefix <- rep(prefix, length(levels(sp_names$Level)))
    names(prefix) <- levels(sp_names$Level)
  }
  no_prefix <- rep("", length(levels(sp_names$Level)[
    !levels(sp_names$Level) %in% names(prefix)
  ]))
  names(no_prefix) <- levels(sp_names$Level)[!levels(sp_names$Level) %in%
    names(prefix)]
  prefix <- c(prefix, no_prefix)
  sp_names$prefix <- replace_x(paste(sp_names$Level),
    old = names(prefix),
    new = prefix
  )
  # suffix
  if (length(suffix) == 1 & is.null(names(suffix))) {
    suffix <- rep(suffix, length(levels(sp_names$Level)))
    names(suffix) <- levels(sp_names$Level)
  }
  no_suffix <- rep("", length(levels(sp_names$Level)[
    !levels(sp_names$Level) %in% names(suffix)
  ]))
  names(no_suffix) <- levels(sp_names$Level)[!levels(sp_names$Level) %in%
    names(suffix)]
  suffix <- c(suffix, no_suffix)
  sp_names$suffix <- replace_x(paste(sp_names$Level),
    old = names(suffix),
    new = suffix
  )
  # Write Rmd file
  rmd_file <- do.call(write_rmd, c(list(
    title = title, output = output,
    body = with(
      sp_names,
      paste0(paste(prefix, indent, formatted_name, suffix),
        collapse = "\n\n"
      )
    )
  ), rmd_args))
  do.call(render_rmd, c(list(input = rmd_file),
    output_file = output_file,
    render_args
  ))
}
