archive <- function(type = "file"){

    if(type == "file"){

        input_type <-  "archive_file"

    } else {input_type <-  "archive_folder"}

    file_ok <- system.file(input_type,
                           "app.R",
                           package = "tuhocr")

    shiny::runApp(file_ok)

}


