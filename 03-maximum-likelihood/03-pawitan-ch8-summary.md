# Pawitan (2001), Ch. 8 — Score function and Fisher information

**Session(s):** 3 (also useful for 4 and for Fisher scoring in 10)  ·  **Source:** Pawitan, *In All Likelihood*, OUP, Ch. 8, pp. 213–229  
**Reading time:** ~50 min  ·  **Level:** core (§8.6 optional)

## Why read it

Ch. 2 treated the score and curvature as properties of *one* observed likelihood; here they are random quantities that vary between samples. The chapter proves the two identities behind our large-sample results (the score has mean zero and variance equal to the expected information) and gives the Cramér–Rao bound, the benchmark for calling the MLE "efficient".

## The big idea

At the true parameter, the score $S(\theta)$ fluctuates around zero, and the size of its fluctuations equals the expected (Fisher) information $\mathcal I(\theta)$. Information is additive over independent observations, changes in a known way under reparametrization, and sets a floor on the variance of any unbiased estimator. Observed and expected information usually differ; Pawitan argues that the observed one, $I(\hat\theta)$, is "closer to the data".

## Section by section

**Opening.** $S(\theta)=\partial\log L(\theta)/\partial\theta$ is the *score function* when seen as a function of $\theta$, and the *score statistic* when seen as a random variable at a fixed $\theta$.

**§8.1 Sampling variation of score function.** Simulated score functions for four models: exactly linear for the normal mean, nearly linear for the Poisson, very irregular for the Cauchy. All cross zero near the true value. A nearly linear score means a nearly quadratic log-likelihood.

**§8.2 The mean of $S(\theta)$.** Theorem 8.1: $\mathbb E_\theta S(\theta)=0$. The proof differentiates $\int f(y;\theta)\,dy=1$ under the integral sign. The subscript matters: the expectation is under the same $\theta$ at which the score is evaluated. Regularity conditions are needed (for example, $\theta$ not on the boundary, and a model smooth in $\theta$); exponential families and the Cauchy satisfy them.

**§8.3 The variance of $S(\theta)$.** The observed information $I(\theta)=-\partial^2\ell/\partial\theta^2$ varies with the data; the expected information is $\mathcal I(\theta)=\mathbb E_\theta I(\theta)$, a function of $\theta$ that says how hard $\theta$ is to estimate. $I$ is best read as a single number at $\hat\theta$. Theorem 8.2: $\mathrm{var}_\theta S(\theta)=\mathcal I(\theta)$. Worked cases:

- normal mean: $I=\mathcal I=n/\sigma^2$, which holds for any exponential family in its canonical parameter;
- Poisson: $I(\theta)=\sum_i y_i/\theta^2\ne\mathcal I(\theta)=n/\theta$, but the two agree at $\hat\theta=\bar y$, which holds in any full exponential family;
- Cauchy: $\mathcal I=n/2$, but $I(\hat\theta)$ varies widely between samples. Which is more relevant is a real question; Pawitan returns to it in §9.6;
- censored exponential survival times: the observed information depends on the number of events actually seen, while the expected one depends on the censoring time chosen by the design. Survival analysis therefore uses the observed information.

