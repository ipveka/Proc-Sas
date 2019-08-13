
# Proc.summary.shiny

Proc.summary.shiny <- function(){
   appDir <- system.file("Shiny", "myapp2", package = "Proc.sas")
   if (appDir == "") {
      stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
   }
   shiny::runApp(appDir, display.mode = "normal")
}

