# Session 3 — Readings

**Topic:** Maximum likelihood estimation
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Chapter | Focus |
|------|---------|-------|
| Pawitan (2001), *In All Likelihood* | Ch. 2 — Elements of likelihood inference | Definition of the likelihood; likelihood ratio; MLE; likelihood-based intervals and the 0.15 cut-off; combining likelihoods from independent samples |
| Pawitan (2001) | Ch. 8 — Score function and Fisher information | $\mathbb E[S]=0$, $\mathrm{Var}[S]=\mathcal I$; observed vs expected information |
| Pawitan (2001) | Ch. 9 — Large-sample results | Asymptotic normality of the MLE; Wald, score and LR tests; why they agree as $n\to\infty$ |

Section numbers vary between printings; check them against the library copy.

## Optional

| Text | Chapter | Why |
|------|---------|-----|
| Pawitan (2001) | Ch. 3 — More properties of the likelihood | Several parameters and profile likelihood (§3.3–3.4, core); sufficiency and AIC (optional). Invariance and reparametrization are in Ch. 2 (§2.8–2.9) |
| Pawitan (2001) | Ch. 12 — EM algorithm | Only if you want the optional EM frames; not examined |
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Appendix A (maximum likelihood estimation) | A compact summary of the large-sample theory used later for GLMs and GAMs |

## What to focus on

1. The likelihood is a function of $\theta$ for fixed data. It is not a probability distribution for $\theta$.
2. Notation (used all term): score $S(\theta)$; observed information $I(\theta)=-\ell''(\theta)$ for the whole sample; expected information $\mathcal I(\theta)=\mathbb E[I(\theta)]$; per observation $\mathcal I_1$, with $\mathcal I=n\mathcal I_1$ for iid data; $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$.
3. Three tests of $H_0:\theta=\theta_0$: Wald (curvature at $\hat\theta$), score (slope at $\theta_0$), likelihood ratio (height difference). All $\approx\chi^2_1$; they disagree in small samples.
4. The 95% likelihood interval is $\{\theta:\ell(\theta)\ge\ell(\hat\theta)-1.92\}$, i.e. relative likelihood $\ge 0.147$.
5. Newton–Raphson: $\theta_{k+1}=\theta_k+I(\theta_k)^{-1}S(\theta_k)$. Fisher scoring uses $\mathcal I$ instead of $I$.

## Reading questions

1. Why can we drop multiplicative constants from $L(\theta)$ but not from a density?
2. In what sense is the MLE "efficient"? Is it efficient for every $n$?
3. Which of the three tests needs only the null model to be fitted? Why is that useful?
4. Why does reparametrization change a Wald interval but not a likelihood interval?
5. Give one model in which the observed and expected information are equal for every $\theta$.

## R

Knit `03-likelihood-basics.Rmd`, `03-wald-score-lr.Rmd` and `03-numerical-optimization.Rmd` before the lab.

## Reading summaries

Study guides to the chapters above. They send you to the book; they do not replace it.

- [Pawitan Ch. 2 — Elements of likelihood inference](03-pawitan-ch2-summary.md)
- [Pawitan Ch. 3 — More properties of the likelihood](03-pawitan-ch3-summary.md)
- [Pawitan Ch. 8 — Score function and Fisher information](03-pawitan-ch8-summary.md)
- [Pawitan Ch. 9 — Large-sample results](03-pawitan-ch9-summary.md)
- [Pawitan Ch. 12 — EM Algorithm](03-pawitan-ch12-summary.md) (optional, not examined)

## Next

**Session 4 — Lab 01: Maximum likelihood in R** (`discoveries`, `MASS::geyser`).
