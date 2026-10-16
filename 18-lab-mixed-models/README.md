# Session 18 — Computer Lab — Mixed Models in R

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** LMMs with `lmer()` and `lme()` and **interpret** their variance components.
2. **Choose** REML or ML for each comparison and **test** a random slope with the boundary correction.
3. **Compute** BLUPs and the shrinkage factor, and **draw** a shrinkage plot.
4. **Diagnose** an LMM with residuals and predicted random effects.
5. **Fit** a binomial GLMM and **distinguish** conditional from marginal effects.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_04_Mixed_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`18-lab-walkthrough.Rmd`](18-lab-walkthrough.Rmd) · [`.R`](18-lab-walkthrough.R) | Lab 04 walk-through: lmer, lme and glmer | Setup; Part 1: three ways to pool |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 2 — Linear mixed models](../15-linear-mixed-models/15-wood-ch2-summary.md)
- [Wood Ch. 3, GLMM sections — Generalized linear mixed models](../17-glmm/17-wood-ch3-glmm-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Bates, D., Mächler, M., Bolker, B. and Walker, S. (2015). Fitting Linear Mixed-Effects Models Using lme4. *Journal of Statistical Software* 67(1), 1–48. https://doi.org/10.18637/jss.v067.i01
- Belenky, G., Wesensten, N. J., Thorne, D. R., et al. (2003). Patterns of performance degradation and restoration during sleep restriction and subsequent recovery: a sleep dose‐response study. *Journal of Sleep Research* 12(1), 1–12. https://doi.org/10.1046/j.1365-2869.2003.00337.x
- Bolker, B. M., Brooks, M. E., Clark, C. J., et al. (2009). Generalized linear mixed models: a practical guide for ecology and evolution. *Trends in Ecology & Evolution* 24(3), 127–135. https://doi.org/10.1016/j.tree.2008.10.008
- Breslow, N. E. and Clayton, D. G. (1993). Approximate Inference in Generalized Linear Mixed Models. *Journal of the American Statistical Association* 88(421), 9–25. https://doi.org/10.1080/01621459.1993.10594284
- Faraway, J. J. (2016). *Extending the Linear Model with R: Generalized Linear, Mixed Effects and Nonparametric Regression Models*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315382722
- Laird, N. M. and Ware, J. H. (1982). Random-Effects Models for Longitudinal Data. *Biometrics* 38(4), 963–974. https://doi.org/10.2307/2529876
- Lesnoff, M., Laval, G., Bonnet, P., et al. (2004). Within-herd spread of contagious bovine pleuropneumonia in Ethiopian highlands. *Preventive Veterinary Medicine* 64(1), 27–40. https://doi.org/10.1016/j.prevetmed.2004.03.005
- Pinheiro, J. C. and Bates, D. M. (1995). Approximations to the Log-Likelihood Function in the Nonlinear Mixed-Effects Model. *Journal of Computational and Graphical Statistics* 4(1), 12–35. https://doi.org/10.1080/10618600.1995.10474663
- Pinheiro, J. C. and Bates, D. M. (2000). *Mixed-Effects Models in S and S-PLUS*. Springer. https://doi.org/10.1007/b98882
- Stram, D. O. and Lee, J. W. (1994). Variance Components Testing in the Longitudinal Mixed Effects Model. *Biometrics* 50(4), 1171–1177. https://doi.org/10.2307/2533455

---
[← All sessions](../README.md)
