#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}.  
#'     DO NOT REMOVE.
#' @import shiny shinyMobile komaletter
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  observeEvent(input$togglePopup, {f7TogglePopup(id = "pop1")})
  observeEvent(input$togglePopup2, {f7TogglePopup(id = "pop2")})
  observeEvent(input$togglePopup3, {f7TogglePopup(id = "pop3")})
  observeEvent(input$toggleSheet, {updateF7Sheet(id = "Sheet")})
  
####  use a module! or glue
  Emp_Data = reactive({
      df <- data.frame(Name=c(input$e1.name,input$e2.name,input$e3.name,input$e4.name,input$e5.name,input$e6.name),
                       adr1=c(input$e1.adr1,input$e2.adr1,input$e3.adr1,input$e4.adr1,input$e5.adr1,input$e6.adr1),
                       adr2=c(input$e1.adr2,input$e2.adr2,input$e3.adr2,input$e4.adr2,input$e5.adr2,input$e6.adr2),
                       email=c(input$e1.adr2,input$e2.adr2,input$e3.adr2,input$e4.adr2,input$e5.adr2,input$e6.adr2),
                       phone=c(input$e1.adr2,input$e2.adr2,input$e3.adr2,input$e4.adr2,input$e5.adr2,input$e6.adr2))
      df2<- df[!apply(df == "", 1, all),] 
      return(df=df2)
      } )
  output$table<-renderUI({f7Table(Emp_Data())})
  output$value <- renderPrint({ input$e1.name })
}