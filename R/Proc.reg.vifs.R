
#' Plot of Vifs from a linear model
#' @param lm A lm() object
#' @return  Returns a graphic of Vifs from a linear model
#' @examples
#' \dontrun{Proc.reg.vifs(lm)}
#' @export

Proc.reg.vifs <- function(lm){
   ids <- unlist(lapply(lm$model, is.numeric))
   if(length(ids) >= 3){
   z <- lm$model[ , ids]
   x <- z[,-1]
   y <- z[,1]
   b <- mc.plot(x, y)
   }
   else{
   b <- NULL
   }
   return(b)
}

