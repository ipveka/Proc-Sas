
### RESET table:

Proc.reg.reset <- function(lm){
   a <- resettest(lm,power=2,type="regressor")
   b <- resettest(lm,power=3,type="regressor")
   c <- resettest(lm,power=4,type="regressor")
   a1 <- a$statistic
   a2 <- a$p.value
   b1 <- b$statistic
   b2 <- b$p.value
   c1 <- c$statistic
   c2 <- c$p.value
   stats <- c(a1,b1,c1)
   pval <- c(a2,b2,c2)
   form <- c("2","3","4")
   df <- data.frame(form,stats,pval)
   colnames(df) <- c("Term","Statistic","P-value")
   datatable(df, rownames=FALSE,
             options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
             )))
}
