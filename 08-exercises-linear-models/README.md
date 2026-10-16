# Session 8 — Linear-Model Exercises

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Formulate** a linear model with a binary predictor and an interaction, and **interpret** each coefficient in context.
2. **Compute** $t$ statistics, confidence intervals, nested $F$ tests and prediction intervals from printed output, without software.
3. **Diagnose** non-constant variance, outliers and influence from residual plots and summary numbers.
4. **Choose** and **defend** a model for an explanatory or a predictive question.
5. **Prove** $H^2=H$, $\operatorname{tr}H=p$, $E[\mathrm{RSS}]=\sigma^2(n-p)$, and **derive** the variance of a prediction error.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** we work the problems in [exercises.md](exercises.md) in groups, by hand first. The R scripts that check the answers are published here after the session.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 1 — Introduction](../01-course-overview-prerequisites/01-faraway-ch1-summary.md) (Session 1)
- [Faraway Ch. 2 — Estimation](../05-linear-models-theory/05-faraway-ch2-summary.md) (Session 5)
- [Faraway Ch. 3 — Inference](../05-linear-models-theory/05-faraway-ch3-summary.md) (Session 5)
- [Faraway Ch. 4 — Prediction](../05-linear-models-theory/05-faraway-ch4-summary.md) (Session 5)
- [Faraway Ch. 5 — Explanation](../06-linear-models-practice-model-selection/06-faraway-ch5-summary.md) (Session 6)
- [Faraway Ch. 6 — Diagnostics](../07-lab-linear-models-diagnostics/07-faraway-ch6-summary.md) (Session 7)
- [Faraway Ch. 7 — Problems with the Predictors](../07-lab-linear-models-diagnostics/07-faraway-ch7-summary.md) (Session 7)
- [Faraway Ch. 9 — Transformation](../20-polynomial-scatterplot-smoothing/20-faraway-ch9-summary.md) (Session 20; polynomials and splines)
- [Faraway Ch. 10 — Model Selection](../06-linear-models-practice-model-selection/06-faraway-ch10-summary.md) (Session 6)
- [Faraway Ch. 11 — Shrinkage Methods](../06-linear-models-practice-model-selection/06-faraway-ch11-summary.md) (Session 6)
- [Faraway Ch. 14 — Categorical Predictors](../06-linear-models-practice-model-selection/06-faraway-ch14-summary.md) (Session 6)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Cook, R. D. (1977). Detection of Influential Observation in Linear Regression. *Technometrics* 19(1), 15–18. https://doi.org/10.1080/00401706.1977.10489493
- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144
- Ide-Smith, S. G. and Lea, S. E. G. (1988). Gambling in young adolescents. *Journal of Gambling Behavior* 4(2), 110–118. https://doi.org/10.1007/bf01020107
- Kutner, M. H., Nachtsheim, C. J., Neter, J. and Li, W. (2005). *Applied Linear Statistical Models*, 5th ed. McGraw-Hill/Irwin. ISBN 0072386886

---
[← All sessions](../README.md)
