# Session 29 — A modelling workflow from question to communication
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu) --- Statistical Modelling (BAM), IE University
# Plain-script version of 29-workflow-template.Rmd. Run: Rscript 29-workflow-template.R

## ----data---------------------------------------------------------------------
library(tidyverse)
library(mgcv)
bw <- MASS::birthwt |>
  mutate(low = as.integer(low),
         smoke = factor(smoke, levels = 0:1, labels = c("no", "yes")),
         race = factor(race, levels = 1:3, labels = c("white", "black", "other")),
         ht = factor(ht, levels = 0:1, labels = c("no", "yes")))
nrow(bw); sum(bw$low)                 # 189 births, 59 low birth weight
bw |> group_by(smoke) |> summarise(n = n(), p_low = mean(low))
summary(bw$lwt)                       # mother's weight in pounds


## ----models-------------------------------------------------------------------
m_glm <- glm(low ~ smoke + lwt + age + race + ht, family = binomial, data = bw)
m_gam <- gam(low ~ smoke + s(lwt) + s(age) + race + ht, family = binomial, data = bw,
             method = "REML")
summary(m_gam)$s.table               # edf close to 1 means "linear is enough"
AIC(m_glm, m_gam)


## ----binned, fig.width = 7, fig.height = 4------------------------------------
binned_resid <- function(fit, nbins = 10) {
  tibble(p = fitted(fit), r = bw$low - fitted(fit)) |>
    mutate(bin = cut_number(p, nbins)) |>
    group_by(bin) |>
    summarise(p_mean = mean(p), r_mean = mean(r),
              se = sqrt(mean(p) * (1 - mean(p)) / n()), .groups = "drop")
}
br <- binned_resid(m_glm)
ggplot(br, aes(p_mean, r_mean)) +
  geom_ribbon(aes(ymin = -2 * se, ymax = 2 * se), fill = "grey85") +
  geom_point(size = 2.5) + geom_hline(yintercept = 0, linetype = 2) +
  labs(x = "Mean fitted probability in bin", y = "Mean residual in bin")
mean(abs(br$r_mean) <= 2 * br$se)    # share of bins inside the band


## ----influence----------------------------------------------------------------
sort(cooks.distance(m_glm), decreasing = TRUE)[1:3]


## ----or-----------------------------------------------------------------------
est <- coef(summary(m_glm))["smokeyes", ]
or  <- exp(est["Estimate"] + c(0, -1.96, 1.96) * est["Std. Error"])
round(setNames(or, c("OR", "lower", "upper")), 2)
exp(confint(m_glm)["smokeyes", ])    # profile-likelihood interval


## ----figure, fig.width = 7, fig.height = 4------------------------------------
nd <- expand_grid(lwt = seq(90, 250, by = 5), smoke = c("no", "yes"),
                  age = 23, race = "white", ht = "no")
pr <- predict(m_glm, newdata = nd, type = "link", se.fit = TRUE)
nd <- nd |> mutate(fit = plogis(pr$fit), lo = plogis(pr$fit - 1.96 * pr$se.fit),
                   hi = plogis(pr$fit + 1.96 * pr$se.fit))
ggplot(nd, aes(lwt, fit, colour = smoke, fill = smoke)) +
  geom_ribbon(aes(ymin = lo, ymax = hi), alpha = 0.2, colour = NA) +
  geom_line(linewidth = 1) +
  labs(x = "Mother's weight (lb)", y = "P(low birth weight)", colour = "Smoker", fill = "Smoker",
       caption = "White mothers aged 23 without hypertension; 95% pointwise intervals")

