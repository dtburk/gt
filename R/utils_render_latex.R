
# Create a vector of LaTeX packages to use as table dependencies
latex_packages <- function() {
  c("amsmath", "booktabs", "caption", "longtable")
}

# Transform a footnote glyph to a LaTeX representation as a superscript
footnote_glyph_to_latex <- function(footnote_glyph) {

  paste0(
    "\\textsuperscript{", footnote_glyph, "}")
}

#' @noRd
latex_body_row <- function(content,
                           type) {

  if (type == "row") {

    return(
      paste(paste(content, collapse = " & "), "\\\\ \n"))

  } else if (type == "group") {

    return(
      paste(paste(content, collapse = " & "), "\\\\ \n"))
  }
}

#' @noRd
latex_heading_row <- function(content) {

  paste0(
    paste(paste(content, collapse = " & "), "\\\\ \n"),
    "\\midrule\n",
    collapse = "")
}

#' @noRd
latex_group_row <- function(group_name,
                            top_border = TRUE,
                            bottom_border = TRUE) {

  paste0(
    ifelse(top_border, "\\midrule\n", ""),
    "\\multicolumn{1}{l}{", group_name,
    "} \\\\ \n",
    ifelse(bottom_border, "\\midrule\n", ""),
    collapse = "")
}

#' @noRd
create_table_start_l <- function(col_alignment) {

  # Allow fixed-width alignment to pass through unmodified
  is_not_fixed_width_align <- function(x) !stringr::str_detect(x, "^p\\{")
  col_alignment <- col_alignment %>%
    purrr::modify_if(is_not_fixed_width_align, ~ substr(.x, 1, 1))

  paste0(
    "\\captionsetup[table]{skip=1pt}\n",
    "\\begin{longtable}{",
    col_alignment %>% paste(collapse = ""),
    "}\n",
    collapse = "")
}

#' Create the columns component of a table
#'
#' @noRd
create_columns_component_l <- function(boxh_df,
                                       output_df,
                                       stub_available,
                                       spanners_present,
                                       stubhead,
                                       col_alignment) {

  # Get the headings
  headings <- boxh_df["column_label", ] %>% unlist() %>% unname()

  # If `stub_available` == TRUE, then replace with a set stubhead
  #   caption or nothing
  if (stub_available && length(stubhead) > 0) {

    headings <- rlang::prepend(headings, stubhead$label)

  } else if (stub_available) {

    headings <- rlang::prepend(headings, "")
  }

  table_col_headings <-
    paste0(latex_heading_row(content = headings), collapse = "")

  if (spanners_present) {

    # Get vector of group labels (spanners)
    spanners <- boxh_df["group_label", ] %>% unlist() %>% unname()

    # Promote column labels to the group level wherever the
    # spanner label is NA
    spanners[is.na(spanners)] <- headings[is.na(spanners)]

    if (stub_available) {
      spanners <- c(NA_character_, spanners)
    }

    spanners_lengths <- rle(spanners)

    multicol <- c()
    cmidrule <- c()

    for (i in seq(spanners_lengths$lengths)) {

      if (spanners_lengths$lengths[i] > 1) {

        if (length(multicol) > 0 &&
            grepl("\\\\multicolumn", multicol[length(multicol)])) {
          multicol <- c(multicol, "& ")
        }

        multicol <-
          c(multicol,
            paste0(
              "\\multicolumn{", spanners_lengths$lengths[i],
              "}{c}{",
              spanners_lengths$values[i],
              "} "))

        cmidrule <-
          c(cmidrule,
            paste0(
              "\\cmidrule(lr){",
              sum(spanners_lengths$lengths[1:i]) - spanners_lengths$lengths[i] + 1,
              "-",
              sum(spanners_lengths$lengths[1:i]),
              "}"))

      } else {
        multicol <- c(multicol, "& ")
      }

    }

    multicol <- paste0(paste(multicol, collapse = ""), "\\\\ \n")
    cmidrule <- paste0(paste(cmidrule, collapse = ""), "\n")

    table_col_spanners <- paste(multicol, cmidrule, collapse = "")

  } else {

    table_col_spanners <- ""
  }

  paste0("\\toprule\n", table_col_spanners, table_col_headings)
}

#' @noRd
create_body_component_l <- function(row_splits,
                                    groups_rows_df,
                                    col_alignment,
                                    stub_available,
                                    summaries_present,
                                    list_of_summaries,
                                    n_rows,
                                    n_cols) {

  # Replace an NA group with an empty string
  if (any(is.na(groups_rows_df$group))) {

    groups_rows_df <-
      groups_rows_df %>%
      dplyr::mutate(
        group_label = ifelse(
          is.na(group_label), "\\vspace*{-5mm}", group_label)) %>%
      dplyr::mutate(
        group_label = gsub("^NA", "\\textemdash", group_label))
  }

  group_rows <-
    create_group_rows(
      n_rows, groups_rows_df, context = "latex")

  data_rows <-
    create_data_rows(
      n_rows, row_splits, context = "latex")

  summary_rows <-
    create_summary_rows(
      n_rows, n_cols, list_of_summaries, groups_rows_df,
      stub_available, summaries_present, context = "latex")

  paste(collapse = "", paste0(group_rows, data_rows, summary_rows))
}

