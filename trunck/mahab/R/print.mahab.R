`print.mahab` <-
function(x,digits = max(3, getOption("digits") - 3),...){
  if(!inherits(x,"mahab"))
    stop("'x' must be of class 'mahab'")
  mu1 <- x$mu
  varcov1 <- x$varcov
  sd1 <- sqrt(diag(varcov1))
  varnames <- x$varnames
  cat("---------------------------------------\n")
  cat("Mapping based on Mahalanobis Distance\n")
  cat("---------------------------------------\n\n")
  cat("class: ",class(x))
  cat("\nestimation: ",x$method)
  cat("\n\n$call: ")
  print(x$call)
  cat("\n$mu: marginality vector\n\n")
  smy <- as.data.frame(cbind(mu1,sd1))
  names(smy) <- c("mu","std dev")
  print(round(smy,digits))
  cat("\n$varcov: variance-covariance matrix\n\n")
  print(round(varcov1,digits))
  cat("\n")
  invisible(x)
}

