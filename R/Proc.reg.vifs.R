
### VIF Analysis:

Proc.reg.vifs <- function(lm){
   ids <- unlist(lapply(lm$model, is.numeric))
   z <- lm$model[ , ids]
   x <- z[,-1]
   y <- z[,1]
   b <- mc.plot(x, y)
}

