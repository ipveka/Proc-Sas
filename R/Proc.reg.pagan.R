
#' Summary table of Breusch-Pagan test
#' @param lm A lm() object
#' @return returns a summary table of Breusch-Pagan test
#' @examples
#' \dontrun{Proc.reg.pagan(lm)}
#' @export

Proc.reg.pagan <- function(lm){
   b <- bptest(lm)
   a1 <- b$statistic
   a2 <- b$p.value
   t <- data.frame(a1,a2)
   t <- t %>% dplyr::mutate_if(is.numeric, round, digits = 3)
   colnames(t) <- c("Statistic","P-value")
   datatable(t, rownames=FALSE,
             options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
             )))
}

