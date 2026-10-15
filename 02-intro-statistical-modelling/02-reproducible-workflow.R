# 02-reproducible-workflow.R
# Session 02 --- Introduction to statistical modelling
# A reproducible analysis: project folder, relative paths, a seed, and a
# record of the software used. Run this script from the r-examples/ folder
# (or open the RStudio project that contains it). Never call setwd().
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)

# ---- 1. Read the data with a relative path ----
# data/nhtemp.csv was written once from the package with
#   write.csv(data.frame(year = as.numeric(time(nhtemp)),
#                        temp = as.numeric(nhtemp)),
#             "data/nhtemp.csv", row.names = FALSE)
nh <- read.csv("data/nhtemp.csv")
str(nh)
stopifnot(nrow(nh) == 60, all(names(nh) == c("year", "temp")))

# ---- 2. Check that the file is the package dataset ----
data(nhtemp)
all.equal(nh$temp, as.numeric(nhtemp))          # TRUE
all.equal(nh$year, as.numeric(time(nhtemp)))    # TRUE

# ---- 3. Random numbers: same seed, same numbers ----
set.seed(2027); a <- rnorm(3)
set.seed(2027); b <- rnorm(3)
identical(a, b)                                 # TRUE
d <- rnorm(3)                                   # no reset: different numbers
identical(a, d)                                 # FALSE
RNGkind()                                       # the generator is part of the record

# ---- 4. One analysis, end to end ----
fit <- lm(temp ~ year, data = nh)
round(coef(fit), 4)
set.seed(2027)
sim <- simulate(fit, nsim = 20)                 # 20 series from the fitted model
dim(sim)                                        # 60 x 20
round(summary(apply(sim, 2, function(y) coef(lm(y ~ nh$year))[2])), 4)

# ---- 5. Record the software ----
sessionInfo()
