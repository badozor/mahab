\name{predict.mahab}
\alias{predict.mahab}
\title{Predict Method for Objects of Class 'mahab'}
\description{
Computes Mahalanobis distances, probabilities or scores for the sites used
to fit a \code{"mahab"} object, or for new sites.
}
\usage{
\method{predict}{mahab}(object, newdata, type = c("dist", "proba", "score"),
  na.rm = FALSE, interval = FALSE, level = 0.90, ...)
}
\arguments{
  \item{object}{an object of class \code{"mahab"}, usually returned by
  \code{\link{mahab}}.}
  \item{newdata}{an optional data frame containing the environmental
  variables of \code{object}, with the same names. If omitted, the data used to fit
  \code{object} are used.}
  \item{type}{the type of prediction: \code{"dist"} (default),
  \code{"proba"} or \code{"score"}. See Details.}
  \item{na.rm}{logical. If \code{TRUE}, sites with missing values are
  dropped from the computation and set to \code{NA} in the output. Default
  \code{FALSE}.}
  \item{interval}{logical. If \code{TRUE} and \code{type = "dist"}, lower and
  upper limits are also returned. Default \code{FALSE}.}
  \item{level}{the confidence level used for the limits, a number in
  (0, 1). Default 0.90.}
  \item{\dots}{further arguments passed to or from other methods (ignored).}
}
\details{
With \eqn{p} environmental variables, the three types are:
\itemize{
  \item \code{"dist"}: the squared Mahalanobis distance \eqn{D^2}{D2} to
  the mean habitat (see \code{\link{mahab}}).
  \item \code{"proba"}: \eqn{1 - F(D^2)}{1 - F(D2)}, where \eqn{F} is the
  chi-squared distribution function with \eqn{p} degrees of freedom. Under
  multivariate normality of the habitat, this is the probability of
  observing a distance at least as large. Values close to 1 indicate a
  suitable habitat.
  \item \code{"score"}: \eqn{1 / (1 + D^2)}{1 / (1 + D2)}, a score in
  (0, 1] that relies on no distributional assumption.
}

When \code{interval = TRUE}, with
\eqn{\alpha = (1 - level)/2}{alpha = (1 - level)/2},
the limits are \code{qchisq(alpha, df = D2)} (lower) and
\code{qchisq(1 - alpha, df = D2 + 1)} (upper). These limits are experimental.
}
\value{
A numeric vector with one value per site. With \code{na.rm = TRUE} and
missing values, the vector carries an attribute \code{"na.action"} that
gives the dropped sites. With \code{interval = TRUE} and \code{type = "dist"}, a list
with components \code{map} (the distances), \code{lower} and \code{upper}.
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
\seealso{
\code{\link{mahab}}, \code{\link{qqmahab}},
\code{\link[adehabitatHS]{mahasuhab}}, \code{\link[adehabitatHS]{madifa}}
}
\examples{
set.seed(1)
df <- data.frame(temp = sort(rnorm(30, 0, 1)),
                 depth = sort(rnorm(30, 6, 5)),
                 slope = sort(rnorm(30, -4, 2)))
pr <- c(rep(1, 15), rep(0, 15))
mahab1 <- mahab(df, pr, method = "raw")

pred1 <- predict(mahab1, type = "proba")
table(predicted = ifelse(pred1 > 0.5, 1, 0), observed = mahab1$pr)

# new data with a missing value
nd <- df[1:5, ]
nd$temp[2] <- NA
predict(mahab1, newdata = nd, type = "score", na.rm = TRUE)

# distances with limits
str(predict(mahab1, type = "dist", interval = TRUE))
}
\keyword{multivariate}
