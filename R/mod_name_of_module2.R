#' name_of_module2 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_name_of_module2_ui <- function(id){
  ns <- NS(id)
  tagList(
      shinyMobile::f7Text("rec.name.1","Name", "Pete Meat"),
      shinyMobile::f7Text("rec.adr1.1","Adress",placeholder = "Großestraße 16"),
      shinyMobile::f7Text("rec.adr2.1","",placeholder  = "12345 Ort"),
      shinyMobile::f7Text("rec.adr3.1","",placeholder  = "Deutschland"),
      shinyMobile::f7Text("rec.email.1","",placeholder  ="adress.mail@domain.net"),
      shinyMobile::f7Text("rec.ref.1","",placeholder  ="Custumer number")
  )
}
    
#' name_of_module2 Server Functions
#'
#' @noRd 
mod_name_of_module2_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$togglePopup2, {f7TogglePopup(id = "pop")})
  })
}
    
## To be copied in the UI
# mod_name_of_module2_ui("name_of_module2_ui_1")
    
## To be copied in the server
# mod_name_of_module2_server("name_of_module2_ui_1")
