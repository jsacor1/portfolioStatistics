# STYLE
titleStyle <- "
    color: #50e3c2;
    background-color: #343a40;
    padding: 10px;
    margin-bottom: 10px;
    font-size: 20px;
    font-weight: 500;
    font-family: 'Arial';
"

shinyPortfolioStatisticsUI <- function() {
    shiny::tagList(
        shiny::div(
            class = "test-primary",
            style = titleStyle,
            "Data Upload"
        ),
        shiny::div(
            class = "d-inline-flex justify-content-between",
            shiny::actionButton(inputId = "retsUpload", label = "Returns Upload"),
            shiny::actionButton(inputId = "generateReturns", label = "Generate Returns")
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

shiny::shinyApp(
    ui = shinyPortfolioStatisticsUI(),
    server = shinyPortfolioStatisticsServer
)


# devtools::load_all();source("/Users/juansarmiento/Library/CloudStorage/OneDrive-Personal/Documentos/Programming/Shiny Projects/Portfolio Statistics/Repo/portfolioStatistics/R/shiny.R", encoding = "UTF-8", echo = TRUE)