# Statistical Modelling — follow the course in R

Statistical Modelling, Bachelor in Applied Mathematics (BAM), IE University, Spring 2027.
Prof. Dae-Jin Lee, daelee@faculty.ie.edu, IE University — School of Science and Technology.

This repository follows the slides session by session. Each folder has a **session guide** (`README.md`, shown below the file list when you open the folder) with the learning objectives, the readings, the R scripts in the order we use them in class, and exercises to practise afterwards. The slides themselves are on Blackboard.

## Set up once

1. Install R (≥ 4.3) and RStudio, or use [Posit Cloud](https://posit.cloud/) in the browser.
2. Download this repository: green **Code** button → **Download ZIP** (or `git clone` it and `git pull` before each class, since new sessions are added during the term).
3. Install the packages used in the course (run once, with the repository folder as working directory):

   ```r
   source("install_course_packages.R")
   ```

## Follow a session

1. **Before class** — open the session folder and read `readings.md`.
2. **In class** — open the session's `.Rproj` (RStudio then works inside that folder) and run the scripts in the order of the session guide. A slide that says *Follow: r-examples/NN-name.Rmd* tells you which script to run at that point.
3. **After class** — knit the `.Rmd` files to keep a report of what we did, and try `exercises.md`.
4. **Labs** — the graded computer labs are in [bam-statmod-labs](https://github.com/iedaejin/bam-statmod-labs). Each lab ends with a learnr tutorial whose `.txt` you upload to Blackboard.

If you missed a class, the session guide, the slides on Blackboard and the scripts let you catch up on your own; come to office hours (on request, daelee@faculty.ie.edu) with specific questions.

## Class notes and problem sets

- **Class notes** — [StatMod-class-notes.pdf](class-notes/StatMod-class-notes.pdf): the course as a book (20 chapters + appendices), with every derivation, worked R examples on real data and solved exercises. Each session guide says which chapter to read.
- **Problem sets** — one per block, combining theory, R and interpretation. Solutions are released on Blackboard after the deadline.

| Problem set | Block |
|---|---|
| [PS1-likelihood](problem-sets/PS1-likelihood.pdf) | Sessions 1–4 |
| [PS2-linear-models](problem-sets/PS2-linear-models.pdf) | Sessions 5–8 |
| [PS3-glm](problem-sets/PS3-glm.pdf) | Sessions 9–12 |
| [PS4-mixed-models](problem-sets/PS4-mixed-models.pdf) | Sessions 15–19 |
| [PS5-smoothing](problem-sets/PS5-smoothing.pdf) | Sessions 20–22 |
| [PS6-gams](problem-sets/PS6-gams.pdf) | Sessions 23–27 |
| [PS7-survival](problem-sets/PS7-survival.pdf) | Session 28 |

## Sessions

| # | Session | Material here | Lab |
|---|---|---|---|
| 1 | [Course Introduction and Prerequisite Review](01-course-overview-prerequisites/) | 4 R examples | [Lab 00](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_00_Reproducible_R) |
| 2 | [Introduction to Statistical Modelling](02-intro-statistical-modelling/) | 4 R examples | [Lab 00](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_00_Reproducible_R) |
| 3 | [Maximum Likelihood Estimation](03-maximum-likelihood/) | 3 R examples | [Lab 01](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_01_Maximum_Likelihood) |
| 4 | [Lab 01 — MLE in R](04-lab-maximum-likelihood/) | 2 R examples | [Lab 01](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_01_Maximum_Likelihood) |
| 5 | [Linear Models in Theory](05-linear-models-theory/) | 3 R examples | [Lab 02](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) |
| 6 | [Linear Models in Practice and Model Selection](06-linear-models-practice-model-selection/) | 4 R examples | [Lab 02](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) |
| 7 | [Computer Lab — Linear Models and Diagnostics in R](07-lab-linear-models-diagnostics/) | 2 R examples | [Lab 02](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) |
| 8 | [Linear-Model Exercises](08-exercises-linear-models/) | scripts after class |  |
| 9 | [Introduction to Generalized Linear Models](09-glm-intro/) | 4 R examples | [Lab 03](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) |
| 10 | [Fitting Generalized Linear Models](10-glm-fitting/) | 4 R examples | [Lab 03](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) |
| 11 | [Computer Lab — GLMs in R](11-lab-glm/) | 2 R examples | [Lab 03](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) |
| 12 | [GLM Exercises](12-exercises-glm/) | scripts after class |  |
| 13 | [Midterm Review](13-review-midterm/) | scripts after class |  |
| 14 | [Midterm Exam](14-midterm-exam/) | exam |  |
| 15 | [Linear Mixed Models](15-linear-mixed-models/) | 2 R examples | [Lab 04](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) |
| 16 | [Estimation and Inference for LMMs](16-lmm-estimation-inference/) | 3 R examples | [Lab 04](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) |
| 17 | [Generalized Linear Mixed Models](17-glmm/) | 3 R examples | [Lab 04](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) |
| 18 | [Computer Lab — Mixed Models in R](18-lab-mixed-models/) | 1 R example | [Lab 04](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) |
| 19 | [Mixed-Model Exercises](19-exercises-mixed-models/) | scripts after class |  |
| 20 | [Polynomial Regression and Scatterplot Smoothing](20-polynomial-scatterplot-smoothing/) | 3 R examples | [Lab 05](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) |
| 21 | [Splines](21-splines/) | 3 R examples | [Lab 05](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) |
| 22 | [Computer Lab — Smoothing and Splines](22-lab-smoothing-splines/) | 2 R examples | [Lab 05](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) |
| 23 | [Introduction to Generalized Additive Models](23-gams-intro/) | 3 R examples | [Lab 06](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) |
| 24 | [GAM Theory](24-gams-theory/) | 2 R examples | [Lab 06](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) |
| 25 | [Advanced GAMs](25-gams-advanced/) | 3 R examples | [Lab 06](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) |
| 26 | [Computer Lab — GAMs with `mgcv`](26-lab-gams/) | 2 R examples | [Lab 06](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) |
| 27 | [Generalized Additive Mixed Models](27-gamms/) | 3 R examples | [Lab 07](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_07_GAMMs) |
| 28 | [Censored and Survival Data](28-survival/) | 4 R examples | [Lab 08](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_08_Survival) |
| 29 | [Group-Project Workshop](29-group-project-workshop/) | 1 R example |  |
| 30 | [Group-Project Presentations](30-group-project-presentations/) | — |  |
| 31 | [Final Exam Review](31-review-final/) | scripts after class |  |
| 32 | [Final Exam](32-final-exam/) | exam |  |

Scripts for the exercise sessions are added after each session.

## Generative AI

You may use GenAI tools for ideation, proofreading and help with code, with an acknowledgement (see the syllabus). Lab submissions, assignments, group work and exams must be your own work.

## Data

Datasets come from R packages (`datasets`, `MASS`, `faraway`, `lme4`, `nlme`, `survival`) under their own licences; copyright in the data remains with their authors.
