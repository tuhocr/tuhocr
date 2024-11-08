library(shiny)
library(shinyFiles)
library(googledrive)
library(sodium)

ui <- fluidPage(

titlePanel("ARCHIVE FOLDER"),

sidebarLayout(

sidebarPanel(
  
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  # tags$head(tags$style('body {color:red;}')),

  tags$style(type="text/css", "#text_1 {color : #999999;}"),
  
span(textInput(inputId = "text_1",
label = "PASSWORD",
value = paste(sodium:::random(3), collapse = ""),
width = NULL,
placeholder = NULL), style="color:black"),

shinyFiles:::shinyDirButton('folder', 'SELECT FOLDER', 'SELECT FOLDER'),

actionButton("ready", "ZIP"),

actionButton("drive_ok", "UPLOAD"),

br(),

br(),

span(textInput(inputId = "text_5",
          label = "OBJECT CODE",
          value = NULL,
          width = NULL,
          placeholder = NULL), style="color:black"),

actionButton("open_ok", "OPEN")

),

mainPanel(

verbatimTextOutput("console_2"),

verbatimTextOutput("console_1"),

verbatimTextOutput("console_3"),

verbatimTextOutput("console_4")


)
)
)

server <- function(input, output) {
  
shinyDirChoose(input = input,
               id = "folder",
               roots = getVolumes()()
               )

root_path <- reactive(x = {
  
  validate(
    need(input$folder, "")
    )

  input_p1 <- input$folder[[1]]

  input_p2 <- input$folder[[2]]


  root_1 <- unlist(input_p2)

  gsub(pattern = "\\(",
       replacement = "",
       x = root_1) -> root_2

  gsub(pattern = "\\)",
       replacement = "",
       x = root_2) -> root_3

  paste0(root_3, "\\") -> root_4

  strsplit(root_3, split = " ") -> root_5

  unlist(root_5) -> root_6

  root_6[length(root_6)] -> root_7

  path_yes <- paste(unlist(input_p1), collapse = "\\")

  ROOT_FINAL <- paste0(root_7, path_yes)

}
)  

output$console_1 <- renderText({ 

PASSWORD <- input$text_1

files2zip <- dir(root_path(), 
                 full.names = TRUE,
                 recursive = TRUE)

zip(zipfile = root_path(), # OUTPUT # windows \\ khi zip
files = files2zip,
flags = paste("--password", PASSWORD))

print(file_up <- paste0(root_path(), ".zip"))

# print(unlist(files2zip))

# print(root_path())

}) |> bindEvent(input$ready)


output$console_2 <- renderPrint({ 

    root_yes <- list.files(root_path(),
                     full.names = TRUE,
                     recursive = TRUE)
    
    print(root_yes)
  
  }
  ) 


output$console_3 <- renderText({ 
  
    file_up <- paste0(root_path(), ".zip")
    
    drive_auth()
    
    result_up <- drive_upload(media = file_up)
    
    drive_share(paste0("https://drive.google.com/file/d/", result_up$id), type = "anyone")
    
    gom_all <- paste0(toupper(paste(sodium:::random(2), collapse = "")), 
                      result_up$id, 
                      paste(sodium:::random(2), collapse = ""), 
                      input$text_1)
  
    print(gom_all)
  
}) |> bindEvent(input$drive_ok)

output$console_4 <- renderPrint({ 
  
  drive_deauth()
  drive_user()
  
  uncover <- input$text_5

  substr(x = uncover,
         start = nchar(paste0(paste(sodium:::random(2), collapse = ""), sodium:::random(1))) - 1,
         stop = nchar(paste0(paste(sodium:::random(2), collapse = ""), sodium:::random(1))) + nchar(paste(sodium:::random(16), collapse = "")) - 1) -> url_final
  
  substr(x = uncover,
         start = nchar(paste0(paste(sodium:::random(2), collapse = ""), sodium:::random(1))) + nchar(paste(sodium:::random(16), collapse = "")) + 4,
         stop = nchar(uncover)) -> pass_final


  url_all <- paste0("https://drive.google.com/file/d/", url_final)

  public_file <-  drive_get(url_all)

  home_folder <- paste0(getwd(), "/", public_file$name)

  drive_download(file = public_file,
                 path = home_folder,
                 overwrite = TRUE)

  system(
    command = paste0("unzip -o -P ",
                     pass_final,
                     " ",
                     home_folder, # file unzip
                     " -d ",
                     getwd()), # folder output
    wait = TRUE
  )

  unlink(home_folder)
  
  home_ok <- gsub(pattern = "\\.zip", replacement = "", x = home_folder)
  
  switch_ok <- list.files(home_ok, full.names = TRUE, recursive = TRUE)
  
  if(length(switch_ok) == 0){
    
    df <- file.info(list.files(getwd(), full.names = TRUE))
    
    df <- df |> subset(isdir == TRUE)
    
    file_newest <- rownames(df)[which.max(df$mtime)]
    
    file_open <- list.files(file_newest, full.names = TRUE, recursive = TRUE)
    
    gsub(pattern = "/", replacement = "\\\\",
         x = file_open) -> file_open_final
    
    print(file_open_final)
    # 
    # print(file_open)
    
    shell(cmd = file_open_final)
    
    
  } else {
    
    print(list.files(home_ok, full.names = TRUE, recursive = TRUE))

    shell(cmd = list.files(home_ok, full.names = TRUE, recursive = TRUE)[1])
    
  }

  
  

  
  
}) |> bindEvent(input$open_ok)

}

shinyApp(ui = ui, server = server)
















