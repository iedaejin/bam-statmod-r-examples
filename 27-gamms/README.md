# Session 27 — Generalized Additive Mixed Models

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Derive** the mixed-model form of a P-spline and **show** that $\lambda=\sigma^2/\sigma_b^2$.
2. **Verify** numerically that REML for the variance components gives the smoothing parameter of `gam()`.
3. **Specify** random intercepts, random slopes and subject-specific smooths inside a GAM.
4. **Fit** GAMMs with `gamm()` and `gamm4()`, and **choose** which component to read for which question.
5. **Diagnose** residual correlation and **add** a `corAR1` structure when needed.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_07_GAMMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_07_GAMMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`27-smoother-mixed-model.Rmd`](27-smoother-mixed-model.Rmd) · [`.R`](27-smoother-mixed-model.R) | A penalized spline is a mixed model | What the columns of $Z$ look like; Numerical check (1/2): build $X$ and $Z$; Fixed part and random part |
| [`27-random-effects-gam.Rmd`](27-random-effects-gam.Rmd) · [`.R`](27-random-effects-gam.R) | Random effects inside GAMs: Oxboys growth curves | `s(Subject, bs = "re")` on Oxboys; Population and subject curves; `gamm4::gamm4()`: the `lme4` back end |
| [`27-gamm-correlation.Rmd`](27-gamm-correlation.Rmd) · [`.R`](27-gamm-correlation.R) | gamm(): the $gam and $lme parts, and correlated residuals | `mgcv::gamm()`: two objects in one; Daily ozone with AR(1) errors |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 6–7, GAMM sections — Generalized additive mixed models](27-wood-gamm-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Currie, I. D. and Durban, M. (2002). Flexible smoothing with P-splines: a unified approach. *Statistical Modelling* 2(4), 333–349. https://doi.org/10.1191/1471082x02st039ob
- Eilers, P. H. C. and Marx, B. D. (1996). Flexible smoothing with B-splines and penalties. *Statistical Science* 11(2), 89–121. https://doi.org/10.1214/ss/1038425655
- Eilers, P. H. C. and Marx, B. D. (2021). *Practical Smoothing: The Joys of P-splines*. Cambridge University Press. https://doi.org/10.1017/9781108610247
- Lin, X. and Zhang, D. (1999). Inference in Generalized Additive Mixed Models by Using Smoothing Splines. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 61(2), 381–400. https://doi.org/10.1111/1467-9868.00183
- Pedersen, E. J., Miller, D. L., Simpson, G. L. and Ross, N. (2019). Hierarchical generalized additive models in ecology: an introduction with mgcv. *PeerJ* 7, e6876. https://doi.org/10.7717/peerj.6876
- Rodríguez-Álvarez, M. X., Lee, D.-J., Kneib, T., et al. (2015). Fast smoothing parameter separation in multidimensional generalized P-splines: the SAP algorithm. *Statistics and Computing* 25(5), 941–957. https://doi.org/10.1007/s11222-014-9464-2
- Ruppert, D., Wand, M. P. and Carroll, R. J. (2003). *Semiparametric Regression*. Cambridge University Press. https://doi.org/10.1017/cbo9780511755453
- Verbyla, A. P., Cullis, B. R., Kenward, M. G. and Welham, S. J. (1999). The Analysis of Designed Experiments and Longitudinal Data by Using Smoothing Splines. *Journal of the Royal Statistical Society Series C: Applied Statistics* 48(3), 269–311. https://doi.org/10.1111/1467-9876.00154
- Wand, M. P. (2003). Smoothing and mixed models. *Computational Statistics* 18(2), 223–249. https://doi.org/10.1007/s001800300142
- Wood, S. N. (2011). Fast Stable Restricted Maximum Likelihood and Marginal Likelihood Estimation of Semiparametric Generalized Linear Models. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 73(1), 3–36. https://doi.org/10.1111/j.1467-9868.2010.00749.x
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279

---
[← All sessions](../README.md)
