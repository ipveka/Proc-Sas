
##### User Interface

# source('Runtime.R')

library("RSQLite")
library("shiny")
library("shinydashboard")
library("markdown")
library("car")
library("DT")

### Title:

header <- dashboardHeader(title = "ShinySummary")

### SideBar:

sidebar <- dashboardSidebar(width = 230,

                            hr(),

                            sidebarMenu(
                              menuItem("Import", tabName = "import", icon = icon("cloud-upload", lib = "glyphicon")),
                              menuItem("Describe", tabName = "describe", icon = icon("home", lib = "glyphicon")),
                              menuItem("Visualize", tabName = "visualize", icon = icon("stats", lib = "glyphicon")),
                              menuItem("Report", tabName = "report", icon = icon("cloud-download", lib = "glyphicon")),

                              hr(),

                              menuItem("About", tabName = "about", icon = icon("user")),

                              hr(),

                              helpText("Developed by ",
                                       a("Ignasi Pascual", href = "https://github.com/ipveka"), ".",
                                       style = "padding-left:1em; padding-right:1em;position:absolute;")
                            )
)

### Dashboard:
body <- dashboardBody(

  # Tabintes:
  tabItems(

    ### TAB 0 = Home:
    tabItem(tabName = "home",
            fluidPage(
              box(width = 12,
                  shiny::includeMarkdown("Home.md"),
                  tags$style(type="text/css",
                             ".shiny-output-error { visibility: hidden; }",
                             ".shiny-output-error:before { visibility: hidden; }"
                  ),
                  tags$head(tags$style(HTML('
                            .main-header .logo {
                            font-family: "Georgia", Times, "Times New Roman", serif;
                            font-weight: bold;
                            font-size: 20px;
                            }
      ')))))

    ),

    ### TAB 1 = Import:
    tabItem(tabName = "import",
            fluidRow(column(4, box(width = 16,
                                   # Input: Select a file ----
                                   fileInput("file1", "Choose CSV File",
                                             multiple = FALSE,
                                             accept = c("text/csv",
                                                        "text/comma-separated-values,text/plain",
                                                        ".csv")),
                                   # Horizontal line ----
                                   tags$hr(),
                                   # Input: Checkbox if file has header ----
                                   checkboxInput("header", "Header", TRUE),
                                   # Input: Select separator ----
                                   radioButtons("sep", "Separator",
                                                choices = c(Comma = ",",
                                                            Semicolon = ";",
                                                            Tab = "\t"),
                                                selected = ","),
                                   # Input: Select quotes ----
                                   radioButtons("quote", "Quote",
                                                choices = c(None = "",
                                                            "Double Quote" = '"',
                                                            "Single Quote" = "'"),
                                                selected = '"')
            )),
            column(8, box(width = 16, DT::dataTableOutput("table", width = 650))
            ))
    ),

    ### TAB 2 = Describe:
    tabItem(tabName = "describe",
            fluidRow(
              box(width = 12,title = "Summary",
                  solidHeader = FALSE,
                  DT::dataTableOutput(outputId = "toc"),
                  tags$hr(),
                  uiOutput('select'),
                  tags$hr(),
                  DT::dataTableOutput("summary")))
    ),


    ### TAB 3 = Visualize:
    tabItem(tabName = "visualize",
            fluidRow(box(width = 12,title = "Graphics",
                         solidHeader = FALSE,
                         plotOutput('plot1'),
                         plotOutput('plot2'),
                         plotOutput('plot3')))
    ),

    ### TAB 4 = Report:
    tabItem(tabName = "report",
            fluidRow(box(width=12,
                         title = 'Download the report',
                         downloadButton("report","Download Custom Report")
            ))
    ),

    ### TAB 5 = About
    tabItem(tabName = "about",
            fluidPage(
              box(width = 12,
                  shiny::includeMarkdown("README.md"))
            )
    )
  )
)

ui <- dashboardPage(header, sidebar, body, skin="purple")

