## NEUROSYSM930: Practical programming session in R 

### 8-10 December 2025, Grupperom 9A109bP

In this page we provide course material (e.g.,sample codes, datasets etc) and other useful information about the practical programming session in R.

### Disclaimer

Most of the course material have been adopted from similar courses available online and other notes that the instructors have collected from previous years. 

### Schedule

### Pre-day

#### 3th December 2025, Time 10:00-13:00

We provide a special "pre-day" session for those facing issues or need help to install R and the required packages for the course.

Location: Neuro-SysMed seminar room, U etasje, Gamle Hovudbygg building

A "first in first out" method will be followed =)

### Days 1 and 2

#### 8th and 9th December 2025,13:00-15:45, Basic and bit more advanced R

In the first two days we will go through fundamental concepts in R and you will be able to understand the principles of R as an environment for data manipulation, exploration and visualization. We have created little hands-on exercises that will help you to master the R syntax, understand different data types, explore the structure of the data as well as to realise the capabilities of some of the most important R packages. We will work with data importation and exportation and we will be able to create various visualisations using ggplot package. Then we will showcase the full potential of tidyverse package and we will learn different methods for manipulating and summarising data sets. The course is designed for new R users, and it is not expected from you to know all of the above-mentioned concepts. But you are adviced to follow the “RTutorial_beforecourse.pdf”, this will benefit you a lot during the course.

In summary the topics we will cover the first two days are as follows:

Part 1 - (a) Quick recap on basic programming concepts; (b) Data types ; (c) Data import/export

Part 2 - (a) Basic exploratory data analysis; (b) A bit more general programming concepts (time permitting)

Part 3 - (a) Visualisations using ggplot package

Part 4 - (a) Data wrangling using tidyverse package

### Day 3

#### 10th December 2025 13:00-15:45, Analysis of RNA-seq data using R

Part 1 - Fetching, understanding, and processing RNAseq data

Part 2 - Estimating cell types and running differential expression analyses


### Software Requirements

Please install a recent version of R and RStudio.

https://posit.co/download/rstudio-desktop/


Run the following script in your R session to install the required packages


```r
packages <- c("tidyverse","readxl","xlsx")
new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

all_packages <- c("ggplot2", "dplyr", "tidyr", "readr", "tibble", "readxl","xlsx")

if(sum(!(all_packages %in% installed.packages()[, "Package"]))) {
  stop("Not all required packages are installed!")
} else {
  message("Everything is set up correctly. You are ready for the workshop!")
}
```

### Course material

The course material is provide in the folders `Days_1_2` and `Day_3`. These folders also provide the scripts used throughout the workshop. Data sets are stored in the `data` folder. 

The full stack of lecture slides, as well as access to the final exam is provided via our UiB Mitt page

https://mitt.uib.no/courses/47992 


### Books and other useful material

https://rc2e.com/

https://katrienantonio.github.io/intro-R-book/objects-data-types.html#basic-data-types


Blog Devoted to Ecology research, but offers nice examples and videos https://www.rforecology.com/post/

### Contact

Comments and bug reports are welcome, please email: Dimitrios Kleftogiannis (dimitrios.kleftogiannis@uib.no) OR Gonzalo Sanchez Nido (Gonzalo.Nido@uib.no) OR Synne Geithus (synne.geithus@uib.no)

We are also interested to know about how you have used our material, including any improvements that you have implemented.
 
You are free to modify, extend or distribute our codes, as long as our copyright notice remains unchanged and included in its entirety. 


### License

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/). 

```

Copyright © 2024 NeuroSys-Med, University of Bergen (UiB).

This work is licensed under the Creative Commons Attribution 4.0 International License.

You may only use the source codes and the datasets in this repository in compliance with the license provided in this repository. For more details, please refer to the file named "LICENSE".

Original Work Copyright © Software Carpentry, content modified by the Province of British Columbia and Workshop in R by katrienantonio.

Our credits and acknowledgments to the developers of the R workshops from https://github.com/katrienantonio/workshop-R and https://github.com/bcgov/ds-intro-to-r-2-day/tree/master

```




