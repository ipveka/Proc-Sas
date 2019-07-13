
### Proc.reg.table(lm)
Proc.reg.table <- function(lm){
   a <- summary(lm)
   a$coefficients
   Variables <- as.vector(row.names(a$coefficients))
   Estimate <- a$coefficients[,1]
   b <- lm.beta(lm)
   StdEstimate <- b$standardized.coefficients
   SdError <- a$coefficients[,2]
   Tval <- a$coefficients[,3]
   Pval <- a$coefficients[,4]
   t <- data.frame(Variables,Estimate,SdError,Tval,Pval,StdEstimate)
   colnames(t) <- c("Variables","Estimate","Std. Error","T-value","P-value","Standardized Est.")
   datatable(t, rownames=FALSE,
             options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
             )))
}
