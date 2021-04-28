#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}.  
#'     DO NOT REMOVE.
#' @import shiny shinyMobile komaletter qpdf shinyjs
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  observeEvent(input$togglePopup3, {f7TogglePopup(id = "pop3")})
  observeEvent(input$toggleSheet, {updateF7Sheet(id = "Sheet")})
  
####  use a module! or glue
  ####   create dataframe of recipients data
  Emp_Data = reactive({
      df <- data.frame(Name=c(input$e1.name,input$e2.name,input$e3.name,input$e4.name,input$e5.name,input$e6.name),
                       adr1=c(input$e1.adr1,input$e2.adr1,input$e3.adr1,input$e4.adr1,input$e5.adr1,input$e6.adr1),
                       adr2=c(input$e1.adr2,input$e2.adr2,input$e3.adr2,input$e4.adr2,input$e5.adr2,input$e6.adr2),
                       email=c(input$e1.email,input$e2.email,input$e3.email,input$e4.email,input$e5.email,input$e6.email),
                       phone=c(input$e1.phone,input$e2.phone,input$e3.phone,input$e4.phone,input$e5.phone,input$e6.phone))
      df2<- df[!apply(df == "", 1, all),]
      df2<-df2[1:input$step2,]
      return(list(df=df2, nr=nrow(df2)))
      } )
  ## output dataframe as table
  output$table<-renderUI({f7Table(Emp_Data()$df)})
  
  ##  make an rmd file from the data and render using komaletter
  ###     ! this should all run in \www dir :  f
  observeEvent(input$mrefresh , { 
    pdfnames<-numeric(Emp_Data()$nr)
    for (i in 1:Emp_Data()$nr) {
      rmdname =gsub(" ","", x=paste0(Emp_Data()$df[i,1],Emp_Data()$df[i,3],".rmd"), fixed = TRUE)
      pdfname = gsub(" ","", x=paste0(Emp_Data()$df[i,1],Emp_Data()$df[i,3],".pdf"), fixed = TRUE)
      empty<-""
      # use a gsubregex to make the filename
      writeBin(empty,rmdname)
      cat(paste0("---\nauthor: ",input$send.name,"\nreturn-address: \n - ", input$send.adr1,"\n - ", input$send.adr2,
                 "\naddress: \n - ", Emp_Data()$df[i,1],
                 "\n - ",Emp_Data()$df[i,2],
                 "\n - ", Emp_Data()$df[i,3],
                 "\n - ",Emp_Data()$df[i,4],
                 "\ndate: ", input$Dt, 
                 "\ncustumer: ",Emp_Data()$df[i,6], 
                 "\ninvoice: ", Emp_Data()$df[i,6], 
                 "\nsubject: ", input$bet, 
                 "\nplace: ", input$place, 
                 "\nopening: ",paste(input$greet,Emp_Data()$df[i,1],","),
                 "\nclosing: ", input$closing,
                 "\nsignature: ",input$send.name,
                 "\nreturn-email: ", input$send.email,
                 "\nfromphone: ", input$send.phone,
                 "\nlco: ", input$lco,
                 "\nlang: ", input$lang,
                 "\npapersize: ", input$papersize,
                 "\noutput: komaletter::komaletter 
--- \n",input$lettertext),file=rmdname)
      rmarkdown::render(rmdname,"komaletter::komaletter", output_file = pdfname,envir = new.env(parent = globalenv()))
      pdfnames[i]<-pdfname
      
    }
    
    pdf_combine(pdfnames, output = "joined.pdf")
  })
  output$pdfview <- renderUI({
    tags$iframe(style="height:600px; width:100%", src="inst/app/www/joined.pdf")
  })
  output$download <- downloadHandler(
    filename =  function() {
      paste(input$rec.name,input$rec.adr1, Sys.Date(), '.pdf', sep='')
    },
    content = function(file) {
      file.copy("joined.pdf",file)
    })
}