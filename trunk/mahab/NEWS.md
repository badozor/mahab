# mahab 0.4 (2026-11-14)

* Package renamed from MAHAB to mahab.

## Bug fixes

* `mahab(method = "classical")` failed: `cov()` returns a matrix, not a list.
  The mean is now taken with `colMeans()`.
* `mahab()` called without `method` failed on R >= 4.2 ("the condition has
  length > 1"). `method` is now matched with `match.arg()`. Same fix for
  `type` in `predict.mahab()`.
* `mahab(method = "raw")` used the uncentred cross-product of the presence
  table, i.e. Sigma + mu mu' in place of Sigma. `mahasuhab()` avoids this by
  adding a column of 1s, which `mahab()` did not do. The covariance is now the
  centred cross-product divided by n. Distances now equal those of
  `adehabitatHS::mahasuhab()`. **Results of `"raw"` change.**
* `predict.mahab(type = "proba")` and `qqmahab()` used p - 1 degrees of
  freedom. They now use p, the number of variables, as expected for a squared
  Mahalanobis distance. **Probabilities change.**
* `predict.mahab(na.rm = TRUE)` put the NA values at the wrong positions. The
  output now has one value per site, NA for dropped sites.
* `predict()`, `print()` and `plot()` methods were not registered. The package
  now has an explicit NAMESPACE with `S3method()` entries.
* `qqmahab()`: axis labels were swapped. The x axis shows the theoretical
  chi-squared quantiles, the y axis the observed distances.

## Other changes

* `robust` moved from `Depends` to `Suggests`. It is only needed for
  `method = "robust"`.
* `adehabitat` (archived on CRAN) replaced by `adehabitatHS` in `Suggests`
  and in the help links.
* Input checks in `mahab()`: numeric columns, length of `pr`, at least two
  presences. `predict.mahab()` checks that `newdata` holds all variables.
* `print.mahab()` and `plot.mahab()` return `x` invisibly. `qqmahab()` returns
  the distances of presence sites invisibly.
* Maintainer email changed to pierre.bady@gmail.com.
* DESCRIPTION updated: `Authors@R`, `License: GPL-3` (same as the repository `LICENSE`), `Encoding: UTF-8`,
  invalid `URL` field removed, title typo fixed.

## Documentation

* All help files converted to UTF-8 with LF line endings.
* Help files and DESCRIPTION proofread for grammar and spelling (British
  English throughout).
* Typos fixed ("Malahanobis", "specie", "Dispaly", "Chisq-Squared",
  "JEcological", stray `\crs` and `>`).
* Placeholder sections ("description of the graphic", etc.) replaced by real
  content. Formulas written with `\eqn{}` / `\deqn{}`.
* `mahab.Rd`: `\value` listed `mu` twice and omitted `varcov`, `method` and
  `dist`.
* Links fixed: `cov` belongs to `stats`, not `robust`; `adehabitat` links now
  point to `adehabitatHS`.
* Saporta reference corrected (title, accents); unfinished references removed;
  Mahalanobis (1936) added.
* Empty `\keyword{}` replaced by standard keywords.
* Examples use named variables and `set.seed()`; the robust example runs only
  if `robust` is installed.
