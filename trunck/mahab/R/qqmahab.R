qqmahab <- function(object, nbval = 100, main = "QQ-plot", ...) {
  if (!inherits(object, "mahab"))
    stop("'object' must be of class 'mahab'")
  pred <- stats::predict(object, type = "dist")[object$pr == 1]
  ddl <- length(object$varnames)
  stats::qqplot(stats::qchisq(stats::ppoints(nbval), df = ddl), pred,
                xlab = paste0("theoretical chi-squared quantiles (df = ", ddl, ")"),
                ylab = "observed Mahalanobis distances (presences)",
                main = main, panel.first = graphics::grid(), ...)
  graphics::abline(0, 1, col = "red", lwd = 2)
  invisible(pred)
}
