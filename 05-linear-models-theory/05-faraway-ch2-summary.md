# Faraway (2014), Ch. 2 — Estimation

**Session(s):** 5 (also useful for 1, 7 and 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 2, pp. 13–31  
**Reading time:** ~60 min  ·  **Level:** core

## Why read it

This is the book's version of the first half of Session 5: how $\beta$ is estimated, why least squares is a sensible choice, and what goes wrong when the columns of $X$ are dependent. It also shows how `lm()` actually computes $\hat\beta$ (QR) and gives the cleanest statement of the Gauss–Markov theorem in our reading list.

## The big idea

A linear model is linear in the **parameters**, not necessarily in the predictors, so it is far more flexible than "straight line" suggests. Writing the model as $y=X\beta+\varepsilon$ turns estimation into a geometry problem: the fitted vector $\hat y$ is the orthogonal projection of $y$ onto the column space of $X$. The data split into $p$ dimensions of systematic structure and $n-p$ dimensions of residual noise. Least squares is justified three ways (geometry, maximum likelihood under normality, Gauss–Markov), but it needs $X$ of full rank.

## Section by section

**2.1 Linear Model (p. 13).** A general $Y=f(X_1,X_2,X_3)+\varepsilon$ is too vague to estimate, so we restrict $f$ to a linear combination of known functions of the predictors; terms such as $\log X_2$ or $X_1X_2$ are allowed. Models come from physical theory, from past experience, or from data exploration; usually they are approximations, useful in the way a map is useful.

**2.2 Matrix Representation (p. 14).** $y=X\beta+\varepsilon$ with a column of ones for the intercept; the null model $y=\mu+\varepsilon$ is the simplest case. $\mathrm E\,\varepsilon=0$ can be assumed without loss, since any nonzero mean is absorbed into the intercept.

**2.3 Estimating β (p. 15).** Geometric view (Figure 2.1): $\hat y=X\hat\beta$ is the point of the model space closest to $y$; the residual vector lives in the orthogonal complement. Note Faraway's warning that authors disagree on whether $p$ counts parameters or predictors; from here on he uses parameters (as we do).

**2.4 Least Squares Estimation (p. 16).** Minimise $(y-X\beta)^\top(y-X\beta)$, obtain the normal equations, the solution, the hat matrix $H$, fitted values, residuals and $\mathrm{RSS}=y^\top(I-H)y$. States (proof later) that $\hat\beta$ is unbiased with variance $(X^\top X)^{-1}\sigma^2$ and that $\hat\sigma^2=\mathrm{RSS}/(n-p)$ is unbiased. Practical advice: never form the $n\times n$ matrix $H$ for large data.

**2.5 Examples of Calculating β̂ (p. 17).** Closed forms for the mean model ($\hat\beta=\bar y$) and for simple regression, written with a centred predictor so that $X^\top X$ is diagonal. Beyond these cases we need a computer.

**2.6 Example (p. 17).** Galápagos species counts (`gala`, 30 islands, five geographic predictors). Faraway fits the model with `lm()`, introduces his compact `sumary()` output, then recomputes $\hat\beta$, $\hat\sigma$ and the standard errors "by hand" from `model.matrix()`. He stresses that `solve(t(x) %*% x)` is a poor way to compute $\hat\beta$ (slow and inaccurate under collinearity); `solve(crossprod(x, x), crossprod(x, y))` is better, `lm()` best.

**2.7 QR Decomposition (p. 20).** Optional in the book, useful for us. With $X=QR$ ($Q$ orthogonal, $R$ upper triangular), rotating by $Q^\top$ does not change lengths, so the RSS splits into a part that can be made zero by solving a triangular system and a part that cannot. Demonstrated with `qr()`, `qr.Q()`, `qr.R()` and `backsolve()`.

**2.8 Gauss–Markov Theorem (p. 22).** Three reasons for least squares: geometry, maximum likelihood under iid normal errors, and the theorem. Defines **estimable** functions $c^\top\beta$ and proves, with a short variance decomposition, that $c^\top\hat\beta$ has minimum variance among linear unbiased estimators, and is unique, when $\mathrm E\,\varepsilon=0$, $\mathrm{var}\,\varepsilon=\sigma^2I$ and the mean structure is correct. When to prefer something else: correlated or unequal-variance errors (GLS, Ch. 8), long tails (robust regression), collinearity (ridge, Ch. 11).

**2.9 Goodness of Fit (p. 23).** $R^2$ and its equivalent forms; what a "good" $R^2$ is depends on the field. Simulated panels with the same $R^2\approx0.65$ (Figure 2.3) show that $R^2$ says nothing about outliers or curvature. Without an intercept, R's reported $R^2$ is misleading. $\hat\sigma$, in response units, is a complementary measure.

**2.10 Identifiability (p. 26).** If $X$ is not of full rank, the normal equations have infinitely many solutions. Examples: the same quantity in two units, total = sum of parts, $p>n$, and the over-parametrised two-group model $\mu+\alpha_i$ (fixed by a constraint). R drops aliased columns and reports `NA`. A near-dependence (a perturbed copy of a variable) is worse in practice: everything is estimated but with huge standard errors (picked up again in Section 7.3).

**2.11 Orthogonality (p. 28).** If $X=[X_1\,|\,X_2]$ with $X_1^\top X_2=0$, each block's estimate does not depend on whether the other block is in the model. Centring predictors makes zero covariance equivalent to orthogonality. Orthogonality comes from design: the `odor` experiment (a central composite design) shows unchanged coefficients when one predictor is dropped; only $\hat\sigma$ and the standard errors move slightly.

## Key results to know

1. Normal equations $X^\top X\hat\beta=X^\top y$; if $\operatorname{rank}(X)=p$, $\hat\beta=(X^\top X)^{-1}X^\top y$.
2. $H=X(X^\top X)^{-1}X^\top$, $\hat y=Hy$, residuals $e=(I-H)y$, $\mathrm{RSS}=y^\top(I-H)y$. Faraway writes $\hat\varepsilon$ for the residuals; the deck writes $e$.
3. $\mathrm E[\hat\beta]=\beta$, $\mathrm{Var}(\hat\beta)=\sigma^2(X^\top X)^{-1}$; $\hat\sigma^2=\mathrm{RSS}/(n-p)$; $\mathrm{se}(\hat\beta_j)=\hat\sigma\sqrt{[(X^\top X)^{-1}]_{jj}}$.
4. QR: $X=QR\Rightarrow$ solve $R\hat\beta=Q_f^\top y$ by back-substitution ($Q_f$ = first $p$ columns of $Q$).
5. Gauss–Markov: under $\mathrm E\,\varepsilon=0$ and $\mathrm{Var}\,\varepsilon=\sigma^2I$ (no normality), $c^\top\hat\beta$ is BLUE for any estimable $c^\top\beta$.
6. $R^2=1-\mathrm{RSS}/\mathrm{TSS}=\mathrm{cor}^2(\hat y,y)$ (with an intercept).
7. Orthogonal blocks: $\hat\beta_1=(X_1^\top X_1)^{-1}X_1^\top y$ regardless of $X_2$.

## Connect to class

- **Session 5 deck**, sections *Matrix formulation*, *Least squares*, *Sampling properties* and *Computation*, cover 2.2–2.8 on the `savings` data instead of `gala`. The deck's assumption table (A1–A4) makes explicit what Faraway states in passing: A1 (full rank) is Section 2.10; A2–A3 are the Gauss–Markov conditions.
- The deck proves $\mathrm E[\mathrm{RSS}]=\sigma^2(n-p)$, which Faraway only states. Session 8, Problem 7 asks you to prove it.
- `05-least-squares.Rmd` reproduces Faraway's "by hand" and QR computations.
- Section 2.10 (aliased columns, `NA` in `lm()`) reappears with factors in Ch. 14 and Session 6.

## Read carefully / safe to skim

- **Read carefully:** 2.3–2.4, 2.8 (statement and the conditions; follow the proof once), 2.9, 2.10.
- **Worth knowing for computation:** 2.7. You will not be asked to compute a QR by hand, but you should know why `lm()` uses it.
- **Safe to skim:** the R object-extraction details in 2.6 and the history remarks in 2.5.

## Check yourself

1. Show that $H$ is symmetric and idempotent and that $X^\top e=0$. What does $X^\top e=0$ mean geometrically?
2. Which of the three justifications of least squares need normal errors, and which do not?
3. A model contains years of school, years of university and total years of education. What does `lm()` report and why? Is $\hat y$ still unique?
4. Explain in words why $R^2$ near 0.65 can describe a good model, a model with a wrong functional form, or a fit driven by two outliers.
5. Why are the coefficients in the `odor` example unchanged when `temp` is dropped, while their standard errors change slightly?
