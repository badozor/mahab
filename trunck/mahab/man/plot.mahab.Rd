\name{plot.mahab}
\alias{plot.mahab}
\title{Plot Method for Objects of Class 'mahab'}
\description{
Draws, for each environmental variable, the kernel density estimate of the
variable at presence sites and at absence sites.
}
\usage{
\method{plot}{mahab}(x, mfrow = NULL, which.par = 1:length(x$varnames),
  ccols = c("black", "gray"), addmarg = TRUE, ...)
}
\arguments{
  \item{x}{an object of class \code{"mahab"}, usually returned by
  \code{\link{mahab}}.}
  \item{mfrow}{a vector \code{c(nr, nc)} giving the layout of the panels.
  If \code{NULL} (default), it is computed by \code{\link[grDevices]{n2mfrow}}.}
  \item{which.par}{the indices of the variables to plot. Default: all
  variables.}
  \item{ccols}{a vector of two colours: the first one for absence sites, the
  second one for presence sites. Default \code{c("black", "gray")}.}
  \item{addmarg}{logical. If \code{TRUE} (default), a red vertical line
  marks the mean habitat (marginality) of each variable.}
  \item{\dots}{further arguments (currently ignored).}
}
\details{
One panel is drawn per variable. Densities are computed by
\code{\link[stats]{density}} over a common range: from
\eqn{\min(Q_1 - 1.5\,IQR, \min x)}{min(Q1 - 1.5 IQR, min(x))} to
\eqn{\max(Q_3 + 1.5\,IQR, \max x)}{max(Q3 + 1.5 IQR, max(x))}. The gap
between the two curves shows how strongly the species selects each
variable. If more variables are requested than there are panels, the device
prompts the user before each new page.
}
\value{
\code{x}, invisibly.
}
\seealso{\code{\link{mahab}}, \code{\link{qqmahab}}}
\examples{
set.seed(1)
df <- data.frame(temp = sort(rnorm(30, 0, 1)),
                 depth = sort(rnorm(30, 6, 5)),
                 slope = sort(rnorm(30, -4, 2)))
pr <- c(rep(1, 15), rep(0, 15))
mahab1 <- mahab(df, pr, method = "raw")
plot(mahab1)
plot(mahab1, which.par = 1:2, ccols = c("blue", "orange"))
}
\keyword{hplot}
