#' main UI Function
#'
#' @noRd
#' @importFrom shiny NS tagList
mod_main_ui <- function(id) {
    ns <- NS(id)
    shiny.quartz::QCard(
        title = "Averted Events",
        shiny.quartz::VStack(
            list(
                c("Current Vaccine Effectiveness (E)", "E", "0.6"),
                c("New Vaccine Effectiveness (E_n)", "E_n", "0.7"),
                c("Uptake Rate (u)", "u", "0.5"),
                c("Incidence (I)", "I", "1e6")
            ) |> lapply(\(x)
            shiny.mui::TextField.shinyInput(
                ns(x[2]),
                value = x[3],
                label = x[1],
                type = "number"
            )),
            shiny.mui::Typography(
                "The number of averted events (A) is:",
                variant = "h6"
            ),
            shiny.mui::Typography(
                variant = "h4",
                shiny::textOutput(ns("A"))
            )
        )
    )
}


#' main Server Funciton
#'
#' @noRd
mod_main_server <- function(id) {
    shiny::moduleServer(id, function(input, output, session) {
        ns <- session$ns

output$A <- shiny::renderText({
    c(
        input$E,
        input$E_n,
        input$u,
        input$I
    ) |>
        lapply(shiny::req) |>
        lapply(as.numeric) |>
        do.call(qaverted, args = _)
})
    })
}