**§8.4 Properties of expected Fisher information.** Additivity: independent data add information, so $\mathcal I=n\,\mathcal I_1$ for iid data. Location parameters have constant information; for scale parameters information is proportional to $1/\sigma^2$, so small scales are easier to estimate. Reparametrization: if $\psi=g(\theta)$, then $\mathcal I^*(\psi)=\mathcal I(\theta)/\{g'(\theta)\}^2$. For one Poisson observation, $\log\theta$ has information $\theta$ (easier to estimate when the mean is large), and $\sqrt\theta$ has constant information, so it behaves like a location parameter.

**§8.5 Cramér–Rao lower bound.** Theorem 8.3: if $\mathbb E_\theta T=g(\theta)$, then $\mathrm{var}(T)\ge\{g'(\theta)\}^2/\mathcal I(\theta)$, and $1/\mathcal I(\theta)$ for unbiased estimators of $\theta$. Poisson examples: $\bar y$ attains the bound for $\theta$; for $e^{-\theta}=P(Y=0)$ the MLE attains it only approximately and the best unbiased estimator not at all; for $\theta^2$ the best unbiased estimator exceeds it. The proof applies the covariance inequality to $T$ and $S(\theta)$. Equality requires $T$ linear in the score, which forces an exponential family, so the bound is attainable for at most one function of $\theta$ and never in models such as the Cauchy.

**§8.6 Minimum variance unbiased estimation\*.** Completeness and the Rao–Blackwell construction; outside the book's likelihood approach.

**§8.7 Multiparameter CRLB.** For a vector parameter, $\mathbb E S=0$ and $\mathrm{var}\,S=\mathcal I(\theta)$, now a non-negative definite matrix. The bound for $a^\top\theta$ is $a^\top\mathcal I(\theta)^{-1}a$. For $\theta_1$ with the other parameters unknown the bound is $[\mathcal I^{-1}]_{11}$, which is never smaller than the bound $1/\mathcal I_{11}$ that applies when the others are known: **estimating extra parameters has a cost**. The cost vanishes (asymptotically) when the off-diagonal information is zero, as for $(\mu,\sigma^2)$ in the normal model. More parameters may reduce bias but cost variance.

## Key results to know

1. $\mathbb E_\theta S(\theta)=0$.
2. $\mathrm{var}_\theta S(\theta)=\mathbb E_\theta\{S(\theta)^2\}=\mathbb E_\theta\{-\ell''(\theta)\}=\mathcal I(\theta)$.
3. iid data: $\mathcal I(\theta)=n\,\mathcal I_1(\theta)$.
4. Canonical exponential family: $I(\theta)=\mathcal I(\theta)$ for all $\theta$; full exponential family: $I(\hat\theta)=\mathcal I(\hat\theta)$.
5. Reparametrization $\psi=g(\theta)$: $\mathcal I^*(\psi)=\mathcal I(\theta)\,(d\theta/d\psi)^2$, the information form of the delta method.
6. CRLB: $\mathrm{var}(T)\ge\{g'(\theta)\}^2/\mathcal I(\theta)$; multiparameter $\mathrm{var}(T)\ge a^\top\mathcal I^{-1}a$, and $[\mathcal I^{-1}]_{11}\ge1/\mathcal I_{11}$.

Notation: Pawitan's notation matches the course: $I(\theta)$ is observed and a calligraphic $\mathcal I(\theta)$ is expected. For the per-observation information he writes $\mathcal I_{x_1}(\theta)$ (we write $\mathcal I_1$). He uses $x$ for data and $\log L$ for $\ell$.

## Connect to class

- **Session 3 slides:** "Score and information: definitions" and "Two identities for the score" are Theorems 8.1–8.2 with the same proof. "Observed vs expected information: binomial" and the figure of $I$ and $\mathcal I$ as functions of $\theta$ illustrate §8.3 (equal at $\hat\theta$, different elsewhere). The table "Information in the other models" includes the exponential rate, where $I=\mathcal I$ because the rate is the canonical parameter. "Properties of the MLE (and what not to claim)" relies on the CRLB; its warning that "no unbiased estimator has smaller variance than the MLE" is false as stated is exactly the point of the $e^{-\theta}$ and $\theta^2$ examples.
- **Newton–Raphson vs Fisher scoring** (Session 3) is the $I$ vs $\mathcal I$ distinction. In the gamma `aircondit` example $I(\alpha)$ does not depend on the data, so the two coincide. In Session 10 (IRLS for GLMs) the canonical link makes them equal again.
- **Lab 01:** the delta method after optimising on $\log\lambda$ is Key result 5. The Poisson example in §8.4 explains why the log scale is the natural one for counts.
- The censored-data example is a first look at Session 28 (survival).

## Read carefully / safe to skim

- **Read carefully:** §8.2–8.4 (the identities, observed vs expected, additivity, reparametrization) and the statement and consequences of the CRLB in §8.5 and §8.7.
- **Skim:** the CRLB proof, the $\theta^2$ example and the Cauchy integrals. **Optional:** §8.6 (MVUE, completeness), which is not examined.

## Check yourself

1. For $y_1,\dots,y_n$ iid Bernoulli($\theta$), compute $S(\theta)$, verify directly that $\mathbb E S(\theta)=0$ and $\mathrm{var}\,S(\theta)=\mathcal I(\theta)=n/\{\theta(1-\theta)\}$, and show that $I(\theta)\ne\mathcal I(\theta)$ except at particular values.
2. For iid exponential data with mean $\mu$, use Key result 5 to get the information for the rate $\lambda=1/\mu$ from the information for $\mu$. Check against the slides' table.
3. In the Cauchy model the observed information at $\hat\theta$ can be far from $\mathcal I=n/2$. Explain in words why the observed value may be the more relevant measure of precision for *this* data set.
4. Does the CRLB imply that the MLE is the best estimator? State precisely what it does and does not say.
5. Why does not knowing $\sigma^2$ cost nothing (asymptotically) when estimating $\mu$ in the normal model, while not knowing the rate does cost something when estimating the gamma shape?
