# Session 2 — Readings

**Topic:** Introduction to statistical modelling
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Section and page numbers refer to Pawitan (2001), *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, Oxford University Press. Check them against the library copy.

## Required

| Source | Sections | Pages | Focus |
|--------|----------|-------|-------|
| Pawitan (2001) | 1.1 Prototype of statistical problems | 1–3 | Why the aspirin relative risk 0.58 needs a stochastic model before we can say whether it is "far" from 1 |
| Pawitan (2001) | 1.2 Statistical problems and their models | 3–6 | Stochastic element; inductive process; **empirical vs mechanistic models**; Bode's law (Example 1.1) |
| Pawitan (2001) | 1.3 Statistical uncertainty: inevitable controversies | 6–8 | **Stochastic vs inductive uncertainty**; why more data reduce one but not the other |
| Breiman (2001), "Statistical Modeling: The Two Cultures", *Statistical Science* 16(3), 199–231 | Sections 1–5 and 12 | 199–204, 214–215 | The black box; data modelling vs algorithmic modelling; how each culture validates a model |

The PDF of Breiman (2001) is in `breiman2001.pdf`.

## Optional

| Source | Sections | Focus |
|--------|----------|-------|
| Pawitan (2001) | 1.4–1.5 | History: the emergence of statistics and Fisher's likelihood approach (sets up Session 3) |
| Breiman (2001) | Sections 6–11 (pp. 204–214) | Rashomon (many equally good models), Occam (simplicity vs accuracy), Bellman (dimensionality) |
| Breiman (2001) | Comments by the discussants and the rejoinder (pp. 216–231) | A useful counterweight: the case for data models |
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 1 | Looking at the data before modelling; a first `lm()` |

## Reading questions

1. In Pawitan's aspirin example, why is the observed relative risk of 0.58, by itself, not an answer to "is aspirin beneficial?"
2. Give one example of a mechanistic model and one of an empirical model. Which kind is the linear trend for New Haven temperatures?
3. Pawitan distinguishes stochastic from inductive uncertainty. Which one is reduced by collecting more data of the same kind? Give an example of the other for the New Haven series.
4. Breiman describes two cultures. Which goals (prediction, information) does each one serve best, and how does each validate a model?
5. Breiman argues (Section 5) that goodness-of-fit tests and residual analysis have little power to reject a model, especially with more than a few variables, and recommends estimates of predictive accuracy instead. With one covariate (New Haven), what did the residual plots, the line-up and the hold-out check each tell you?

## Reading summaries

Study guides to the chapters above. They send you to the book; they do not replace it.

- [Pawitan Ch. 1 — Introduction](../01-course-overview-prerequisites/01-pawitan-ch1-summary.md)
- [Breiman (2001) — Statistical Modeling: The Two Cultures](02-breiman-2001-summary.md)

## Before Session 3

- Work through `02-nhtemp-two-models.Rmd` and `02-simulate-from-model.Rmd`.
- Complete Lab 00 and upload the `.txt` from `tutorial.Rmd` to Blackboard.
- Read Pawitan (2001) Ch. 2 (Elements of likelihood inference) for Session 3, maximum likelihood.
