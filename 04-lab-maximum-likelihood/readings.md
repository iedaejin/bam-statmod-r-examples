# Session 4 — Readings

**Topic:** Computer lab — maximum likelihood estimation in R (Lab 01)
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Chapter | Focus |
|------|---------|-------|
| Pawitan (2001), *In All Likelihood* | Ch. 2 — Elements of likelihood inference | Likelihood intervals; the $\ell(\hat\theta)-1.92$ cut-off; LR tests |
| Pawitan (2001) | Ch. 9 — Large-sample results | Wald vs LR; when the $\chi^2$ approximation fails (boundary, non-identifiability) |

Review the Session 3 slides and `03-numerical-optimization.Rmd` before the lab.

## Optional

| Text | Chapter | Why |
|------|---------|-----|
| Pawitan (2001) | Ch. 12 — EM algorithm | The classical alternative to `optim()` for mixtures (extension task 3) |
| R documentation | `?optim`, `?uniroot` | Methods, `control` options, the meaning of `convergence` codes |

## What to focus on

1. Writing a negative log-likelihood in R with `log = TRUE` densities.
2. Reparametrising ($\log\lambda$, $\mathrm{logit}\,p$, $\log\sigma$) and going back with the delta method.
3. Reading a Hessian: standard errors from the diagonal of its inverse; eigenvalues to tell a maximum from a saddle.
4. The difference between "the algorithm converged" and "we found the MLE".

## Lab files

- Lab: `R Labs/bam-statmod-labs/Lab_01_Maximum_Likelihood/` — https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_01_Maximum_Likelihood
- R examples: `04-mle-toolkit.Rmd`, `04-mixture-starts.Rmd`
- Extension tasks: `04-exercises.md`

## Next

**Session 5 — Linear models in theory.** Faraway (2014) Ch. 2.
