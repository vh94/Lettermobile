#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny shinyMobile
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    shinyMobile::f7Page(
      # allowPWA=FALSE,
      # options = list(theme = c("ios", "md", "auto", "aurora"),
      #                 dark = TRUE, filled = FALSE,color = "#007aff",
      #                 touch = list(tapHold = TRUE, tapHoldDelay = 750,
      #                 iosTouchRipple = FALSE), iosTranslucentBars = FALSE,
      #                navbar = list(iosCenterTitle = TRUE,hideOnPageScroll = TRUE),
      #                toolbar = list(hideOnPageScroll = FALSE), pullToRefresh = FALSE),
      options = list(theme="md",dark=FALSE,touch=list(iosTouchRipple = TRUE),navbar = list(iosCenterTitle = TRUE,hideOnPageScroll = TRUE)),
      shinyMobile::f7TabLayout(
        panels = tagList(
          shinyMobile::f7Panel(side = "left", theme = "light", effect = "cover"),
          shinyMobile::f7Panel(side = "right", theme = "light", effect = "cover")),
          navbar= shinyMobile::f7Navbar(
            title= "A mobile Pdf Letter tool",
            leftPanel = FALSE,
            rightPanel = TRUE
          ),
        shinyMobile::f7Tabs(
          animated = TRUE,
          id= "tabs",
        ## first tab SENDER::
        shinyMobile::f7Tab(
            tabName= "Sender",
            icon = shinyMobile::f7Icon("person"),
            active = TRUE,
            f7Card(
            f7Text("send.name","Absender", "Sandor Clegane"),
            f7Text("send.adr1","",value = "Straße Hausnummer"),
            f7Text("send.adr2","",value = "12345 Ort"),
            f7Text("send.email","",value = "your.mail@domain.com"),
            f7Text("send.phone","",value = "324 124 5564")
            )),
        ##### Second tab RECIPIENTS::
        shinyMobile::f7Tab(
          tabName= "Recipients",
          icon = shinyMobile::f7Icon("person_3_fill"),
          active = TRUE,
          ### Accordion with conditional additional recipients, 
          ### should probaly use modules
          shinyMobile::f7Accordion(
            id = "myaccordion1",
            f7AccordionItem(
              title =shinyMobile::f7Icon("person_badge"),
              f7Block( f7Card(
                f7Text("e1.name","Recipient 1", "John Snow"),
                f7Text("e1.adr1","",value= "Northern Wall 34"),
                f7Text("e1.adr2","",value = "12345 Ort"),
                f7Text("e1.email","",value = "your.mail@domain.com"),
                f7Text("e1.phone","",value = "324 124 5564")
              )),
              open = FALSE
            ),
            conditionalPanel(condition = "input.step2 > 1",
            f7AccordionItem(
              id= "R1",
              title =shinyMobile::f7Icon("person_badge_plus"),
              f7Block( f7Card(
                f7Text("e2.name","Recipient 2", value="Edda Stark"),
                f7Text("e2.adr1","",value= "Straße Hausnummer"),
                f7Text("e2.adr2","",value = "12345 Ort"),
                f7Text("e2.email","",value = "your.mail@domain.com"),
                f7Text("e2.phone","",value = "324 124 5564")
              )),
              open = FALSE
            )%>% f7Skeleton(effect = "blink", duration = 3)),
            conditionalPanel(condition = "input.step2 > 2",
                             f7AccordionItem(
                               id= "R1",
                               title =shinyMobile::f7Icon("person_badge_plus"),
                               f7Block( f7Card(
                                 f7Text("e3.name","Recipient 2", value="Robert Baratheon"),
                                 f7Text("e3.adr1","",value= "Straße Hausnummer"),
                                 f7Text("e3.adr2","",value = "12345 Ort"),
                                 f7Text("e3.email","",value = "your.mail@domain.com"),
                                 f7Text("e3.phone","",value = "324 124 5564")
                               )),
                               open = FALSE
                             )%>% f7Skeleton(effect = "fade", duration = 3)),
            conditionalPanel(condition = "input.step2 > 3",
            f7AccordionItem(
              id= "R2",
              title =shinyMobile::f7Icon("person_badge_plus"),
              f7Block( f7Card(
                f7Text("e4.name","Recipient 4", value="Bran Stark"),
                f7Text("e4.adr1","",value= "Straße Hausnummer"),
                f7Text("e4.adr2","",value = "12345 Ort"),
                f7Text("e4.email","",value = "your.mail@domain.com"),
                f7Text("e4.phone","",value = "324 124 5564")
              )),
              open = FALSE
            )%>% f7Skeleton(effect = "fade", duration = 3)),
            conditionalPanel(condition = "input.step2 > 4",
                             f7AccordionItem(
                               id= "R2",
                               title =shinyMobile::f7Icon("person_badge_plus"),
                               f7Block( f7Card(
                                 f7Text("e5.name","Recipient 4", value="Tywin Lennister"),
                                 f7Text("e5.adr1","",value= "Straße Hausnummer"),
                                 f7Text("e5.adr2","",value = "12345 Ort"),
                                 f7Text("e5.email","",value = "your.mail@domain.com"),
                                 f7Text("e5.phone","",value = "324 124 5564")
                               )%>% f7Skeleton(effect = "fade", duration = 2)),
                               open = FALSE
                             )),
            conditionalPanel(condition = "input.step2 > 5",
                             f7AccordionItem(
                               id= "R2",
                               title =shinyMobile::f7Icon("person_badge_plus"),
                               f7Block( f7Card(
                                 f7Text("e6.name","Recipient 4", value="Samwell Tarley"),
                                 f7Text("e6.adr1","",value= "Havensquare 87"),
                                 f7Text("e6.adr2","",value = "75544 Permeth"),
                                 f7Text("e6.email","",value = "Jberg78@yahoo.com"),
                                 f7Text("e6.phone","",value = "324 124 99503456")
                               )),
                               open = FALSE)%>% f7Skeleton(effect = "fade", duration = 2))
            
          ),
          ### input stepper number of recipients "step2" f
        shinyMobile::f7Stepper("step2",label =shinyMobile::f7Icon("person_crop_circle_badge_plus") ,1,6,1,1)),
        shinyMobile::f7Tab(
          tabName= "Letter Settings",
          icon = shinyMobile::f7Icon("doc_text_fill"),
          active = TRUE,
        f7Block( f7Card( shinyMobile::f7DatePicker("Dt",label = "Choose Date:"),
          shinyMobile::f7Text("sub",label="Subject:",value = "Concerning"),
          shinyMobile::f7Text("place",label="Place:",value = "Mississippi"),
          shinyMobile::f7Text("greet",label="Greeting:",value = "Dear"),
          shinyMobile::f7Text("closing",label="Closing",value = "Yours,")),
          f7Button( "togglePopup3", "Letter Content")),
          shinyMobile::f7Popup(
            id = "pop3",
            title = "Write your Letter:",
            shinyMobile::f7TextArea("lettertext",label = "Text",value = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."),
            swipeToClose = TRUE,
          )
          
          ),
        shinyMobile::f7Tab(
          tabName= "PDF",
          icon = shinyMobile::f7Icon("envelope_open_fill"),
          active = TRUE,
          f7Card(
            uiOutput("pdfview")),
          f7Segment(
            container = "segment",
            rounded = TRUE,
            f7Button("toggleTable", "Recipient List"),
            f7Button("toggleSheet", "Layout options")),
          f7Segment(
            container = "segment",
            rounded = TRUE,
            f7Button("mrefresh", "Print Pdf"),
            f7DownloadButton("download","Download!")
            ),
            shinyMobile::f7Sheet( id="Sheet",
                                  label = "More",
                                  orientation = "bottom",
                                  backdrop = TRUE,
                                  swipeToStep = TRUE,
                                  f7Card(
                                  f7Select("lco",label="Format -Standard",list("maintainersDelight","DIN5008A", "NF","SN","UScommercial9","NipponEL")),
                                  f7Select("lang",label="Language",list("de","en")),
                                  f7Select("papersize",label="Papersize",choices = list("a4","letter"))
                                  ),
                                  swipeHandler = TRUE),
          shinyMobile::f7Sheet(id="table_sheet",
                               swipeToStep = TRUE,
                               swipeHandler = TRUE,
                               label= "Recipient list:",
                               orientation = "top",
                               uiOutput('table')
                               
            
          )
        )
        )
        
      )
      )
      )
  
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny shinyMobile
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    golem::activate_js(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'Lettermobile head 2'
    ),
    
    #tags$pdf(src = "www/joined.pdf"),
    
    ## for example, you can add shinyalert::useShinyalert() 

  )
}

