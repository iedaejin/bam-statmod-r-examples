# Session 4 — Lab 01 — MLE in R

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Construct** a log-likelihood in R and **maximise** it with `optim()`.
2. **Compute** $\mathrm{se}(\hat\theta)$ from the Hessian, using the delta method after a reparametrization.
3. **Compare** Wald and likelihood-ratio intervals, and **check** the model behind them.
4. **Carry out** and **interpret** a likelihood-ratio test between nested models.
5. **Diagnose** non-convergence, label switching, saddle points and unbounded likelihoods.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_01_Maximum_Likelihood](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_01_Maximum_Likelihood) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`04-mle-toolkit.Rmd`](04-mle-toolkit.Rmd) · [`.R`](04-mle-toolkit.R) | A small toolkit for numerical MLE | Part 1: Poisson MLE with `optim()`; Wald and likelihood intervals |
| [`04-mixture-starts.Rmd`](04-mixture-starts.Rmd) · [`.R`](04-mixture-starts.R) | Mixtures, starting values and identifiability | Part 3: a two-component normal mixture; Twenty random starts |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Pawitan Ch. 2 — Elements of likelihood inference](../03-maximum-likelihood/03-pawitan-ch2-summary.md)
- [Pawitan Ch. 9 — Large-sample results](../03-maximum-likelihood/03-pawitan-ch9-summary.md)
- [Pawitan Ch. 12 — EM Algorithm](../03-maximum-likelihood/03-pawitan-ch12-summary.md) (optional, not examined)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Azzalini, A. and Bowman, A. W. (1990). A Look at Some Data on the Old Faithful Geyser. *Applied Statistics* 39(3), 357–365. https://doi.org/10.2307/2347385
- Dempster, A. P., Laird, N. M. and Rubin, D. B. (1977). Maximum Likelihood from Incomplete Data Via the EM Algorithm. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 39(1), 1–22. https://doi.org/10.1111/j.2517-6161.1977.tb01600.x
- Efron, B. and Hinkley, D. V. (1978). Assessing the accuracy of the maximum likelihood estimator: Observed versus expected Fisher information. *Biometrika* 65(3), 457–483. https://doi.org/10.1093/biomet/65.3.457
- Nelder, J. A. and Mead, R. (1965). A Simplex Method for Function Minimization. *The Computer Journal* 7(4), 308–313. https://doi.org/10.1093/comjnl/7.4.308
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001
- Self, S. G. and Liang, K.-Y. (1987). Asymptotic Properties of Maximum Likelihood Estimators and Likelihood Ratio Tests under Nonstandard Conditions. *Journal of the American Statistical Association* 82(398), 605–610. https://doi.org/10.1080/01621459.1987.10478472
- Wilks, S. S. (1938). The Large-Sample Distribution of the Likelihood Ratio for Testing Composite Hypotheses. *The Annals of Mathematical Statistics* 9(1), 60–62. https://doi.org/10.1214/aoms/1177732360

---
[← All sessions](../README.md)
