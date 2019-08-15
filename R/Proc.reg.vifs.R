
#' Plot of Vifs from a linear model
#' @param lm A lm() object
#' @return  Returns a graphic of Vifs from a linear model
#' @examples
#' Proc.reg.vifs(lm)

Proc.reg.vifs <- function(lm){
   ids <- unlist(lapply(lm$model, is.numeric))
   z <- lm$model[ , ids]
   x <- z[,-1]
   y <- z[,1]
   b <- mc.plot(x, y)
}

