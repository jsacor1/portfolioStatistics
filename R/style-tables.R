customTable <- function(dt, options = standardOptions) {
    # create a list of options used to format the DT table
    myOptions <- options

    ###Create HTML formatting code for header and overall table HTML container
            #create header style HTML code
    headerStyle <- "
        th {
            font-family: 'Arial';
            font-weight: bold;
            color: white;
            background-color: #008080;
        }
        th.sorting, th.sorting_asc, th.sorting_desc {
            font-family: 'Arial';
            font-weight: bold;
            color: white;
            background-color: #008080 !important;
        }
    "
    # pull header names from the table
    headerNames <- c(colnames(dt))
    # The container parameter allows us to design the header using CSS
    myContainer <- htmltools::withTags(
        table(
            tags$style(type = "text/css", headerStyle),
            tags$thead(tags$tr(lapply(
                headerNames,
                tags$th,
                style = "
                    text-align: center;
                    border-right-width: 1px;
                    border-right-style: solid;
                    border-right-color: white;
                    border-bottom-width: 1px;
                    border-bottom-style: solid;
                    border-bottom-color: white
                "
            )))
        )
    )

    # Turn the table into a datatable
    myTable <- DT::datatable(
        dt,
        options = myOptions,
        container = myContainer,
        rownames = FALSE,
        escape = FALSE,
        width = "100%", # table remains within the dimensions of the container
        height = "100%" # table remains within the dimensions of the container
    )

    # formatting customisations for row labels of table
    if (!is.null(rownames(myTable))) {
        myTable <- DT::formatStyle(
            myTable,
            columns = " ", #blank columns means row labels
            backgroundColor = "#008080",
            borderBottomColor = "#ffffff",
            borderBottomStyle = "solid",
            borderBottomWidth = "1px",
            borderCollapse = "collapse",
            borderRightColor = "#ffffff",
            borderRightStyle = "solid",
            borderRightWidth = "1px",
            color = "#ffffff",
            fontFamily = "Arial",
            fontSize = "13px",
            fontWeight = "bold",
            lineHeight = "normal",
            paddingBottom = "2.6px",
            paddingLeft = "5.2px",
            paddingRight = "5.2px",
            paddingTop = "2.6px",
            textAlign = "left",
            verticalAlign = "middle"
        )
    }

    # Create specific table formatting customisations
    myTable <- DT::formatStyle(
        myTable,
        columns = seq_along(dt), #specify columns to format
        fontFamily = "Arial",
        fontSize = "16px",
        color = "#008080",
        fontWeight = "bold",
        paddingRight = "1em",
        borderRightWidth = "1px",
        borderRightStyle = "solid",
        borderRightColor = "white",
        borderBottomColor = "#ffffff",
        borderBottomStyle = "solid",
        borderBottomWidth = "1px",
        borderCollapse = "collapse",
        verticalAlign = "middle",
        textAlign = "center",
        wordWrap = "break-word",
        backgroundColor = "#dce8e8"
    )
    myTable
}

standardOptions <- list(
    autoWidth = FALSE,
    searching = FALSE,
    ordering = TRUE, # whether columns can be sorted
    lengthChange = TRUE, # ability to change number rows shown on page
    lengthMenu = c(5, 10, 15, 20), # options lengthChange can be changed to
    pageLength = 10, # initial number of rows per page of table
    paging = TRUE, # whether to do pagination
    escape = FALSE,
    class = "primary",
    info = TRUE # notes whether or not table is filtered
)