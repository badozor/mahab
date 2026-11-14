mahab <- function(df, pr, method = c("raw", "classical", "robust"), ...) {
  if (!inherits(df, "data.frame"))
    stop("'df' must be a data frame")
  if (!all(vapply(df, is.numeric, logical(1))))
    stop("all columns of 'df' must be numeric")
  if (!is.vector(pr) || length(pr) != nrow(df))
    stop("'pr' must be a vector with one value per row of 'df'")
  if (anyNA(pr) || !all(pr %in% c(0, 1)))
    stop("'pr' must contain only 0 and 1 values")
  if (sum(pr == 1) < 2)
    stop("at least two presence records (pr == 1) are needed")
  method <- match.arg(method)
  used <- df[pr == 1, , drop = FALSE]
  if (method == "raw") {
    mu <- colMeans(used, na.rm = TRUE)
    centred <- sweep(as.matrix(used), 2, mu)
    varcov <- crossprod(centred) / nrow(centred)
  } else if (method == "classical") {
    varcov <- stats::cov(used, ...)
    mu <- colMeans(used, na.rm = TRUE)
  } else {
    if (!requireNamespace("robust", quietly = TRUE))
      stop("package 'robust' is required for method = \"robust\"")
    cvrob <- robust::covRob(used, ...)
    varcov <- cvrob$cov
    mu <- cvrob$center
  }
  dist1 <- stats::mahalanobis(as.matrix(df), mu, varcov)
  res <- list(data = df, pr = pr, mu = mu, varcov = varcov,
              varnames = names(df), call = match.call(),
              method = method, dist = dist1)
  class(res) <- "mahab"
  res
}
