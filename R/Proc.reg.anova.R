
### Proc.anova(lm)
Proc.reg.anova <- function(lm){
   a <- anova(lm)
   a$coefficients
   Variables <- as.vector(row.names(a))
   Df <- a[,1]
   SumSq <- a[,2]
   MeanSq <- a[,3]
   Fval <- a[,4]
   Pval <- a[,5]
   t <- data.frame(Variables,Df,SumSq,MeanSq,Fval,Pval)
   colnames(t) <- c("Variables","DF","Sum of Squares","Mean of Squares","F-value","P-value")
   datatable(t, rownames=FALSE,
             options = list(dom = 't',ordering=F, columnDefs = list(
                list(className = "dt-center", targets = "_all")
             )))
}
