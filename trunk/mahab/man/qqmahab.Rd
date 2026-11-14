\name{qqmahab}
\alias{qqmahab}
\title{Chi-Squared QQ Plot for Objects of Class 'mahab'}
\description{
Plots the Mahalanobis distances of the presence sites against the quantiles
of a chi-squared distribution. The line \eqn{y = x} shows the expected fit.
}
\usage{
qqmahab(object, nbval = 100, main = "QQ-plot", ...)
}
\arguments{
  \item{object}{an object of class \code{"mahab"}, usually returned by
  \code{\link{mahab}}.}
  \item{nbval}{the number of theoretical quantiles drawn from the
  chi-squared distribution. Default 100.}
  \item{main}{the main title. Default \code{"QQ-plot"}.}
  \item{\dots}{further graphical parameters passed to
  \code{\link[stats]{qqplot}}.}
}
\details{
If the environmental variables at presence sites follow a multivariate
normal distribution with known mean and covariance, the squared
Mahalanobis distance follows a chi-squared distribution with \eqn{p}
degrees of freedom, where \eqn{p} is the number of variables. Points far
from the line \eqn{y = x} indicate departures from normality or outlying
presence records. The plot also helps to judge whether
\code{type = "proba"} in \code{\link{predict.mahab}} is appropriate.
}
\value{
The distances of the presence sites, invisibly.
}
\references{
Mahalanobis, P.C. (1936) On the generalised distance in statistics.
\emph{Proceedings of the National Institute of Sciences of India},
\bold{2}, 49--55.

Saporta, G. (2006) \emph{Probabilités, analyse des données et statistique}.
2e édition. Editions Technip, Paris.
}
\seealso{\code{\link{mahab}}, \code{\link{predict.mahab}}}
\examples{
set.seed(1)
df <- data.frame(temp = sort(rnorm(30, 0, 1)),
                 depth = sort(rnorm(30, 6, 5)),
                 slope = sort(rnorm(30, -4, 2)))
pr <- c(rep(1, 15), rep(0, 15))
mahab1 <- mahab(df, pr, method = "raw")
qqmahab(mahab1)
}
\keyword{hplot}
