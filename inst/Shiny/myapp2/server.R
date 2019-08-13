
##### Server

# source('Runtime.R')

library("RSQLite")
library("shiny")
library("shinydashboard")
library("markdown")
library("car")
library("DT")

server <- function(input, output) {

  ### Funcions i crides:

  # TaulaContinguts(x)
  TaulaContinguts <- function(x) {
    data.frame(row.names = 1:length(x),
               Name = substr(names(x), 1, 19),
               Class = sapply(x, class),
               N_unique = sapply(x, function(v) length(unique(v))))
  }

  # Colors()
  Colors <- function(nv=4){
    if(require(RColorBrewer)){
      cols=brewer.pal(nv,"Pastel1")
    }else{
      warning("This plot would like nicer if you installed RColorBrewer")
      cols=(1:nv)
    }
    return(cols)
  }

  ### Data
  myData <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)
    data <- read.csv(inFile$datapath, header = input$header,
                     sep = input$sep,
                     quote = input$quote)
  })

  output$table <- DT::renderDataTable(
    myData(),
    options = list(scrollX = TRUE,pageLength = 15)
  )

  ### Summary of data:
  output$select <- renderUI({
    df <- myData()
    selectInput("variable","Variable:",names(df))
  })
  output$toc <- renderDataTable({
    a <- TaulaContinguts(myData())
    datatable(a, rownames=FALSE,
              options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
              )))
  })
  output$summary <- renderDataTable({
    options(digits = 3)
    df <- myData()
    df <- df[,input$variable]
    v <- c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.")
    a <- as.vector(summary(df))
    c <- data.frame(v,a)
    colnames(c) <- c("Statisic","Value")
    datatable(c, rownames=FALSE,
              options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
              )))
  })

  ### Summary plots:
  output$plot1 <- renderPlot({
    df <- myData()
    df <- df[,input$variable]
    if(is.numeric(df)){
      hist(df, col="gray16",xlab=input$variable,ylab="")
    }
    else{
      plot(df,col="gray16",xlab=input$variable)
    }
  })
  output$plot2 <- renderPlot({
    df <- myData()
    df <- df[,input$variable]
    if(is.numeric(df)){
      plot(df,col="gray16",xlab=input$variable,ylab="")
    }
  })
  output$plot3 <- renderPlot({
    df <- myData()
    df <- df[,input$variable]
    if(is.numeric(df)){
      boxplot(df, col="gray16",xlab=input$variable)
    }
  })

  # Report

  output$report <- downloadHandler(
     # For PDF output, change this to "report.pdf"
     filename = "Report.html",
     content = function(file) {
        # Copy the report file to a temporary directory before processing it, in
        # case we don't have write permissions to the current working dir (which
        # can happen when deployed).
        tempReport <- file.path(tempdir(), "Report.Rmd")
        file.copy("Report.Rmd", tempReport, overwrite = TRUE)
        # Set up parameters to pass to Rmd document
        params <- list(a = myData())
        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        rmarkdown::render(tempReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
     }
  )

}
