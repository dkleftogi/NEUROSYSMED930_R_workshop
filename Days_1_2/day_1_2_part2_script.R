#################### DAY 1 part2 #################### 
#                                                   #  
#        Basic exploratory data analysis            #
#                                                   #
#####################################################

# 1.11 mini data exploration using basic functions

path.data <- file.path(path, "CPS1985.txt")
CPS1985 <- read.table(path.data, header = TRUE)

head(CPS1985)
colnames(CPS1985)
dim(CPS1985)

#first explore a numerical variable
str(CPS1985)
is.numeric(CPS1985$wage)      # check if variable is numeric
summary(CPS1985$wage)         # get a summary
quantile(CPS1985$wage)        #similarly get the distribution quantiles
mean(CPS1985$wage)            # get mean
mean(CPS1985$wage,na.rm = T)            # get mean and skip NA
median(CPS1985$wage)
var(CPS1985$wage)             # get variance
sd(CPS1985$wage) #standard deviation
se <- sd(CPS1985$wage)/length(CPS1985$wage) #standard error
#visualize the `wage` distribution with simple R functions
hist(log(CPS1985$wage), freq = FALSE, nclass = 20, col = "light blue")
lines(density(log(CPS1985$wage)), col = "red")


#now explore a character variable - example of factor
summary(CPS1985$occupation)
table(CPS1985$occupation)
CPS1985$occupation <- factor(CPS1985$occupation,
                             levels = c("management","office","sales","services","technical","worker" ))

levels(CPS1985$occupation)
levels(CPS1985$occupation)[c(1,5)] <- c("mgmt","techn")
summary(CPS1985$occupation)
table(CPS1985$occupation)

#visualise the distribution
tab <- table(CPS1985$occupation)
#tab <- tab/nrow(CPS1985)
prop.table(tab)    #Express Table Entries as Fraction of Marginal Table
barplot(tab)
barplot(prop.table(tab))
pie(tab)
pie(tab, col = gray(seq(0.4, 1.0, length = 6)))

#now we explore the factor variables `gender` and `occupation`.
table(CPS1985$gender)
CPS1985$gender <- factor(CPS1985$gender,
                             levels = c("female",'male'))

attach(CPS1985)                 # attach the data set to avoid use of $ 
table(gender, occupation)       # no name_df$name_var necessary
prop.table(table(gender, occupation))
prop.table(table(gender, occupation), 2) #what is the difference ?
plot(gender ~ occupation, data = CPS1985)
detach(CPS1985)                 # now detach when work is done


#lets explore a factor and a numeric variable
attach(CPS1985)
help(tapply)
tapply(wage, gender, mean)

tapply(wage, gender, median)
boxplot(log(wage) ~ gender, data = CPS1985)


tapply((wage), list(gender, occupation), mean)
tapply((wage), list(gender, occupation), median)




