#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
    # Your application server logic
    mod_main_server("main")
}

app_ui <- function(request) {
    shiny.quartz::Page(
        "",
        mod_main_ui("main")
    )
}

#' Run App
#' Main function called in the app.R file to run the app
#' @export
run_app <- function() {
    shiny::shinyApp(
        server = app_server,
        ui = app_ui,
    )
}