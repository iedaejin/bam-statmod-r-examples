# Breiman (2001) — Statistical Modeling: The Two Cultures

**Session(s):** 2 (also useful for 6 and 20–24)  ·  **Source:** Breiman, L. (2001), "Statistical Modeling: The Two Cultures", *Statistical Science* 16(3), pp. 199–231 (paper pp. 199–215; comments by D. R. Cox, B. Efron, B. Hoadley and E. Parzen, and rejoinder, pp. 216–231). PDF: `breiman2001.pdf`.
**Reading time:** ~60 min for the paper, ~40 min for the discussion  ·  **Level:** core (Sections 1–5 and 12); optional (Sections 6–11 and the discussion)

## Why read it
This course is built almost entirely on *data models*: a probability model for $y$ given $x$, parameters estimated by likelihood, conclusions drawn from the fitted parameters. Breiman argues that statisticians rely on such models too much and check them too weakly. The paper explains why we also judge models by predictive accuracy: the hold-out check in Session 2, AIC/BIC in Session 6, cross-validation and GCV for smoothers in Sessions 20–24.

## The big idea
Nature turns inputs $x$ into responses $y$ inside a black box. We analyse data to **predict** future $y$ and to extract **information** about how $y$ depends on $x$. The *data modelling culture* fills the box with a stochastic model (linear or logistic regression, the Cox model) and validates it with goodness-of-fit tests and residuals. The *algorithmic modelling culture* treats the box as unknown, looks for a function $\hat f(x)$ that predicts well, and validates it by accuracy on new data. Breiman's claim: the second culture often predicts better **and** gives more reliable information about the mechanism, so statisticians should use both.

## Section by section

**1–2. Introduction and road map (pp. 199–200).** The black-box picture, the two goals and the two cultures (Breiman puts about 98% of statisticians in the first). Preview of the three lessons of Sections 8–10: *Rashomon*, *Occam*, *Bellman*.

**3. Projects in consulting (pp. 200–201).** Predicting next-day ozone in Los Angeles from hundreds of weather variables (large regressions with variable selection; it failed, with too many false alarms) and detecting chlorine from mass spectra (a decision tree built with chemical knowledge, high test-set accuracy). His lessons: solve the problem, live with the data first, judge models on test data, use the computer.

**4. Return to the university (p. 202).** Almost every journal article begins by assuming the data come from a given model.

**5. The use of data models (pp. 202–204).** The core of the argument. A fitted model's conclusions describe the *model's* mechanism, not nature's; if the model imitates nature badly, the conclusions may be wrong. Example: a salary study where a significant gender coefficient in a 25-variable regression was taken as proof of discrimination, with nothing checked beyond $R^2$ (5.1). Goodness-of-fit tests have little power unless the alternative is specified, residual plots cannot detect lack of fit beyond a few dimensions, and adjusting the model after looking at the data invalidates the tests (5.2). Different analysts can fit different models that all pass the checks yet tell different stories (5.3). The natural check is predictive accuracy on data not used for fitting, by cross-validation or a test set (5.4).

**6. The limitations of data models (pp. 204–205).** A parametric model chosen in advance for data from a complex system loses accuracy and information, and keeps statisticians away from new problems.

**7. Algorithmic modelling (p. 205).** Neural nets and decision trees created the machine-learning community, whose single criterion is predictive accuracy and whose theory studies algorithms under the sole assumption of i.i.d. data.

**8. Rashomon: the multiplicity of good models (p. 206).** Many quite different models reach almost the same error; in best-subset regression, many five-variable models have an RSS within 1% of the best, each naming different "important" variables. Small perturbations of the data jump between them. Aggregating models (bagging) helps.

**9. Occam: simplicity vs accuracy (pp. 206–208).** A single tree is very interpretable but a mediocre predictor; a random forest (many randomised trees voting) is much more accurate but unreadable. Go for accuracy first, then try to understand why.

**10. Bellman: the curse of dimensionality (pp. 208–209).** Instead of reducing the number of variables, add many functions of them, each carrying a little information (shape-recognition forests, support vector machines).

**11. Information from a black box (pp. 209–214).** The goal is accurate information, not interpretability. Random forests rank variables by how much the test error grows when a variable's values are permuted. On hepatitis data (155 patients, 19 covariates) logistic regression barely beats predicting "all survive" and points to the wrong variables; the forest finds that two highly correlated variables carry almost all the predictive power. Further examples: clusters in a liver data set, gene importance in a microarray.

**12. Final remarks (pp. 214–215).** Breiman is not against data models; the emphasis must be on the problem and the data.

**Discussion and rejoinder (pp. 216–231).** Cox defends data models: start from a scientific question; many predictions concern conditions unlike those in the data; formal models are close to essential for clear thinking. Efron sees prediction methods as biased estimation that still needs theory. Hoadley describes credit scoring as an algorithmic culture that kept interpretability; Parzen sees many cultures, not two. Breiman replies to each.

## Key results to know
1. Two goals: prediction ($\hat y$ for new $x$) and information (how $y$ depends on $x$).
2. Data model: $y=f(x;\beta)+\varepsilon$ with $f$ and the law of $\varepsilon$ assumed; conclusions are about $\hat\beta$. Algorithmic model: any $\hat f(x)$, judged by prediction error.
3. Generalisation error $\mathrm E\,L\{Y,\hat f(X)\}$ (squared error or misclassification) is estimated on a held-out test set or by cross-validation, never on the training data.
4. Permutation importance: the increase in test error after randomly permuting $x_m$.
5. Rashomon (many near-optimal models), Occam (accuracy vs simplicity), Bellman (more features can help).

## Connect to class
- Deck 02, "Breiman (2001): two cultures of statistical modelling" and "Explanation vs prediction". The New Haven hold-out check ("A predictive check on New Haven", `02-nhtemp-two-models.Rmd`) is Section 5.4 in action: the trend model fits the training years better but predicts the last ten years worse.
- Reading question 5 in `02-readings.md` sets Breiman's Section 5.2 against your residual plots, line-up and hold-out check.
- The course stays mostly in the data-modelling culture but borrows predictive checks: AIC/BIC and ridge/lasso (Session 6), cross-validation and GCV for smoothing (Sessions 20–24). Trees, forests and SVMs are not covered.

## Read carefully / safe to skim
- **Read carefully:** Sections 1, 5, 8, 9.4, 11.4 and 12.
- **Skim:** Section 3, 7.2, the SVM details (10.3), the microarray example (11.3).
- **Discussion:** read at least Cox's comment and Breiman's reply to it.

## Check yourself
1. What does each culture put inside the black box, and how does each validate a model?
2. Why does a non-significant goodness-of-fit test not show that a model is right? Give an example from the New Haven analysis.
3. Explain the Rashomon effect. Why does it make "which variables are important?" a hard question in subset selection?
4. How is permutation importance computed? Why does it cope better with two highly correlated predictors than comparing $|\hat\beta_j|/\mathrm{se}(\hat\beta_j)$?
5. Cox argues that many predictions concern conditions different from those that produced the data. Why does that favour a data model? Give one example where you would side with Cox and one where you would side with Breiman.
