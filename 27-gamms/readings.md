# Session 27 — Readings

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Source | Sections | Focus |
|---|---|---|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | 5.8 | Smooths, random fields and random effects: why a penalty is a Gaussian prior and a random effect is a smooth |
| Wood (2017) | 6.6 | Smoothness selection by REML/ML through the mixed-model representation |
| Wood (2017) | 7.7 | Worked GAMM examples with `gamm()` and `gamm4()`; correlated errors |
| Session 16 slides | — | REML, BLUP, variance components |

## Optional

| Source | Focus |
|---|---|
| Ruppert, Wand & Carroll (2003), *Semiparametric Regression*, Ch. 4 | Penalized splines as mixed models |
| Eilers & Marx (2021), *Practical Smoothing*, chapter on mixed models | P-splines in mixed-model form |
| Pinheiro & Bates (2000), *Mixed-Effects Models in S and S-PLUS*, Ch. 5 | Correlation structures (`corAR1`, `corCAR1`) in `nlme` |
| `?gamm`, `?gamm4`, `?smooth.construct.re.smooth.spec`, `?factor.smooth` | What the software does |

## What to focus on

1. The derivation of $\lambda=\sigma^2/\sigma_b^2$ from the joint density.
2. The reparametrisation $X=[\mathbf 1,x]$, $Z=BU_+\Sigma_+^{-1/2}$ and why $BU_0$ spans $[\mathbf 1,x]$.
3. `s(g, bs = "re")` and `bs = "fs"`; independence of `re` terms in `gam()`.
4. The `$gam` and `$lme` components of `gamm()`; `$gam` and `$mer` of `gamm4()`.
5. When to add a residual correlation structure, and why it can compete with random effects.

## R

Knit the three files in ``; complete Lab 07.

## Reading summaries

- [Wood Ch. 6–7, GAMM sections — Generalized additive mixed models](27-wood-gamm-summary.md)
