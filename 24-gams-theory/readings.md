# Session 24 — Readings

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Source | Sections | Focus |
|---|---|---|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | 5.3–5.4 | Thin-plate and cubic regression splines, P-splines; penalties as quadratic forms; smoother theory |
| Wood (2017) | 6.1–6.2 | Setting up a GAM as a penalized GLM; identifiability constraints; PIRLS; smoothness selection by GCV, UBRE, REML, ML |
| Wood (2017) | 6.10 | Other inference: posterior covariance, credible intervals, $p$-values for smooth terms |

## Optional

| Source | Sections | Focus |
|---|---|---|
| Wood (2017) | 5.9 | Checking the basis dimension (`gam.check`, k-index) |
| Wood (2011), *JRSS B* 73(1) | Sections 1–3 | Why REML/ML are more stable than GCV for smoothness selection |
| Wood (2013), *Biometrika* 100(1) | — | The approximate $p$-values reported by `summary.gam` |

## What to focus on

1. The derivation of PIRLS from the penalized log-likelihood, with $\lambda_j$ written once.
2. The QR reparametrisation that imposes the sum-to-zero constraint, and why it costs one degree of freedom.
3. GCV and UBRE as estimates of prediction error; REML and ML as marginal likelihoods of $\lambda$.
4. Why ML tends to give slightly smoother fits than REML (usually a small difference), and why `mgcv`'s default `"GCV.Cp"` can undersmooth.
5. edf $=\operatorname{tr}(F)$; the Bayesian covariance $V_\beta$ and what a pointwise credible band does and does not promise.

## R

Knit `24-penalized-fitting.Rmd` and `24-smoothing-selection.Rmd`.

## Reading summaries

- [Wood Ch. 6 — GAM theory](24-wood-ch6-summary.md)
- [Wood Ch. 5 — Smoothers](../21-splines/21-wood-ch5-summary.md)