#' @noRd
create_table_end_l <- function(footnotes_resolved,
                               opts_df,
                               source_note,
                               n_cols) {

  footnote_component <- create_footnote_component_l(
    footnotes_resolved,
    opts_df,
    n_cols
  )
  source_note_component <- create_source_note_component_l(source_note, n_cols)

  paste0(
    "\\bottomrule\n",
    source_note_component,
    footnote_component,
    "\\end{longtable}\n",
    collapse = "")
}

#' @noRd
create_footnote_component_l <- function(footnotes_resolved,
                                        opts_df,
                                        n_cols) {

  # If the `footnotes_resolved` object has no
  # rows, then return an empty footnotes component
  if (nrow(footnotes_resolved) == 0) {
    return("")
  }

  footnotes_tbl <-
    footnotes_resolved %>%
    dplyr::select(fs_id, text) %>%
    dplyr::distinct()

  # Get the separator option from `opts_df`
  separator <- opts_df %>%
    dplyr::filter(parameter == "footnote_sep") %>%
    dplyr::pull(value)

  # Convert an HTML break tag to a Latex line break
  separator <-
    separator %>%
    tidy_gsub("<br\\s*?(/|)>", "\\newline") %>%
    tidy_gsub("&nbsp;", " ")

  # Create the footnotes block
  footnote_component <-
    paste0(
      "\\multicolumn{", n_cols, "}{l}{",
      # "\\vspace{-5mm}\n",
      # "\\begin{minipage}{\\linewidth}\n",
      paste0(
        footnote_glyph_to_latex(footnotes_tbl[["fs_id"]]),
        footnotes_tbl[["text"]] %>%
          unescape_html() %>%
          markdown_to_latex()),
      "} \\\\ \n", collapse = "")

  footnote_component
}

#' @noRd
create_source_note_component_l <- function(source_note, n_cols) {

  # If the `footnotes_resolved` object has no
  # rows, then return an empty footnotes component
  if (length(source_note) == 0) {
    return("")
  }

  source_note <- source_note[[1]]

  # Create the source notes block
  source_note_component <-
    paste0(
      "\\multicolumn{", n_cols, "}{l}{",
      paste0(
        source_note %>% as.character()),
      "} \\\\ \n", collapse = "")

  source_note_component
}

#' Place LaTeX table in a table environment
#'
#' Place LaTeX table in a table environment by enclosing it in
#' \code{\\begin\{table\}} and \code{\\end\{table\}} tags.
#'
#' @param tab_latex The LaTeX table as a length-one character vector.
#'
#' @export
entable_latex <- function(tab_latex, top = TRUE) {
  if (top) {
    paste0("\\begin{table}[t]\n", tab_latex, "\\end{table}\n\n")
  } else {
    paste0("\\begin{table}\n", tab_latex, "\\end{table}\n\n")
  }

}


#' Place LaTeX table in landscape orientation
#'
#' Place LaTeX table in landscape orientation (requires pdflscape package)
#'
#' @param tab_latex The LaTeX table as a length-one character vector.
#'
#' @export
enlandscape_latex <- function(tab_latex) {
  paste0("\\begin{landscape}\n\n", tab_latex, "\n\\end{landscape}")
}


#' Interpolate degree symbol
#'
#' Interpolate degree symbol by replacing the text \code{@circ@} with
#'     \code{$^\\circ$}.
#'
#' @param tab_latex The LaTeX table as a length-one character vector.
#'
#' @export
interp_degree_sym_latex <- function(tab_latex) {
  stringr::str_replace_all(tab_latex, stringr::fixed("@circ@"), "$^\\circ$")
}


#' Interpolate in-text citation
#'
#' Interpolate in-text citation by replacing the text \code{@cite_key} with
#'     \code{\\cite{cite_key}}.
#'
#' @param tab_latex The LaTeX table as a length-one character vector.
#'
#' @export
interp_citation_latex <- function(tab_latex) {
  cites <- stringr::str_extract_all(tab_latex, "@[^ .,]+")[[1]]
  unescaped_cites <- stringr::str_replace_all(cites, stringr::fixed("\\_"), "_")
  for (i in seq_along(cites)) {
    tab_latex <- stringr::str_replace(
      tab_latex,
      fixed(cites[i]),
      unescaped_cites[i]
    )
  }
  stringr::str_replace_all(tab_latex, "@([^ .,]+)", "\\\\cite{\\1}")
}
