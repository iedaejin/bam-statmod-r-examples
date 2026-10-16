# Session 19 — Mixed-Model Exercises

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Choose** fixed or random effects for a described study and **justify** the choice.
2. **Write** $Z$, $G$ and $V$ for a small design and **compute** the ICC and BLUP shrinkage by hand.
3. **Compare** random-effect structures with the correct likelihood (ML/REML) and reference distribution.
4. **Interpret** printed `lmer` and `glmer` output, including conditional vs marginal effects.
5. **Diagnose** an LMM from residual and BLUP plots.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** we work the problems in [exercises.md](exercises.md) in groups, by hand first. The R scripts that check the answers are published here after the session.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 2 — Linear mixed models](../15-linear-mixed-models/15-wood-ch2-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Bates, D., Mächler, M., Bolker, B. and Walker, S. (2015). Fitting Linear Mixed-Effects Models Using lme4. *Journal of Statistical Software* 67(1), 1–48. https://doi.org/10.18637/jss.v067.i01
- Faraway, J. J. (2016). *Extending the Linear Model with R: Generalized Linear, Mixed Effects and Nonparametric Regression Models*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315382722
- Gelman, A. and Hill, J. (2006). *Data Analysis Using Regression and Multilevel/Hierarchical Models*. Cambridge University Press. https://doi.org/10.1017/cbo9780511790942
- Laird, N. M. and Ware, J. H. (1982). Random-Effects Models for Longitudinal Data. *Biometrics* 38(4), 963–974. https://doi.org/10.2307/2529876
- Self, S. G. and Liang, K.-Y. (1987). Asymptotic Properties of Maximum Likelihood Estimators and Likelihood Ratio Tests under Nonstandard Conditions. *Journal of the American Statistical Association* 82(398), 605–610. https://doi.org/10.1080/01621459.1987.10478472
- Stram, D. O. and Lee, J. W. (1994). Variance Components Testing in the Longitudinal Mixed Effects Model. *Biometrics* 50(4), 1171–1177. https://doi.org/10.2307/2533455

---
[← All sessions](../README.md)
