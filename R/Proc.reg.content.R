
### Proc.content

Proc.reg.content <- function(x){
   a <- data.frame(row.names = 1:length(x),
                   Name = substr(names(x), 1, 19),
                   Class = sapply(x, class),
                   N_unique = sapply(x, function(v) length(unique(v))),
                   NAS = sapply(x, function(x) sum(is.na(x))),
                   NAS_Percent = ((sapply(x, function(x) sum(is.na(x))))/nrow(x))*100)
   b <- datatable(a, rownames=FALSE,
                  options = list(dom = 't',ordering=F, columnDefs = list(
                     list(className = "dt-center", targets = "_all")
                  )))
   return(b)
}
