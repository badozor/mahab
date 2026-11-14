# mahab

Species distribution mapping based on the Mahalanobis distance.

`mahab` maps species distributions from an ordinary table of environmental
variables measured at sites (rows = sites, columns = variables). The habitat of
a species is summarised by the mean and the variance-covariance matrix of the
environmental variables at presence sites. Every site is then scored by its
Mahalanobis distance to this mean habitat (Clark et al. 1993).

The main function adapts `mahasuhab()` from the
[adehabitatHS](https://cran.r-project.org/package=adehabitatHS) package to
ordinary data frames, with no need for spatial objects.

## Background

This package was developed during an older project dated 2007-2008
([EFI+](https://cordis.europa.eu/project/id/44096/fr)). The prediction limits
(`predict(..., interval = TRUE)`) are still experimental.

## Installation

From GitHub:

```r
# install.packages("remotes")
remotes::install_github("badozor/mahab", subdir = "trunk/mahab")
```

From the source archive in this repository:

```r
install.packages("trunk/Rpackage/mahab_0.4.tar.gz", repos = NULL, type = "source")
```

The `robust` package is optional. It is only needed for `method = "robust"`.

## Main functions

| Function | Purpose |
|---|---|
| `mahab()` | Estimates the mean habitat and the covariance matrix from presence records, and computes the distances. |
| `predict()` | Computes distances, probabilities or scores for the fitted data or for new data. |
| `plot()` | Plots the density of each variable at presence and absence sites. |
| `qqmahab()` | Draws a chi-squared QQ plot of the distances at presence sites. |

Three estimators of the covariance matrix are available:

- `"raw"`: maximum-likelihood estimator (same distances as `mahasuhab()`);
- `"classical"`: `stats::cov()`;
- `"robust"`: `robust::covRob()`, useful when presence records contain outliers.

## Example

```r
library(mahab)

set.seed(1)
df <- data.frame(temp  = sort(rnorm(30, 0, 1)),
                 depth = sort(rnorm(30, 6, 5)),
                 slope = sort(rnorm(30, -4, 2)))
pr <- c(rep(1, 15), rep(0, 15))

fit <- mahab(df, pr, method = "raw")
fit

# habitat suitability
d  <- predict(fit, type = "dist")    # squared Mahalanobis distance
p  <- predict(fit, type = "proba")   # 1 - pchisq(D2, df = p)
sc <- predict(fit, type = "score")   # 1 / (1 + D2)

# diagnostics
plot(fit)
qqmahab(fit)
```

## Documentation

- Reference manual: [`trunk/documentation/mahab-manual.pdf`](trunk/documentation/mahab-manual.pdf)
- Changes: [`trunk/mahab/NEWS.md`](trunk/mahab/NEWS.md)

## Repository layout

```
trunk/
├── mahab/           package sources
├── Rpackage/        source archive (mahab_0.4.tar.gz)
└── documentation/   reference manual (PDF)
```

## References

Clark, J.D., Dunn, J.E. and Smith, K.G. (1993) A multivariate model of female
black bear habitat use for a geographic information system. *Journal of
Wildlife Management*, 57, 519–526.

Calenge, C. (2006) The package "adehabitat" for the R software: a tool for the
analysis of space and habitat use by animals. *Ecological Modelling*, 197,
516–519.

## Author

Pierre Bady (<pierre.bady@gmail.com>)

## License

GPL-3. See [`LICENSE`](LICENSE).
