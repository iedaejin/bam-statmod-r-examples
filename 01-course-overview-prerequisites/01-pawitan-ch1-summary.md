# Pawitan (2001), Ch. 1 — Introduction

**Session(s):** 1–2  ·  **Source:** Pawitan, *In All Likelihood*, OUP, Ch. 1, pp. 1–20  
**Reading time:** ~45 min  ·  **Level:** core (§1.1–1.3); §1.4–1.5 are background (history of the schools of inference)

## Why read it

This chapter explains what makes a problem *statistical* and why we need a probability model before we can say anything about data. It frames the course: every model we fit this term separates signal from variation, and every conclusion depends on the model we chose.

## The big idea

Statistics exists to handle variation and uncertainty. An observed relative risk says nothing about how sure we can be until we put a stochastic model around it. Uncertainty *given* a model can be quantified and shrinks with more data; uncertainty about the model itself cannot. Pawitan places Fisher's likelihood approach as a "third way" between Bayesian and frequentist inference — the route this course follows.

## Section by section

**Opening.** Three schools react differently to uncertainty: Bayesians model everything with probability, frequentists restrict probability to long-run frequencies, and the likelihood (Fisherian) school sits between them.

**§1.1 Prototype of statistical problems.** Two small examples. (i) Traffic deaths rise from one year to the next: is the change "real"? Arithmetic cannot answer this, and the two numbers alone cannot either. (ii) The Physicians' Health Study randomised about 22,000 doctors to aspirin or placebo. The aspirin group had fewer heart attacks, and the observed relative risk is 0.58. On its own that number carries no measure of precision: a study ten times larger with the same rates would give the same 0.58 but far stronger evidence. To judge whether 0.58 is "far" from 1 we model each group's count as binomial and ask about the true ratio $\theta=\theta_1/\theta_2$. This leads to the basic question of inference: how do we go from observed data to statements about an unknown parameter?

**§1.2 Statistical problems and their models.**

- *Stochastic element.* Random contingencies affect the data, so we need probability models. Working inside a model is precise mathematics; choosing the model is not, and conclusions are conditional on that choice.
- *Inductive process.* Statistical questions are more general than the observations. Unlike a deductive proof, an inductive argument must use all the data, gets stronger with more data, and can be overturned by one new fact (the BSE example).
- *Empirical vs mechanistic models.* Mechanistic models come from subject-matter laws (Newton, Mendel); empirical models only aim to describe the variability in the data (a Poisson model for traffic deaths). Most general statistical models — distributions, linear and nonlinear regression — are empirical. Example 1.1 (Bode's law of planetary distances) shows the risk: an empirical formula fitted the known planets well, even "predicted" Uranus, then failed for Neptune and Pluto; a polynomial fits better but explains nothing.

**§1.3 Statistical uncertainty: inevitable controversies.** The key distinction of the chapter:

- *stochastic uncertainty* — about a fixed parameter or a random outcome, conditional on the model; handled by sampling distributions, confidence levels and P-values; it shrinks with a bigger experiment;
- *inductive uncertainty* — about the model itself, variable definitions, representativeness and whether we asked the right question; it is hard or impossible to quantify and does not shrink with more data of the same kind.

In the traffic example, one bus crash or a change in seasonal patterns suggests splitting the data, but splitting increases stochastic uncertainty and raises the question of where to stop. Different analysts may reasonably reach different conclusions.

**§1.4 The emergence of statistics.** Two strands: probability theory (Bayes, Laplace) and the theory of errors (Gauss and least squares). Bayesians treat probability as degree of belief and combine a prior with the model; frequentists use only long-run frequencies, which give us bias, standard errors, P-values and confidence levels. Two concerns about priors: how to choose them, and the fact that "ignorance" on one scale becomes information on another. Example 1.3 (the two-envelope paradox) shows how careless reasoning about uncertainty misleads; Ch. 2 resolves it with the likelihood.

**§1.5 Fisher and the third way.** Fisher rejected both axiomatic priors and frequency as the only meaning of probability. His view: use exact probability statements when they exist, otherwise reason from the likelihood, a weaker but rational measure of support that gains probability backing in large samples. "Legacies" credits Fisher with naming the core concepts (parameter, statistic, sufficiency, information, efficiency) and records his criticism that least squares on its own has no inferential content and hides the link to generalized linear models.

## Key results to know

The chapter has almost no formulas. Keep these in mind:

1. A statistical model is a family of distributions $\{f(y;\theta):\theta\in\Theta\}$; inference goes from observed $y$ back to $\theta$.
2. Relative risk as a parameter: $\theta=\theta_1/\theta_2$, with each group's count binomial. The point estimate alone is not an answer.
3. Bayes' theorem, posterior $\propto$ prior $\times f(y\mid\theta)$. We do not use it in this course, but it explains what the likelihood approach refuses to do (put a distribution on $\theta$ without a physical reason).
4. Fisher's prototype of an exact interval: $\bar y\pm1.96\,\sigma/\sqrt n$ for a normal mean with known $\sigma$.

Notation: Pawitan writes data as $x$ (we use $y$) and uses $f(\cdot)$ generically for any density.

## Connect to class

- **Session 2 slides** use this chapter directly: "Deterministic vs stochastic models", the box "Mechanistic vs empirical (Pawitan, 2001, Sec. 1.2)", and "Models are approximations", which cites the stochastic/inductive split of §1.3.
- The slides' **"Variability vs uncertainty"** ($\sigma$ vs $\mathrm{se}(\hat\theta)$) lives entirely *inside* Pawitan's stochastic uncertainty. His inductive uncertainty matches the slides on model choice and on **data quality** (measurement error, missingness, selection bias).
- Breiman (2001), the other Session 2 reading, adds the prediction-oriented view to Pawitan's data-modelling view.
- **Session 1** is a prerequisite review; its "Preview of session 3" slide points ahead to Ch. 2.
- R: `02-intro-statistical-modelling/02-nhtemp-two-models.Rmd` and `02-simulate-from-model.Rmd` treat a model as a data-generating process.

## Read carefully / safe to skim

- **Read carefully:** §1.1 (aspirin example), §1.2 (stochastic element, inductive process, empirical vs mechanistic), §1.3 (two types of uncertainty). These ideas recur all term.
- **Skim:** the historical detail of §1.4–1.5 (names, dates, fiducial probability). Know only the three schools and where the likelihood sits between them.

## Check yourself

1. In the aspirin study, why is the observed relative risk 0.58 not an answer to "is aspirin beneficial?" What changes, and what does not, if the study were ten times larger?
2. For the New Haven temperature series (Session 2), give one source of stochastic uncertainty and one of inductive uncertainty. Which one would 60 more years of data reduce?
3. Classify as mechanistic or empirical, and justify: a Poisson model for annual traffic deaths; $d=\tfrac12 g t^2$ for free fall; a linear trend for New Haven temperatures.
4. Show that with a uniform prior on a binomial $\theta$ the posterior is proportional to the likelihood $\theta^y(1-\theta)^{n-y}$. Then explain in words why the same "ignorance" prior is not uniform for $\theta^2$.
5. In one sentence each, how would a frequentist and a Fisherian describe what a 95% interval $(1.3,\,7.1)$ tells us?
