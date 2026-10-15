# Session 1 — Setup
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Plain-script version of 01-setup.Rmd (same code). Run from r-examples/:  Rscript 01-setup.R

# Run this once at the start of the course. It installs every package used in the R examples and labs. On Posit Cloud or GitHub Codespaces the course project already has most of them; run the check at the end anyway.

# ---- Packages by block ----
# Session numbers follow the 32-session calendar of Spring 2027.
course_packages <- c(
  "rmarkdown", "knitr",      # knit the examples (all sessions)
  "learnr",                  # lab tutorials: download the .txt for Blackboard
  "tidyverse",               # data handling and ggplot2
  "MASS",                    # mvrnorm (session 1), glm.nb (session 10)
  "faraway",                 # datasets for linear models (sessions 5-8)
  "car",                     # VIF and diagnostics (sessions 6-7)
  "glmnet",                  # ridge, lasso, elastic net (sessions 6-7)
  "lme4", "nlme",            # mixed models (sessions 15-19)
  "mgcv", "gamm4",           # splines, GAMs, GAMMs (sessions 20-27)
  "survival"                 # Kaplan-Meier, Cox (session 28)
)

# ---- Install what is missing ----
# This chunk is not run when the file is knitted. Run it by hand once.
# Not run by default: remove the leading '# ' to run these lines.
# missing <- setdiff(course_packages, rownames(installed.packages()))
# if (length(missing) > 0) install.packages(missing)

# ---- Check ----
# Every package should print a version number. `NA` means it is not installed.
sapply(course_packages, function(p)
  if (requireNamespace(p, quietly = TRUE)) as.character(packageVersion(p)) else NA)
R.version.string

# ---- Reproducibility ----
# Fix the random seed before any simulation, so that you and your partner get the same numbers.
set.seed(2027)
round(rnorm(3), 4)
set.seed(2027)
round(rnorm(3), 4)   # identical to the line above
