portfolioStatisticsApp <-  function(...) {
    shiny::shinyApp(
        ui = shinyPortfolioStatisticsUI,
        server = shinyPortfolioStatisticsServer
    )
}
