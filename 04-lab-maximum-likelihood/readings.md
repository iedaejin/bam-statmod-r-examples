# Session 4 — Readings

**Topic:** Computer lab — maximum likelihood estimation in R (Lab 01)
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Chapter | Focus |
|------|---------|-------|
| Pawitan (2001), *In All Likelihood* | Ch. 2 — Elements of likelihood inference | Likelihood intervals; the $\ell(\hat\theta)-1.92$ cut-off; LR tests |
| Pawitan (2001) | Ch. 9 — Large-sample results | Wald vs LR; the regularity conditions behind the $\chi^2$ approximation (what happens when they fail — boundary, non-identifiability — is shown in the lab, not in the book) |

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

## Reading summaries

Study guides to the chapters above. They send you to the book; they do not replace it.

- [Pawitan Ch. 2 — Elements of likelihood inference](../03-maximum-likelihood/03-pawitan-ch2-summary.md)
- [Pawitan Ch. 9 — Large-sample results](../03-maximum-likelihood/03-pawitan-ch9-summary.md)
- [Pawitan Ch. 12 — EM Algorithm](../03-maximum-likelihood/03-pawitan-ch12-summary.md) (optional, not examined)

## Next

**Session 5 — Linear models in theory.** Faraway (2014) Ch. 2.
