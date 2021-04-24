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
        shinyMobile::f7Tab(
            tabName= "Sender",
            icon = shinyMobile::f7Icon("person"),
            active = TRUE,
            f7Card(
            f7Text("send.name","Absender", "John Doe"),
            f7Text("send.adr1","",value = "Straße Hausnummer"),
            f7Text("send.adr2","",value = "12345 Ort"),
            f7Text("send.email","",placeholder = "your.mail@domain.com"),
            f7Text("send.phone","",value = "324 124 5564")
            )),
        shinyMobile::f7Tab(
          tabName= "Recipient",
          icon = shinyMobile::f7Icon("person_3_fill"),
          active = TRUE,
          shinyMobile::f7Fabs(
            extended = TRUE,
            position = "right-bottom",
            color = "green",
            sideOpen = "left",
            inset=TRUE,
            shinyMobile::f7Stepper("step",label =shinyMobile::f7Icon("person_crop_circle_badge_plus") ,1,10,1,1)
          ),
          shinyMobile::f7Accordion(
            id = "myaccordion1",
            f7AccordionItem(
              title =shinyMobile::f7Icon("person"),
              f7Block("Item 1 content"),
              open = FALSE
            ),
            f7AccordionItem(
              id= "R1",
              title =shinyMobile::f7Icon("person_badge_plus"),
              f7Text("Item 2 content","Write me!", "Whatchit!" )
            ),
            f7AccordionItem(
              id= "R2",
              title =shinyMobile::f7Icon("person_badge_plus"),
              f7Text("Item 2 content","Write me!", "Whatchit!" )
            )%>% f7Skeleton(effect = "pulse", duration = 5)
            
          )),
        shinyMobile::f7Tab(
          tabName= "Letter Settings",
          icon = shinyMobile::f7Icon("doc_text_fill"),
          active = TRUE,
         
          f7Block( shinyMobile::f7DatePicker("Dt",label = "Choose Date:"),
          shinyMobile::f7Text("sub",label="Subject:",placeholder = "Concerning"),
          shinyMobile::f7Text("greet",label="Greeting:",placeholder = "Dear"),
          f7Button( "togglePopup3", "Letter Content")),
          shinyMobile::f7Popup(
            id = "pop3",
            title = "Write your Letter:",
            shinyMobile::f7TextArea("lettertext",label = "Text",placeholder = "text of the letter"),
            swipeToClose = TRUE,
          )
          
          ),
        shinyMobile::f7Tab(
          tabName= "PDF",
          icon = shinyMobile::f7Icon("envelope_open_fill"),
          active = TRUE,
            f7Button("toggleSheet", "Layout options"),
            shinyMobile::f7Sheet( id="Sheet",
                                  label = "More",
                                  backdrop = TRUE,
                                  h2("Format"),
                                  h3("coose Font"),
                                  swipeHandler = TRUE)
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
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'Lettermobile head 2'
    )

    # for example, you can add shinyalert::useShinyalert() 

  )
}

