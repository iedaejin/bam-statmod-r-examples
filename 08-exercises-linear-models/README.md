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
2. **Class notes:** Chapter 5, *The linear model in theory*; Chapter 6, *Diagnostics and prediction*; Chapter 7, *Linear models in practice and model selection* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** we work the problems in [exercises.md](exercises.md) in groups, by hand first. The R scripts that check the answers are published here after the session.
4. **Problem set of this block:** [PS2-linear-models](../problem-sets/PS2-linear-models.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

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

**Recommended reading**

- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144  
  → Ch. 2 Estimation (pp. 13–31); Ch. 3 Inference (pp. 33–50); Ch. 4 Prediction (pp. 51–58); Ch. 5 Explanation (pp. 59–71); Ch. 6 Diagnostics (pp. 73–98); Ch. 7 Problems with the predictors (pp. 99–111); Ch. 10 Model selection (pp. 149–160); Ch. 11 Shrinkage methods (pp. 161–181) — end-of-chapter exercises

---
[← All sessions](../README.md)
