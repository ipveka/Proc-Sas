
### Proc.reg.confint(lm)

Proc.reg.confint <- function(lm){
   t1 <- as.data.frame(confint(lm))
   aux1 <- row.names(t1)
   t2 <-   as.data.frame(confint(lm.beta(lm)))
   t <- cbind(aux1,t1,aux1,t2)
   t <- data.frame(t,row.names=NULL)
   colnames(t) <- c("Estimates","2.5%","97.5%","Std. Estimates","2.5%","97.5%")
   t <- datatable(t, rownames=FALSE,
                  options = list(dom = 't',ordering=F, columnDefs = list(
                     list(className = "dt-center", targets = "_all")
                  )))
   return(t)
}
