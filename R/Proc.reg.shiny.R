
# Proc.reg.shiny

Proc.reg.shiny <- function(){

   appDir <- system.file("Shiny", "myapp", package = "Proc.reg")
   if (appDir == "") {
      stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
   }

   shiny::runApp(appDir, display.mode = "normal")
}





