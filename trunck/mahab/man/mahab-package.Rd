\name{mahab-package}
\alias{mahab-package}
\docType{package}
\title{Species Distribution Mapping Based on the Mahalanobis Distance}
\description{
Tools to map species distributions from an ordinary table of environmental
variables measured at sites (rows = sites, columns = variables). The habitat
of a species is summarised by the mean and the variance-covariance matrix of
the environmental variables at presence sites. Every site is then scored by
its Mahalanobis distance to this mean habitat.
}
\details{
\tabular{ll}{
Package: \tab mahab\cr
Type: \tab Package\cr
Version: \tab 0.4\cr
Date: \tab 2026-11-14\cr
License: \tab GPL (>= 2)\cr
}
Main functions:
\itemize{
  \item \code{\link{mahab}}: estimates the mean habitat and the covariance
  matrix from the presence records, and computes the distances.
  \item \code{\link{predict.mahab}}: computes distances, probabilities or
  scores for the fitted data or for new data.
  \item \code{\link{plot.mahab}}: plots the density of each variable at
  presence and absence sites.
  \item \code{\link{qqmahab}}: draws a chi-squared QQ plot of the distances
  at presence sites.
}
}
\author{
Pierre Bady \email{pierre.bady@gmail.com}
}
\references{
Clark, J.D., Dunn, J.E. and Smith, K.G. (1993) A multivariate model of female
black bear habitat use for a geographic information system.
\emph{Journal of Wildlife Management}, \bold{57}, 519--526.

Calenge, C. (2006) The package "adehabitat" for the R software: a tool for the
analysis of space and habitat use by animals. \emph{Ecological Modelling},
\bold{197}, 516--519.

Saporta, G. (2006) \emph{Probabilités, analyse des données et statistique}.
2e édition. Editions Technip, Paris.
}
\keyword{package}
\seealso{
\code{\link[adehabitatHS]{mahasuhab}}, \code{\link[robust]{covRob}}
}
