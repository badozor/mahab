\name{print.mahab}
\alias{print.mahab}
\title{Print Method for Objects of Class 'mahab'}
\description{
Displays a summary of an object of class \code{"mahab"}.
}
\usage{
\method{print}{mahab}(x, digits = max(3, getOption("digits") - 3), ...)
}
\arguments{
  \item{x}{an object of class \code{"mahab"}, usually returned by
  \code{\link{mahab}}.}
  \item{digits}{the number of decimal places used when rounding the printed
  values.}
  \item{\dots}{further arguments passed to or from other methods (ignored).}
}
\details{
Prints the class of the object, the estimation method, the original call,
the mean habitat (marginality vector) with the standard deviation of each
variable, and the variance-covariance matrix.
}
\value{
\code{x}, invisibly.
}
\seealso{\code{\link{mahab}}}
\examples{
set.seed(1)
df <- data.frame(temp = sort(rnorm(30, 0, 1)),
                 depth = sort(rnorm(30, 6, 5)),
                 slope = sort(rnorm(30, -4, 2)))
pr <- c(rep(1, 15), rep(0, 15))
mahab1 <- mahab(df, pr, method = "raw")
mahab1
}
\keyword{print}
