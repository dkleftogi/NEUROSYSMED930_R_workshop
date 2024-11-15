#################### DAY 2 part3 #################### 
#                                                   #  
#                  Visualisations                   #
#                                                   #
#####################################################

# 2.1 first we will show some basic visualisation functions

path.journals <- file.path(path, "journals.txt")
path.journals   # inspect path name
Journals <- read.table(path.journals, header = TRUE)

head(Journals)
colnames(Journals)
rownames(Journals)
dim(Journals)

plot(log(Journals$subs), log(Journals$citations), data = Journals)
rug(log(Journals$subs))
rug(log(Journals$citations), side = 2)

#make some adjustments
plot(log(price) ~ log(subs), data = Journals, pch = 19, 
     col = "blue", xlim = c(0, 8), ylim = c(-7, 7), 
     main = "Library subscriptions")
rug(log(Journals$subs))
rug(log(Journals$price), side=2)

#The `curve()` function draws a curve corresponding to a function over the interval [from, to].
help(dnorm)
curve(dnorm, from = -5, to = 5, col = "red", lwd = 3, 
      main = "Density of the standard normal distribution")


# 2.2 Plots with ggplot2

#lets make an empty plot
library(ggplot2)
head(mpg)
ggplot(data = mpg)
ggplot(mpg)


# 2.2.1 introduce the aes
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(Journals) +
  geom_point(aes(x = log(subs), y = log(citations)))


# lets add some color
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, 
                 color = class))

ggplot(Journals) +
  geom_point(aes(x = log(subs), y = log(citations),color=society))


# now lets pay attention to the details of the command...
ggplot(mpg) + geom_point(aes(x = displ, y = hwy, color = class))
ggplot(mpg) + geom_point(aes(x = displ, y = hwy, color = "blue"))
ggplot(mpg) + geom_point(aes(x = displ, y = hwy),color = "blue")

#lets play a bit more 
ggplot(mpg) + geom_point(aes(x = class, y = hwy))
ggplot(mpg) + geom_point(aes(x = class, y = hwy,size=cty))

# 2.2.2  make a boxplot
ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy))

# and play with it
ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,color=class))

ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,color=class,fill=class))

ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,fill=class))

ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,fill=class),
               width=0.28,
               outlier.colour = "red",
               outlier.shape = 1,
               outlier.fill = "red",
               outlier.size = 0.2,notch = TRUE)


ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,fill=class),
               width=0.28,
               outlier.colour = "red",
               outlier.shape = 1,
               outlier.fill = "red",
               outlier.size = 0.2,notch = TRUE)+
   theme_classic() 

ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,fill=class),
               width=0.28,
               outlier.colour = "red",
               outlier.shape = 1,
               outlier.fill = "red",
               outlier.size = 0.2,notch = TRUE)+
  theme_classic() +
  ylab('highway miles per gallon')+
  theme(axis.text.y = element_text( size = 10 ),
      axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 10),
      axis.title.x = element_blank(),
      axis.title.y = element_text( size = 10, face='bold' ),
      legend.position = "none",
      aspect.ratio = 0.8)

output_file <- file.path(path, "my_first_nice_boxplot.pdf")
ggsave(output_file)


#lets save it in a pdf file
myFigure <- ggplot(mpg) +
  geom_boxplot(aes(x = class, y = hwy,fill=class),
               width=0.28,
               outlier.colour = "red",
               outlier.shape = 1,
               outlier.fill = "red",
               outlier.size = 0.2,notch = TRUE)+
  theme_classic() +
  ylab('highway miles per gallon')+
  theme(axis.text.y = element_text( size = 10 ),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 14),
        axis.title.x = element_blank(),
        axis.title.y = element_text( size = 10, face='bold' ),
        legend.position = "none",
        aspect.ratio = 0.8)

class(myFigure)

output_file <- file.path(path, "my_first_nice_boxplot2.pdf")
pdf(output_file)
plot(myFigure)
dev.off()


# 2.2.3 lets make a nice histogram

ggplot(mpg) +
  geom_histogram(aes(x = hwy))+
  theme_minimal() 
  
ggplot(mpg) +
  geom_density(aes(x = hwy),color='red')+
  theme_minimal() 

ggplot(mpg,aes(x = hwy)) +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") + 
  geom_density(lwd = 1, colour = 'red',
               fill = 'lightblue', alpha = 0.25) +
  theme_minimal()

# 2.2.4 lets work with scatter plots and add a regression line with confidence interval

#The default model fitted by geom_smooth depends on the amount of data being plotted. 
#In this case it has told us that it is using a “loess” model to fit the line - this is a simple form of a moving average smoother

ggplot(mpg,aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()+
  theme_minimal()

#showing that simple coloring provides already good understanding of patterns in the data  
ggplot(mpg,aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth()+
  theme_minimal()+
  theme(legend.position = "bottom")

#introducing the facet_wrap function that is very helpful
ggplot(mpg,aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth()+
  facet_wrap(~drv,nrow=3)+
  theme_bw()+
  theme(legend.position = "none",aspect.ratio = 1)


############## Little exercise e2.2 ############## 

#1. Use the data set `car_price.csv` available in the documentation. Import the data in R.

#2. Explore the data.

#3. Make a scatterplot of price versus income, use basic plotting instructions and use `ggplot2`.

#4. Add a smooth line to each of the plots (using `lines` to add a line to an existing plot and `lowess` to do scatterplot smoothing and using `geom_smooth` in the `ggplot2` grammar).

#5. Color the previous ggplot based on sex

#   Transform sex to factor with levels (0,1)

#6. Show the plot per different sex in the dataset (use facet_wrap)
############## ############## ############## ############## 

#solution of e2.2

path.cars <- file.path(path, "car_price.csv")
path.cars
cars <- read.csv(path.cars)

str(cars)    # inspect data imported
dim(cars)
head(cars)
colnames(cars)

unique(cars$college)
unique(cars$married)
unique(cars$sex)

summary(cars$income)
summary(cars$price)

# traditional plot
plot(price ~  income, data = cars)
lines(lowess(cars$income, cars$price), col = "blue")

# ggplot with smooth
ggplot(cars, aes(x = income, y = price)) +
  geom_point(size=2,color='black', alpha = 0.5) + 
  geom_smooth() + 
  theme_bw()

# previous plot with color based on sex
ggplot(cars, aes(x = income, y = price,color=sex)) +
  geom_point(size=2, alpha = 0.5) + 
  geom_smooth() + 
  theme_bw()


cars$sex <- factor(cars$sex,levels=c(0,1))
ggplot(cars, aes(x = income, y = price,color=sex)) +
  geom_point(size=2, alpha = 0.5) + 
  geom_smooth() + 
  theme_bw()

# ggplot with facet
ggplot(cars, aes(x = income, y = price,color=sex)) +
  geom_point(size=2, alpha = 0.5) + 
  geom_smooth() + 
  facet_wrap(~sex)+
  theme_bw()+
  theme(legend.position = "none",aspect.ratio = 1)


#################### DAY 2 part3 #################### 
#                                                   #  
#          Other programming concepts               #
#                                                   #
#####################################################

# 2.4



