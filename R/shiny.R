shinyPortfolioStatisticsUI <- function() {
    shiny::addResourcePath(
        prefix = "webfonts",
        directoryPath = system.file(
            "assets/css/webfonts",
            package = "portfolioStatistics"
        )
    )
    theme <- bslib::bs_theme(
        bg = "#F0F0F0",
        fg = "#343a40",
        primary = "#008080",
        secondary = "#008080",
        success = "#28a745",
        info = "#17a2b8",
        warning = "#ffc107",
        danger = "#dc3545",
        light = "#f8f9fa",
        dark = "#343a40"
    )
    shiny::fluidPage(
        theme = theme,
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
                class = "container-fluid",
                style = "margin: 20px; width: auto;",
                shiny::div(
                    class = "test-primary",
                    style = titleStyle,
                    "Data Upload"
                ),
                shiny::div(
                    class = "d-inline-flex justify-content-between",
                    style = bigContainerStyling,
                    shiny::actionButton(
                        inputId = "retsUpload",
                        label = "Returns Upload",
                        style = "margin-right: 10px;"
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
                shiny::div(
                    style = bigContainerStyling,
                    DT::DTOutput(outputId = "dataOverview"),
                ),
                shiny::div(
                    style = titleStyle,
                    "Statistics"
                ),
                shiny::div(
                    style = bigContainerStyling,
                    shiny::tabsetPanel(
                        shiny::tabPanel(
                            title = "Statistics",
                            DT::DTOutput(outputId = "statistics")
                        ),
                        shiny::tabPanel(
                            title = "Efficient Frontier",
                            highcharter::highchartOutput(outputId = "effFrontier") # nolint: line_length_linter.
                        )
                    )
                ),
                shiny::div(
                    style = titleStyle,
                    "CPPI Analysis"
                ),
                shiny::div(
                    style = bigContainerStyling,
                    shiny::tabsetPanel(
                        shiny::tabPanel(
                            title = "CPPI Analysis",
                            highcharter::highchartOutput(outputId = "cppiAnalysis") # nolint: line_length_linter.
                        ),
                        shiny::tabPanel(
                            title = "Weight History",
                            highcharter::highchartOutput(outputId = "weightHistory") # nolint: line_length_linter.
                        )
                    )
                )
            )
        )
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
                        class = "text-primary text-center fas fa-cog",
                        style = "cursor: pointer;"
                    )
                )
            ),
            check.names = FALSE,
            row.names = NULL
        )
        customTable(
            dt = dt,
            options = standardOptions,
            rownames = FALSE,
            escape = FALSE,
            width = "100%",
            height = "100%",
        )
    })

    output$cppiAnalysis <- highcharter::renderHighchart({
        dt <- data[, c("date", "10001", "10002")] |>
            dplyr::mutate(date = as.Date(date))
        customHighchart(dt, title = "CPPI Analysis")
    })

}
