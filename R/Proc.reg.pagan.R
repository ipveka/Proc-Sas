
### PAGAN table:
Proc.reg.pagan <- function(lm){
   b <- bptest(lm)
   a1 <- b$statistic
   a2 <- b$p.value
   t <- data.frame(a1,a2)
   colnames(t) <- c("Statistic","P-value")
   datatable(t, rownames=FALSE,
             options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
             )))
}
