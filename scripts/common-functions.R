
# ---- define_lookup_function -------------------------------------------------
# Create function that inspects names and labels
names_labels <- function(ds){
  nl <- data.frame(matrix(NA, nrow=ncol(ds), ncol=2))
  names(nl) <- c("name","label")
  for (i in seq_along(names(ds))){
    # i = 2
    nl[i,"name"] <- attr(ds[i], "names")
    if(is.null(attr(ds[[i]], "label")) ){
      nl[i,"label"] <- NA}else{
        nl[i,"label"] <- attr(ds[,i], "label")  
      }
  }
  return(nl)
}
# names_labels(ds=oneFile)