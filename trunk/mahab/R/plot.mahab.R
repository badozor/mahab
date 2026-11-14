`plot.mahab` <-
function(x,mfrow = NULL,which.par =1:length(x$varnames),ccols=c("black","gray"),addmarg=TRUE,...){
  if(!inherits(x,"mahab"))
    stop("'x' must be of class 'mahab'")
  opar <- par(ask = par("ask"), mfrow = par("mfrow"),mar=c(4,4,2,1))
  on.exit(par(opar))
  if (is.null(mfrow))
    mfrow <- n2mfrow(length(which.par))
  par(mfrow = mfrow)
  if (length(which.par) > prod(mfrow))
    par(ask = TRUE)
  mu <- x$mu
  data <- x$data
  varnames <- x$varnames
  pr <- x$pr
  for(i in which.par){
    xx <- data[,i]
    iq <- quantile(xx,c(0.25,0.75))
    lower <- min(c(iq[1]-1.5*(iq[2]-iq[1]),min(xx)))
    upper <- max(c(iq[2]+1.5*(iq[2]-iq[1]),max(xx)))
    d1 <- density(xx[pr==1],from=lower, to=upper)
    d0 <- density(xx[pr!=1],from=lower, to=upper)
    plot(c(d1$x,d0$x),c(d1$y,d0$y),type="n",ylab="density",xlab=varnames[i],panel.first=c(grid()))
    lines(d0$x,d0$y,lwd=2,col=ccols[1])
    lines(d1$x,d1$y,lwd=2,col=ccols[2])
    if(addmarg)
      abline(v=mu[i],lwd=2,col="red")
    }
  invisible(x)
}

