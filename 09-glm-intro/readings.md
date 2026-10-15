# Session 9 — Readings

**Topic:** Introduction to generalized linear models
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models: An Introduction with R*, 2nd ed. | Ch. 3.1: the exponential-family section and the section on canonical links; skim the fitting section (Session 10) | The three components of a GLM, the exponential family, $\mathrm{E}[Y]=b'(\theta)$, $\mathrm{Var}(Y)=b''(\theta)\phi$, canonical links |
| Pawitan (2001), *In All Likelihood* | Ch. 4: the exponential-family section; Ch. 6: logistic regression, Poisson regression and exponential-family regression models | Score identities; logistic regression and odds ratios; Poisson regression with an offset |

Check section numbers against the library copy; editions differ in numbering.

## Optional

- McCullagh and Nelder (1989), *Generalized Linear Models*, 2nd ed., Ch. 2 (exponential family, links) and Sec. 6.3.2 (the ship-damage data used today).
- Faraway (2016), *Extending the Linear Model with R*, 2nd ed., Ch. 2 (binary response) and Ch. 5 (count regression).
- Hosmer, Lemeshow and Sturdivant (2013), *Applied Logistic Regression*, 3rd ed., Ch. 1 and 3 (interpretation of odds ratios; the birthwt study comes from this book's first edition).

## What to focus on

1. Why a GLM transforms the **mean** and not the response.
2. How the two score identities give the mean and variance of every exponential-family distribution.
3. The difference between a link $g$ and its inverse $g^{-1}$, and why the inverse link keeps $\mu$ in range.
4. Odds ratios vs risk ratios; rate ratios with an offset.
5. Why a threshold must be chosen without looking at the test set.

## Reading questions

1. Put the gamma density with mean $\mu$ and shape $\nu$ in exponential-family form and check that $b'(\theta)=\mu$.
2. What is the canonical link of the Poisson and of the binomial? What does "canonical" buy you?
3. In a Poisson rate model, what is the coefficient of $\log t_i$, and why is it not estimated?
4. A logistic coefficient is 0.7. What is the odds ratio? Is the risk ratio larger or smaller?

## Next

**Session 10 — Fitting GLMs:** IRLS as Fisher scoring, likelihood inference, deviance, residuals and overdispersion.
