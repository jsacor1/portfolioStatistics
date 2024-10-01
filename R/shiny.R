shinyPortfolioStatisticsUI <- function() {
    shiny::tagList(
        htmltools::htmlDependency(
            name = "custom_css",
            version = utils::packageVersion("portfolioStatistics"),
            src = c(file = system.file(
                "assets/css/",
                package = "portfolioStatistics"
            )),
            stylesheet = c(
                "fontawesome.css"
            )
        ),
        shiny::div(
            class = "test-primary",
            style = titleStyle,
            "Data Upload"
        ),
        shiny::div(
            class = "d-inline-flex justify-content-between",
            shiny::actionButton(
                inputId = "retsUpload",
                label = "Returns Upload"
            ),
            shiny::actionButton(
                inputId = "generateReturns",
                label = "Generate Returns"
            )
        ),
        shiny::div(
            style = titleStyle,
            "Data Overview"
        ),
        DT::dataTableOutput(outputId = "dataOverview"),
        shiny::div(
            style = titleStyle,
            "Statistics"
        ),
        shiny::dataTableOutput(outputId = "statistics"),
        shiny::div(
            style = titleStyle,
            "CPPI Analysis"
        ),
        highcharter::highchartOutput(outputId = "cppiAnalysis")
    )
}

shinyPortfolioStatisticsServer <- function(input, output, session) {

    data <- readxl::read_excel("data-raw/test_data.xlsx")

    output$dataOverview <- DT::renderDataTable({
        names <- colnames(data)[colnames(data) != "date"]
        dt <- data.frame(
            "Name" = names,
            "# of Observations" = sapply(data[names], function(x) sum(!is.na(x))), # nolint: line_length_linter.
            "# of CPPI Violations" = 0,
            "Actions" = as.character(
                shiny::tags$div(
                    name = "actions-block-js",
                    style = "
                        display: inline-flex;
                        width: 100%;
                        justify-content: center
                    ",
                    shiny::tags$i(
                        name = "actions-block-js",
                        class = "text-primary text-center fas fa-cog"
                    )
                )
            ),
            check.names = FALSE
        )
        DT::datatable(
            data = dt,
            selection = "none",
            class = "primary",
            escape = FALSE
        )

    })

}
