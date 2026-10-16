# Session 3 — Maximum Likelihood Estimation

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Derive** the log-likelihood, score, MLE and information for standard one- and two-parameter models.
2. **Distinguish** observed information $I(\theta)$ from expected information $\mathcal I(\theta)$ and **compute** $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$.
3. **Compute** and **compare** Wald, score and likelihood-ratio tests and intervals.
4. **Implement** a numerical MLE with Newton–Raphson and `optim()`, using a sensible parametrization.
5. **Diagnose** boundary estimates, multiple maxima and non-identifiability.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_01_Maximum_Likelihood](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_01_Maximum_Likelihood) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`03-likelihood-basics.Rmd`](03-likelihood-basics.Rmd) · [`.R`](03-likelihood-basics.R) | Likelihood, score and information | Binomial: 8 successes in 10 trials; Normal MLE for New Haven temperatures; Observed and expected information as functions of $\theta$; More data, sharper peak, smaller standard error |
| [`03-wald-score-lr.Rmd`](03-wald-score-lr.Rmd) · [`.R`](03-wald-score-lr.R) | Wald, score and likelihood-ratio tests and intervals | The geometry of the three tests; The three tests in R; Computing a likelihood interval; aircondit: a skewed log-likelihood; Profile likelihood: the ridge of the surface |
| [`03-numerical-optimization.Rmd`](03-numerical-optimization.Rmd) · [`.R`](03-numerical-optimization.R) | Numerical maximum likelihood | Newton–Raphson by hand; The same fit with `optim()`; Several maxima: Cauchy location; Non-identifiability: a flat ridge |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Pawitan Ch. 2 — Elements of likelihood inference](03-pawitan-ch2-summary.md)
- [Pawitan Ch. 3 — More properties of the likelihood](03-pawitan-ch3-summary.md)
- [Pawitan Ch. 8 — Score function and Fisher information](03-pawitan-ch8-summary.md)
- [Pawitan Ch. 9 — Large-sample results](03-pawitan-ch9-summary.md)
- [Pawitan Ch. 12 — EM Algorithm](03-pawitan-ch12-summary.md) (optional, not examined)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Dempster, A. P., Laird, N. M. and Rubin, D. B. (1977). Maximum Likelihood from Incomplete Data Via the EM Algorithm. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 39(1), 1–22. https://doi.org/10.1111/j.2517-6161.1977.tb01600.x
- Efron, B. and Hinkley, D. V. (1978). Assessing the accuracy of the maximum likelihood estimator: Observed versus expected Fisher information. *Biometrika* 65(3), 457–483. https://doi.org/10.1093/biomet/65.3.457
- Fisher, R. A. (1922). On the mathematical foundations of theoretical statistics. *Philosophical Transactions of the Royal Society of London. Series A, Containing Papers of a Mathematical or Physical Character* 222(594-604), 309–368. https://doi.org/10.1098/rsta.1922.0009
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001
- Proschan, F. (1963). Theoretical Explanation of Observed Decreasing Failure Rate. *Technometrics* 5(3), 375–383. https://doi.org/10.1080/00401706.1963.10490105
- Rao, C. R. (1948). Large sample tests of statistical hypotheses concerning several parameters with applications to problems of estimation. *Mathematical Proceedings of the Cambridge Philosophical Society* 44(1), 50–57. https://doi.org/10.1017/s0305004100023987
- Wald, A. (1943). Tests of statistical hypotheses concerning several parameters when the number of observations is large. *Transactions of the American Mathematical Society* 54(3), 426–482. https://doi.org/10.1090/s0002-9947-1943-0012401-3
- Wilks, S. S. (1938). The Large-Sample Distribution of the Likelihood Ratio for Testing Composite Hypotheses. *The Annals of Mathematical Statistics* 9(1), 60–62. https://doi.org/10.1214/aoms/1177732360

---
[← All sessions](../README.md)
