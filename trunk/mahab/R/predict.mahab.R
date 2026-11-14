predict.mahab <- function(object, newdata, type = c("dist", "proba", "score"),
                          na.rm = FALSE, interval = FALSE, level = 0.90, ...) {
  if (!inherits(object, "mahab"))
    stop("'object' must be of class 'mahab'")
  type <- match.arg(type)
  if (!is.numeric(level) || length(level) != 1 || level <= 0 || level >= 1)
    stop("'level' must be a single number in (0, 1)")
  if (!missing(newdata)) {
    miss <- setdiff(object$varnames, names(newdata))
    if (length(miss))
      stop("variables missing from 'newdata': ", paste(miss, collapse = ", "))
    data1 <- newdata[, object$varnames, drop = FALSE]
  } else {
    data1 <- object$data
  }
  keep <- if (na.rm) stats::complete.cases(data1) else rep(TRUE, nrow(data1))
  map <- rep(NA_real_, nrow(data1))
  names(map) <- rownames(data1)
  map[keep] <- stats::mahalanobis(as.matrix(data1[keep, , drop = FALSE]),
                                  object$mu, object$varcov)
  if (type == "proba")
    map <- 1 - stats::pchisq(map, df = ncol(data1))
  if (type == "score")
    map <- 1 / (1 + map)
  if (na.rm && any(!keep)) {
    naomit <- which(!keep)
    names(naomit) <- rownames(data1)[!keep]
    class(naomit) <- "omit"
    attr(map, "na.action") <- naomit
  }
  if (interval && type == "dist") {
    alpha <- (1 - level) / 2
    lower <- stats::qchisq(alpha, df = map)
    upper <- stats::qchisq(1 - alpha, df = map + 1)
    names(lower) <- names(upper) <- names(map)
    map <- list(map = map, lower = lower, upper = upper)
  }
  map
}
