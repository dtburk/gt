#' Modify the table output options
#'
#' Modify the options available in a table theme.
#' @inheritParams fmt_number
#' @param table.font.size the table text font size. Can be specified as a
#' single-length character with units of pixels or as a percentage. If provided
#' as a single-length numeric vector, it is assumed that the value is given in
#' units of pixels.
#' @param table.background.color the table background color.
#' @param table.width the width of the table. Can be specified as a
#' single-length character with units of pixels or as a percentage. If provided
#' as a single-length numeric vector, it is assumed that the value is given in
#' units of pixels.
#' @param table.border.top.style the style of the table's top border.
#' @param table.border.top.width the width of the table's top border.
#' @param table.border.top.color the color of the table's top border.
#' @param heading.background.color the background color of the table heading.
#' @param heading.title.font.size the font size of the title in the table
#' heading.
#' @param heading.headnote.font.size the font size of the headnote in the table
#' heading.
#' @param heading.border.bottom.style the style of the heading's bottom border.
#' @param heading.border.bottom.width the width of the heading's bottom border.
#' @param heading.border.bottom.color the color of the heading's bottom border.
#' @param boxhead.background.color the background color of the boxhead.
#' @param boxhead.font.size the font size of the boxhead labels.
#' @param boxhead.font.weight the font weight of the boxhead labels.
#' @param stub_group.background.color the background color of the stub
#' heading.
#' @param stub_group.font.size the font size of the boxhead labels.
#' @param stub_group.font.weight the font weight of the boxhead labels.
#' @param stub_group.border.top the parameters for the top border of the stub
#' heading.
#' @param stub_group.border.bottom the parameters for the bottom border of the
#' stub heading.
#' @param field.border.top the parameters for the top border of the field.
#' @param field.border.bottom the parameters for the bottom border of the field.
#' @param row.padding the amount of padding in each row.
#' @param row.striping.color the color of the background for the striped rows.
#' @param row.striping.include_stub an option for whether to include the stub
#' when striping rows.
#' @param row.striping.include_field an option for whether to include the field
#' when striping rows.
#' @param summary_row.background.color the background color of the summary rows.
#' @param summary_row.padding the amount of padding in each summary row.
#' @param summary_row.text_transform an option to apply text transformations to
#' the label text in each summary row.
#' @param footnote.font.size the font size of the footnotes in the footnote
#' section.
#' @param footnote.padding the amount of padding to apply to the footnote
#' section.
#' @param sourcenote.font.size the font size of the source notes in the source
#' note section.
#' @param sourcenote.padding the amount of padding to apply to the source note
#' section.
#' @family table-part creation/modification functions
#' @export
tab_options <- function(data,
                        table.font.size = NULL,
                        table.background.color = NULL,
                        table.width = NULL,
                        table.border.top.style = NULL,
                        table.border.top.width = NULL,
                        table.border.top.color = NULL,
                        heading.background.color = NULL,
                        heading.title.font.size = NULL,
                        heading.headnote.font.size = NULL,
                        heading.border.bottom.style = NULL,
                        heading.border.bottom.width = NULL,
                        heading.border.bottom.color = NULL,
                        boxhead.background.color = NULL,
                        boxhead.font.size = NULL,
                        boxhead.font.weight = NULL,
                        stub_group.background.color = NULL,
                        stub_group.font.size = NULL,
                        stub_group.font.weight = NULL,
                        stub_group.border.top = NULL,
                        stub_group.border.bottom = NULL,
                        field.border.top = NULL,
                        field.border.bottom = NULL,
                        row.padding = NULL,
                        row.striping.background.color = NULL,
                        row.striping.include.stub = NULL,
                        row.striping.include_field = NULL,
                        summary_row.background.color = NULL,
                        summary_row.padding = NULL,
                        summary_row.text_transform = NULL,
                        footnote.font.size = NULL,
                        footnote.padding = NULL,
                        sourcenote.font.size = NULL,
                        sourcenote.padding = NULL) {

  # Extract the `opts_df` data frame object from `data`
  opts_df <- attr(data, "opts_df", exact = TRUE)

  # table.font.size
  if (!is.null(table.font.size)) {

    if (is.numeric(table.font.size)) {
      table.font.size <- paste0(table.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "table_font_size", table.font.size)
  }

  # table.background.color
  if (!is.null(table.background.color)) {

    opts_df <- opts_df_set(
      opts_df, "table_background_color", table.background.color)
  }

  # table.width
  if (!is.null(table.width)) {

    if (is.numeric(table.width)) {
      table.width <- paste0(table.width, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "table_width", table.width)
  }

  # table.border.top.style
  if (!is.null(table.border.top.style)) {

    opts_df <- opts_df_set(
      opts_df, "table_border_top_style", table.border.top.style)
  }

  # table.border.top.width
  if (!is.null(table.border.top.width)) {

    if (is.numeric(table.border.top.width)) {
      table.border.top.width <- paste0(table.border.top.width, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "table_border_top_width", table.border.top.width)
  }

  # table.border.top.color
  if (!is.null(table.border.top.color)) {

    opts_df <- opts_df_set(
      opts_df, "table_border_top_color", table.border.top.color)
  }

  # heading.background.color
  if (!is.null(heading.background.color)) {

    opts_df <- opts_df_set(
      opts_df, "heading_background_color", heading.background.color)
  }

  # heading.title.font.size
  if (!is.null(heading.title.font.size)) {

    if (is.numeric(heading.title.font.size)) {
      heading.title.font.size <- paste0(heading.title.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "heading_title_font_size", heading.title.font.size)
  }

  # heading.headnote.font.size
  if (!is.null(heading.headnote.font.size)) {

    if (is.numeric(heading.headnote.font.size)) {
      heading.headnote.font.size <- paste0(heading.headnote.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "heading_headnote_font_size", heading.headnote.font.size)
  }

  # heading.border.bottom.style
  if (!is.null(heading.border.bottom.style)) {

    opts_df <- opts_df_set(
      opts_df, "heading_border_bottom_style", heading.border.bottom.style)
  }

  # heading.border.bottom.width
  if (!is.null(heading.border.bottom.width)) {

    if (is.numeric(heading.border.bottom.width)) {
      heading.border.bottom.width <- paste0(heading.border.bottom.width, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "heading_border_bottom_width", heading.border.bottom.width)
  }

  # heading.border.bottom.color
  if (!is.null(heading.border.bottom.color)) {

    opts_df <- opts_df_set(
      opts_df, "heading_border_bottom_color", heading.border.bottom.color)
  }

  # boxhead.background.color
  if (!is.null(boxhead.background.color)) {

    opts_df <- opts_df_set(
      opts_df, "boxhead_background_color", boxhead.background.color)
  }

  # boxhead.font.size
  if (!is.null(boxhead.font.size)) {

    if (is.numeric(boxhead.font.size)) {
      boxhead.font.size <- paste0(boxhead.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "boxhead_font_size", boxhead.font.size)
  }

  # boxhead.font.weight
  if (!is.null(boxhead.font.weight)) {

    opts_df <- opts_df_set(
      opts_df, "boxhead_font_weight", boxhead.font.weight)
  }

  # stub_group.background.color
  if (!is.null(stub_group.background.color)) {

    opts_df <- opts_df_set(
      opts_df, "stub_group_background_color", stub_group.background.color)
  }

  # stub_group.font.size
  if (!is.null(stub_group.font.size)) {

    if (is.numeric(stub_group.font.size)) {
      stub_group.font.size <- paste0(stub_group.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "stub_group_font_size", stub_group.font.size)
  }

  # stub_group.font.weight
  if (!is.null(stub_group.font.weight)) {

    opts_df <- opts_df_set(
      opts_df, "stub_group_font_weight", stub_group.font.weight)
  }

  # stub_group.border.top
  if (!is.null(stub_group.border.top)) {

    opts_df <- opts_df_set(
      opts_df, "stub_group_border_top", stub_group.border.top)
  }

  # stub_group.border.bottom
  if (!is.null(stub_group.border.bottom)) {

    opts_df <- opts_df_set(
      opts_df, "stub_group_border_bottom", stub_group.border.bottom)
  }

  # field.border.top
  if (!is.null(field.border.top)) {

    opts_df <- opts_df_set(
      opts_df, "field_border_top", field.border.top)
  }

  # field.border.bottom
  if (!is.null(field.border.bottom)) {

    opts_df <- opts_df_set(
      opts_df, "field_border_bottom", field.border.bottom)
  }

  # row.padding
  if (!is.null(row.padding)) {

    if (is.numeric(row.padding)) {
      row.padding <- paste0(row.padding, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "row_padding", row.padding)
  }

  # row.striping.background.color
  if (!is.null(row.striping.background.color)) {

    opts_df <- opts_df_set(
      opts_df, "row_striping_background_color", row.striping.background.color)
  }

  # row.striping.include.stub
  if (!is.null(row.striping.include.stub)) {

    opts_df <- opts_df_set(
      opts_df, "row_striping_include_stub", row.striping.include.stub)
  }

  # row.striping.include_field
  if (!is.null(row.striping.include_field)) {

    opts_df <- opts_df_set(
      opts_df, "row_striping_include_field", row.striping.include_field)
  }

  # summary_row.background.color
  if (!is.null(summary_row.background.color)) {

    opts_df <- opts_df_set(
      opts_df, "summary_row_background_color", summary_row.background.color)
  }

  # summary_row.padding
  if (!is.null(summary_row.padding)) {

    if (is.numeric(summary_row.padding)) {
      summary_row.padding <- paste0(summary_row.padding, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "summary_row_padding", summary_row.padding)
  }

  # summary_row.text_transform
  if (!is.null(summary_row.text_transform)) {

    opts_df <- opts_df_set(
      opts_df, "summary_row_text_transform", summary_row.text_transform)
  }

  # footnote.font.size
  if (!is.null(footnote.font.size)) {

    if (is.numeric(footnote.font.size)) {
      footnote.font.size <- paste0(footnote.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "footnote_font_size", footnote.font.size)
  }

  # footnote.padding
  if (!is.null(footnote.padding)) {

    if (is.numeric(footnote.padding)) {
      footnote.padding <- paste0(footnote.padding, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "footnote_padding", footnote.padding)
  }

  # sourcenote.font.size
  if (!is.null(sourcenote.font.size)) {

    if (is.numeric(sourcenote.font.size)) {
      sourcenote.font.size <- paste0(sourcenote.font.size, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "sourcenote_font_size", sourcenote.font.size)
  }

  # sourcenote.padding
  if (!is.null(sourcenote.padding)) {

    if (is.numeric(sourcenote.padding)) {
      sourcenote.padding <- paste0(sourcenote.padding, "px")
    }

    opts_df <- opts_df_set(
      opts_df, "sourcenote_padding", sourcenote.padding)
  }

  # Write the modified `opts_df` to the `data` attribute
  attr(data, "opts_df") <- opts_df

  data
}