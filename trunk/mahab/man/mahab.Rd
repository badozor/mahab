\name{mahab}
\alias{mahab}
\title{Habitat Suitability Based on the Mahalanobis Distance}
\description{
Estimates the mean habitat and the variance-covariance matrix of the
environmental variables at presence sites, then computes the Mahalanobis
distance of every site to this mean habitat. It adapts
\code{\link[adehabitatHS]{mahasuhab}} (package \pkg{adehabitatHS}) to an
ordinary data frame of environmental variables.
}
\usage{
mahab(df, pr, method = c("raw", "classical", "robust"), ...)
}
\arguments{
  \item{df}{a data frame of numeric variables, typically a
  [sites x environmental variables] table.}
  \item{pr}{a vector of 0s and 1s with one value per row of \code{df}:
  1 = species present, 0 = species absent (or not recorded).}
  \item{method}{the estimator of the variance-covariance matrix: \code{"raw"}
  (default), \code{"classical"} or \code{"robust"}. See Details.}
  \item{\dots}{further arguments passed to \code{\link[stats]{cov}}
  (\code{method = "classical"}) or to \code{\link[robust]{covRob}}
  (\code{method = "robust"}). Ignored for \code{method = "raw"}.}
}
\details{
The Mahalanobis distance measures the dissimilarity between the
environmental conditions \eqn{x} of a site and the mean habitat \eqn{\mu}{mu}
of the species:
\deqn{D^2 = (x - \mu)^T \Sigma^{-1} (x - \mu)}{D2 = (x - mu)' Sigma^-1 (x - mu)}
It is the multivariate equivalent of a squared standardised z score
(Clark et al. 1993). Small values indicate sites that are close to the mean
habitat.

\eqn{\mu}{mu} and \eqn{\Sigma}{Sigma} are estimated from the presence
sites only (\code{pr == 1}):
\itemize{
  \item \code{"raw"}: \eqn{\mu}{mu} is the mean vector and
  \eqn{\Sigma}{Sigma} the cross-product of the centred table divided by the
  number of presences \eqn{n} (maximum-likelihood estimator). This gives the
  same distances as \code{\link[adehabitatHS]{mahasuhab}}.
  \item \code{"classical"}: \eqn{\mu}{mu} is the mean vector and
  \eqn{\Sigma}{Sigma} is \code{\link[stats]{cov}} (divisor \eqn{n - 1}).
  The distances are those of \code{"raw"} multiplied by \eqn{(n - 1)/n}.
  \item \code{"robust"}: \eqn{\mu}{mu} and \eqn{\Sigma}{Sigma} are the
  location and scatter returned by \code{\link[robust]{covRob}} (package
  \pkg{robust} required). This option is useful when the presence records
  contain outliers.
}
}
\value{
An object of class \code{"mahab"}, a list with components:
  \item{data}{the data frame \code{df} (\eqn{n} sites \eqn{\times}{x} \eqn{p} variables).}
  \item{pr}{the presence vector \code{pr}.}
  \item{mu}{the mean habitat of the presence sites (marginality vector).}
  \item{varcov}{the \eqn{p \times p}{p x p} variance-covariance matrix of the
  presence sites.}
  \item{varnames}{the names of the environmental variables.}
  \item{call}{the matched call.}
  \item{method}{the estimation method used.}
  \item{dist}{the Mahalanobis distance of every site in \code{df}.}
}
\references{
Clark, J.D., Dunn, J.E. and Smith, K.G. (1993) A multivariate model of female
black bear habitat use for a geographic information system.
\emph{Journal of Wildlife Management}, \bold{57}, 519--526.

Calenge, C. (2006) The package "adehabitat" for the R software: a tool for the
analysis of space and habitat use by animals. \emph{Ecological Modelling},
\bold{197}, 516--519.
}
\author{Pierre Bady}
\seealso{
\code{\link{print.mahab}}, \code{\link{predict.mahab}},
\code{\link{plot.mahab}}, \code{\link{qqmahab}},
\code{\link[adehabitatHS]{mahasuhab}}, \code{\link[stats]{cov}},
\code{\link[robust]{covRob}}, \code{\link[stats]{mahalanobis}}
}
\examples{
set.seed(1)
df <- data.frame(temp = sort(rnorm(30, 0, 1)),
                 depth = sort(rnorm(30, 6, 5)),
                 slope = sort(rnorm(30, -4, 2)))
pr <- c(rep(1, 15), rep(0, 15))

# example 1: raw estimation
mahab1 <- mahab(df, pr, method = "raw")
mahab1

# example 2: classical estimation
mahab2 <- mahab(df, pr, method = "classical")
all.equal(mahab2$dist, mahab1$dist * 14 / 15)

# example 3: robust estimation
if (requireNamespace("robust", quietly = TRUE)) {
  mahab3 <- mahab(df, pr, method = "robust", estim = "mcd")
  plot(predict(mahab3, type = "dist"), predict(mahab1, type = "dist"),
       xlab = "robust", ylab = "raw", panel.first = grid(), pch = 20, cex = 2)
  abline(0, 1, col = "red", lwd = 2)
}
}
\keyword{multivariate}
\keyword{spatial}
