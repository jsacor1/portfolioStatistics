customHighchart <- function(dt, title) {
    # Gather the data into long format for Highcharter
    dt <- dt |>
        tidyr::pivot_longer(
            cols = -date,
            names_to = "series",
            values_to = "value"
        )

    # Create the Highchart object
    hc <- highcharter::highchart() |>
        highcharter::hc_chart(
            type = "line"
        ) |>
        highcharter::hc_title(
            text = title,
            style = list(
                color = "#008080",
                fontFamily = "Arial",
                fontWeight = "bold"
            )
        ) |>
        highcharter::hc_xAxis(
            type = "datetime",
            title = list(
                text = "Date",
                style = list(
                    color = "#008080",
                    fontFamily = "Arial",
                    fontWeight = "bold"
                )
            ),
            lineColor = "#008080",
            labels = list(
                style = list(
                    color = "#008080",
                    fontFamily = "Arial"
                )
            )
        ) |>
        highcharter::hc_yAxis(
            title = list(
                text = "Value",
                style = list(
                    color = "#008080",
                    fontFamily = "Arial",
                    fontWeight = "bold"
                )
            ),
            gridLineWidth = 1,
            labels = list(
                style = list(
                    color = "#008080",
                    fontFamily = "Arial"
                )
            )
        ) |>
        highcharter::hc_legend(
            enabled = TRUE,
            itemStyle = list(
                color = "#008080",
                fontFamily = "Arial",
                fontWeight = "bold"
            )
        ) |>
        highcharter::hc_tooltip(
            shared = TRUE,
            valueDecimals = 4,
            backgroundColor = "#ffffff",
            borderColor = "#008080",
            style = list(
                color = "#008080",
                fontFamily = "Arial"
            )
        )

    # Add series data dynamically
    seriesNames <- unique(dt$series)

    for (series in seriesNames) {
        seriesData <- dt |>
        dplyr::filter(series == !!series) |>
        dplyr::arrange(date)

        hc <- hc |>
        highcharter::hc_add_series(
            data = highcharter::list_parse2(
            data.frame(
                x = highcharter::datetime_to_timestamp(seriesData$date),
                y = seriesData$value
            )
            ),
            name = series,
            marker = list(
                enabled = FALSE
            ),
            lineWidth = 3
        )
    }

    # Return the Highchart object
    hc
}
