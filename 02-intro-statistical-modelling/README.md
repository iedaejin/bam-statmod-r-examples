# Session 2 — Introduction to Statistical Modelling

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Formulate** a statistical model as a systematic part plus a random part, $y_i=f(x_i;\beta)+\varepsilon_i$, and state its assumptions.
2. **Derive** the least-squares estimate of a constant mean ($\hat\mu=\bar y$) and its variance $\sigma^2/n$.
3. **Compare** a constant-mean and a linear-trend model using residuals, simulation from the fitted model and a hold-out check.
4. **Distinguish** variability ($\sigma$) from uncertainty ($\mathrm{se}(\hat\theta)$), and a confidence interval from a prediction interval.
5. **Diagnose** threats from data quality: measurement error, missingness (MCAR/MAR/MNAR) and selection.
6. **Produce** a reproducible R analysis: project, relative paths, `set.seed()`, Quarto/R Markdown, `sessionInfo()`.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **Class notes:** Chapter 2, *Statistical models* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_00_Reproducible_R](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_00_Reproducible_R) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS1-likelihood](../problem-sets/PS1-likelihood.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`02-nhtemp-two-models.Rmd`](02-nhtemp-two-models.Rmd) · [`.R`](02-nhtemp-two-models.R) | Two models for the New Haven temperatures | Sixty years of temperatures in New Haven; Fitting both models in R; The two fitted models; Residuals: what the systematic part leaves behind; Normality and independence of the model 2 residuals; A predictive check on New Haven |
| [`02-simulate-from-model.Rmd`](02-simulate-from-model.Rmd) · [`.R`](02-simulate-from-model.R) | Simulating from a fitted model | Simulating from the fitted model in R; Line-up: which panel is the real New Haven series?; Slopes of 1000 simulated series under each model; Simulation: variability stays, uncertainty shrinks |
| [`02-data-quality.Rmd`](02-data-quality.Rmd) · [`.R`](02-data-quality.R) | Data quality: missingness, selection and measurement error | Measurement error; Selection bias: a thought experiment with New Haven |
| [`02-reproducible-workflow.Rmd`](02-reproducible-workflow.Rmd) · [`.R`](02-reproducible-workflow.R) | A reproducible workflow in R | A reproducible script |

The scripts read the CSV files in [`data/`](data/) with relative paths. Set the working directory to this folder (open it as an RStudio project, or *Session → Set Working Directory → To Source File Location*).

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Pawitan Ch. 1 — Introduction](../01-course-overview-prerequisites/01-pawitan-ch1-summary.md)
- [Breiman (2001) — Statistical Modeling: The Two Cultures](02-breiman-2001-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001  
  → Ch. 1 Introduction (pp. 1–20)

**Original papers** (optional: where the methods come from)

- Box, G. E. P. (1976). Science and Statistics. *Journal of the American Statistical Association* 71(356), 791–799. https://doi.org/10.1080/01621459.1976.10480949
- Breiman, L. (2001). Statistical Modeling: The Two Cultures. *Statistical Science* 16(3), 199–231. https://doi.org/10.1214/ss/1009213726
- Shmueli, G. (2010). To Explain or to Predict?. *Statistical Science* 25(3), 289–310. https://doi.org/10.1214/10-sts330

---
[← All sessions](../README.md)
