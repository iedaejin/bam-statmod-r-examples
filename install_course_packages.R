# Install every R package used in Statistical Modelling (BAM, IE University).
# Run once:  source("install_course_packages.R")
# Works on your laptop, Posit Cloud and Codespaces. Re-running it only installs what is missing.

course <- c(
  # documents and labs
  "rmarkdown", "knitr", "learnr", "shiny",
  # data handling and plots
  "tidyverse",
  # models and data used in class, labs, examples and problem sets
  "MASS", "faraway", "car", "boot", "glmnet", "leaps", "pscl",
  "nlme", "lme4", "lmerTest", "pbkrtest",
  "mgcv", "gamm4", "gratia", "survival"
)
# Only needed to re-run the code of the class-notes book
notes_extra <- c("brglm2", "broom", "ggrepel", "gridExtra", "kableExtra", "pROC", "sandwich")

install_missing <- function(pkgs) {
  missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing)) {
    message("Installing: ", paste(missing, collapse = ", "))
    install.packages(missing, repos = "https://cloud.r-project.org")
  }
  still <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
  if (length(still)) warning("Could not install: ", paste(still, collapse = ", ")) else
    message("All ", length(pkgs), " packages are ready.")
}

install_missing(course)
# install_missing(notes_extra)   # uncomment to run the class-notes code as well
