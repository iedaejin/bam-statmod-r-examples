# Session 29 — Group-Project Workshop

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Choose** a model class from the response type and the data structure, and justify it.
2. **Compare** two fitted model classes with a valid criterion.
3. **Diagnose** the final model with checks suited to it.
4. **Critique** another group's draft with a structured checklist.
5. **Plan** the revisions and the 10-minute presentation.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`29-workflow-template.Rmd`](29-workflow-template.Rmd) · [`.R`](29-workflow-template.R) | A modelling workflow from question to communication | Worked example: GLM vs GAM; Diagnostics that work for a binary response; Communicating the result |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144  
  → Ch. 12 Insurance redlining: a complete example (pp. 183–196)

**Original papers** (optional: where the methods come from)

- Box, G. E. P. (1976). Science and Statistics. *Journal of the American Statistical Association* 71(356), 791–799. https://doi.org/10.1080/01621459.1976.10480949
- Wasserstein, R. L. and Lazar, N. A. (2016). The ASA statement on $p$-values: context, process, and purpose. *The American Statistician* 70(2), 129–133. https://doi.org/10.1080/00031305.2016.1154108

---
[← All sessions](../README.md)
