# Session 15 — Linear Mixed Models

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Recognise** clustered, hierarchical and repeated-measures data and **explain** why $\varepsilon\sim N(0,\sigma^2 I)$ fails.
2. **Compare** complete, no and partial pooling on the same data.
3. **Choose** between fixed and random group effects and **state** the assumption each one makes.
4. **Write** random-intercept and random-intercept-and-slope models in scalar and matrix form.
5. **Derive** the marginal mean and covariance $V = ZGZ^\top + \sigma^2 I$, compound symmetry and the ICC.
6. **Interpret** estimated variance components on the scale of the data.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_04_Mixed_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`15-pooling.Rmd`](15-pooling.Rmd) · [`.R`](15-pooling.R) | Complete, no and partial pooling (sleepstudy) | The residuals of one pooled `lm()` are correlated; Complete vs no vs partial pooling (six subjects); Partial pooling in the (intercept, slope) plane; Ignoring the grouping gives the wrong standard error |
| [`15-random-intercept-slope.Rmd`](15-random-intercept-slope.Rmd) · [`.R`](15-random-intercept-slope.R) | Random intercepts, random slopes and the implied covariance | Random intercept for `sleepstudy`; Implied correlation of one subject's ten measurements; Random intercept and slope for `sleepstudy`; ICC and $V_i$ by hand |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 2 — Linear mixed models](15-wood-ch2-summary.md)
- [Pawitan Ch. 17 — Random and mixed effects models](15-pawitan-ch17-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Bates, D., Mächler, M., Bolker, B. and Walker, S. (2015). Fitting Linear Mixed-Effects Models Using lme4. *Journal of Statistical Software* 67(1), 1–48. https://doi.org/10.18637/jss.v067.i01
- Belenky, G., Wesensten, N. J., Thorne, D. R., et al. (2003). Patterns of performance degradation and restoration during sleep restriction and subsequent recovery: a sleep dose‐response study. *Journal of Sleep Research* 12(1), 1–12. https://doi.org/10.1046/j.1365-2869.2003.00337.x
- Faraway, J. J. (2016). *Extending the Linear Model with R: Generalized Linear, Mixed Effects and Nonparametric Regression Models*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315382722
- Gelman, A. and Hill, J. (2006). *Data Analysis Using Regression and Multilevel/Hierarchical Models*. Cambridge University Press. https://doi.org/10.1017/cbo9780511790942
- Laird, N. M. and Ware, J. H. (1982). Random-Effects Models for Longitudinal Data. *Biometrics* 38(4), 963–974. https://doi.org/10.2307/2529876
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001
- Pinheiro, J. C. and Bates, D. M. (2000). *Mixed-Effects Models in S and S-PLUS*. Springer. https://doi.org/10.1007/b98882
- Robinson, G. K. (1991). That BLUP is a Good Thing: The Estimation of Random Effects. *Statistical Science* 6(1), 15–32. https://doi.org/10.1214/ss/1177011926
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279

---
[← All sessions](../README.md)
