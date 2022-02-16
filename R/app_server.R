#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}.  
#'     DO NOT REMOVE.
#' @import shiny shinyMobile komaletter base64enc qpdf 
#' @noRd
app_server <- function( input, output, session ) {
  
  # Your application server logic 
  observeEvent(input$togglePopup3,{f7TogglePopup(id = "pop3")})
  observeEvent(input$toggleSheet, {updateF7Sheet(id = "Sheet")})
  observeEvent(input$toggleTable, {updateF7Sheet(id = "table_sheet")})
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
  ## more changes to check github conf
  output$table<-renderUI({f7Table(Emp_Data()$df, card=FALSE)})
  
  ##  make an rmd file from the data and render using komaletter
  ###     ! this should all run in \www dir :  f
  observeEvent(input$mrefresh , { 
    # vecor for the loop
    pdfnames<-numeric(Emp_Data()$nr)
    # loop over Recipients
    for (i in 1:Emp_Data()$nr) {
      # create file names 
      rmdname =gsub(" ","", x=paste0("./",Emp_Data()$df[i,1],Emp_Data()$df[i,3],".rmd"))
      pdfname = gsub(" ","", x=paste0(Emp_Data()$df[i,1],Emp_Data()$df[i,3],".pdf"))
      # create .rmd -file
      file.create(rmdname)
      # cat Letter content to .rmd file
      cat(paste0("---\nauthor: ",input$send.name,"\nreturn-address: \n - ", input$send.adr1,"\n - ", input$send.adr2,
                 "\naddress: \n - ", Emp_Data()$df[i,1],
                 "\n - ",Emp_Data()$df[i,2],
                 "\n - ", Emp_Data()$df[i,3],
                 "\n - ",Emp_Data()$df[i,4],
                 "\ndate: ", input$Dt, 
                 "\ncustumer: ",Emp_Data()$df[i,6], 
                 "\ninvoice: ", Emp_Data()$df[i,6], 
                 "\nsubject: ", input$sub, 
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
      # render pdf
      rmarkdown::render(rmdname,"komaletter::komaletter", output_file = pdfname) 
      ## remove rmd file
      file.remove(rmdname)
      # remove logfile
      file.remove(gsub(".rmd",".log",rmdname))
      
      pdfnames[i]<-paste0("./",pdfname)
      
    }
    ## add pdfs together
    qpdf::pdf_combine(pdfnames, output = "./joined.pdf")
    ## remove single pdf files
   file.remove(pdfnames)
   
  })
    ## render pdfs using b64
observeEvent(input$show, {   
  output$pdfview <- renderUI({
      
      pdf_file_path <- "./joined.pdf"
      b64 <- dataURI(file = pdf_file_path, mime = "application/pdf")
     
      tags$iframe(
        style = "height: 600px; width: 100%;", src = b64
      )
    })
  })
# js alert
  observeEvent(input$alert,{
    golem::invoke_js("alert","This a js alert!")
  })
# download pdf
  output$download <- downloadHandler(
    filename =  function() {
      paste0(input$sub, Sys.Date(), '.pdf', sep='')
    },
    content = function(file) {
      file.copy("./joined.pdf",file)
    })

## TODO: modularize this repetitive code:
  output$e1<-renderUI({
    div(
     h5(shinyMobile::f7Icon("person_badge"),style = "display: inline;"),
     h5(input$e1.name,style = "display: inline;")
    )
  })

  output$e2<-renderUI({
    div(
      h5(shinyMobile::f7Icon("person_badge"),style = "display: inline;"),
      h5(input$e2.name,style = "display: inline;")
    )
  })
  output$e3<-renderUI({
    div(
      h5(shinyMobile::f7Icon("person_badge"),style = "display: inline;"),
      h5(input$e3.name,style = "display: inline;")
    )
  })
  output$e4<-renderUI({
    div(
      h5(shinyMobile::f7Icon("person_badge"),style = "display: inline;"),
      h5(input$e4.name,style = "display: inline;")
    )
  })
  output$e5<-renderUI({
    div(
      h5(shinyMobile::f7Icon("person_badge"),style = "display: inline;"),
      h5(input$e5.name,style = "display: inline;")
    )
  })
  output$e6<-renderUI({
    div(
      h5(shinyMobile::f7Icon("person_badge"),style = "display: inline;"),
      h5(input$e6.name,style = "display: inline;")
    )
  })
  ## legals dialog usw
  
  observeEvent(input$contact,{
    f7Dialog(
      title = "Contacts",
      text = "Valentin Haberl"
    )
  })
}
