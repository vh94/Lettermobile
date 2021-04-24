#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}.  
#'     DO NOT REMOVE.
#' @import shiny shinyMobile
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  observeEvent(input$togglePopup, {f7TogglePopup(id = "pop1")})
  observeEvent(input$togglePopup2, {f7TogglePopup(id = "pop2")})
  observeEvent(input$togglePopup3, {f7TogglePopup(id = "pop3")})
  observeEvent(input$toggleSheet, {updateF7Sheet(id = "Sheet")})
 
}
