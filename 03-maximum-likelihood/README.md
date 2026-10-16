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
2. **Class notes:** Chapter 3, *Likelihood and maximum likelihood*; Chapter 4, *Likelihood-based inference and numerical optimisation* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_01_Maximum_Likelihood](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_01_Maximum_Likelihood) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS1-likelihood](../problem-sets/PS1-likelihood.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

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

**Recommended reading**

- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001  
  → Ch. 2 Elements of likelihood inference (pp. 21–52); Ch. 3 More properties of the likelihood (pp. 53–72); Ch. 8 Score function and Fisher information (pp. 213–229); Ch. 9 Large-sample results (pp. 231–271)

**Original papers** (optional: where the methods come from)

- Fisher, R. A. (1922). On the mathematical foundations of theoretical statistics. *Philosophical Transactions of the Royal Society of London. Series A, Containing Papers of a Mathematical or Physical Character* 222(594-604), 309–368. https://doi.org/10.1098/rsta.1922.0009
- Wilks, S. S. (1938). The Large-Sample Distribution of the Likelihood Ratio for Testing Composite Hypotheses. *The Annals of Mathematical Statistics* 9(1), 60–62. https://doi.org/10.1214/aoms/1177732360

---
[← All sessions](../README.md)
