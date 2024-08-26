shinyPortfolioStatisticsUI <- function() {
    shiny::tagList(
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
        shiny::dataTableOutput(outputId = "dataOverview"),
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

}
