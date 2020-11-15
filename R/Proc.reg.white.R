
#' Summary table of the White test
#' @param lm A lm() object
#' @return returns a summary table of the White test
#' @examples
#' \dontrun{Proc.reg.white(lm)}
#' @export

Proc.reg.white <- function(lm){
   a <- lm
   data <- a$model
   u2 <- a$residuals^2
   y <- fitted(a)
   Ru2<- summary(lm(u2 ~ y + I(y^2)))$r.squared
   LM <- nrow(data)*Ru2
   p.value <- 1-pchisq(LM, 2)
   t <- data.frame(LM,p.value)
   t <- t %>% dplyr::mutate_if(is.numeric, round, digits = 3)
   colnames(t) <- c("Statistic","P-value")
   datatable(t, rownames=FALSE,
             options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
             )))
}

