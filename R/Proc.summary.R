
#' Summary table of a dataset
#' @param lm A data.frame() object
#' @return returns a numeric and categoric summary table a dataset
#' @examples
#' Proc.summary(lm)

Proc.summary <- function(x){
   c <- data.frame(Statistic=c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max."))
   for(i in 1:length(x)){
      b <- as.vector(summary(x[,i]))
      c <- cbind(c,b)
   }
   for(i in 1:length(x)){
      colnames(c)[i+1] <- colnames(x)[i]
   }
   is.num <- sapply(c, is.numeric)
   c[is.num] <- lapply(c[is.num], round, 3)
   output <- datatable(c, rownames=FALSE,
                       options = list(dom = 't',ordering=F, columnDefs = list(
                          list(className = "dt-center", targets = "_all",digits=3)
                       )))
   return(output)
}

