
#' Content table
#' @param x A data.frame() object
#' @return returns a content table
#' @examples
#' \dontrun{Proc.content(df)}
#' @export

Proc.content <- function(x){
   a <- data.frame(row.names = 1:length(x),
                   name = substr(names(x), 1, 19),
                   class = sapply(x, class),
                   unique = sapply(x, function(v) length(unique(v))),
                   na = sapply(x, function(x) sum(is.na(x))))
   b <- datatable(a, rownames=FALSE,
                  options = list(dom = 't',ordering=F, columnDefs = list(
                     list(className = "dt-center", targets = "_all")
                  )))
   return(b)
}


