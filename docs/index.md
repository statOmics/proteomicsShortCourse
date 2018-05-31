---
layout: default
title: Statistical data analysis for proteomics
---

## Proteomics Shortcourse

Short course on statistical data analysis for proteomics with R shiny apps

## Getting started

- Launch an R studio interface in an R docker along with bioconductor packages for proteomics.

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/statOmics/proteomicsShortCourse/master?urlpath=rstudio)

- Alternatively, you can launch R studio via the jupyter binder environment:

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/statOmics/proteomicsShortCourse/master)

Once inside Jupyter Notebook, RStudio Server should be an option under the menu
"New":

![](./pages/figs/rstudio-session.jpg)

- Or you can install your own local docker by downloading the entire repository and invoking
```
docker build <path to proteomicsShortCourse directory> -t msqrob_docker
```

## Target Audience
This course is oriented towards biologists and bioinformaticians with at least an intermediate level of experience working with omics data. The course will be of particular interest to researchers investigating differential analysis for quantitative proteomics.

## Detailed Program

### 0. Installation of the Docker environment [Install and Launch Docker](pages/installLaunchDocker.md)

### 1. Identification
#### [Slides on FDR and the target decoy approach](assets/1_Identification_Evaluation_Target_Decoy_Approach.pdf)

#### Practical 1: [Evaluating target decoy quality](pages/Identification.md)

### 2. Statistical data analysis of label free quantitative proteomics experiments with simple designs

#### [Slides on Preprocessing](assets/2_MSqRob_data_analysisI.pdf)
#### [Slides on Statistical Inference](assets/2_MSqRob_data_analysisII.pdf)

#### Practical 2: [Statistical data analysis with MSqRob for simple designs](pages/sdaMsqrobSimple.md)
#### Robust regression explained by example: [robust regression](pages/robustRegression.nb.html)

### 3. Statistical analysis of label free quantitative proteomics experiments with complex designs
