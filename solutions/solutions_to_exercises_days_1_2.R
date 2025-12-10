############## Solution to exercise e1.5 ############## 
#1. Which of the following are valid R variable names?

#ask R to give us the solution....
#Type something like that in the console

min_height <- 3
max.height <- 0
_age <- 1
.mass <- 4
MaxLength <- 2
min-length <- 1
2widths <- 3
celsius2kelvin <- 2

############## ############## ############## ############## 

############### Solution to exercise e1.6 ###############
#1. Create a vector `fav_music` with the names of your favourite artists/bands.

#2. Create a vector `num_records` with the number of records you have in your collection of each of those artists.

#3. Create a vector `num_concerts` with the number of times you attended a concert of these artists.

#4. Put everything together in a data frame, assign the name `my_music` to this data frame and change the labels of the information stored in the columns to `artist`, `records` and `concerts`.

#5. Extract the variable `num_records` from the data frame `my_music`. 

#6. Calculate the total number of records in your collection (for the defined set of artists).

#7. Check the structure of the data frame, ask for a `summary`.

fav_music <- c("Judas Priest", "ACDC", "Black Sabbath", "Metallica",'Iron Maiden','Slayer')
num_concerts <- c(0,1,1,0,2,1)
num_records <- c(3,4,7,5,2,2)

my_music <- data.frame(fav_music, num_concerts, num_records)
names(my_music) <- c("artist", "concerts", "records")
colnames(my_music)
#alternative solution
my_music <- data.frame(artist=fav_music, 
                       concerts=num_concerts, 
                       records=num_records)

my_music$records
sum(my_music$records)

summary(my_music)

############## ############## ############## ############## 

############## Solution to exercise e2.2 ############## 

#1. Use the data set `car_price.csv` available in the documentation. Import the data in R.

#2. Explore the data.

#3. Make a scatterplot of price versus income, use basic plotting instructions and use `ggplot2`.

#4. Add a smooth line to each of the plots (using `lines` to add a line to an existing plot and `lowess` to do scatterplot smoothing and using `geom_smooth` in the `ggplot2` grammar).

#5. Color the previous ggplot based on sex

#   Transform sex to factor with levels (0,1)

#6. Show the plot per different sex in the dataset (use facet_wrap)
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

############## ############## ############## ############## 

############## #solution of e2.5 ############## 
#1. Use the data set `gapminder_data.csv` available in the documentation. Import the data in R.

#2. Explore the data. Show the top rows of the data set. How many observations does the data set contain?

#3. Compute how many records are per continent (either with count or with table functions)

#4. Calculate the life expectancy in each continent

#5. Convert column country to factor data type

#6. Select the data from countries in Asia 

#7. What are the possible levels for `country` in the subset you created from countries in Asia ?  

#8. Remove all countries which do not appear in the factor variable (use function droplevels)

#9. Now, from all countries countries (gapminder the origianl data frame) select the observations from 2007 

#10. Bin the life expectancy in four bins of roughly equal size (hint: learn and use functions `quantile` and cut)

#11. Visualise how many observations are in each bin (hint use ggplot with geom_bar) and color it based on the continent ((hint: in the aes first color and then fill, what do you see?)

path.gapminder <- file.path(path, "gapminder_data.csv")
path.gapminder
gapminder <- read.csv(path.gapminder)

str(gapminder)
colnames(gapminder)

head(gapminder)

dim(gapminder)

unique(gapminder$year)

table(gapminder$continent)

gapminder %>%
  count(continent, sort = TRUE)

gapminder %>%
  group_by(continent) %>%
  summarise(avg_lifeExp_per_continent=mean(life_exp))


gapminder$country <- factor(gapminder$country)

asia <-  filter(gapminder, continent == "Asia")

levels(asia$country)
table(asia$country)

asia$country <- droplevels(asia$country)
levels(asia$country)

data_2007 <- filter(gapminder, year == 2007) 

quantile(data_2007$life_exp, c(0.25, 0.5, 0.75))
my_intervals <- c(0,quantile(data_2007$life_exp, c(0.25, 0.5, 0.75)),Inf)
my_bins <- cut(data_2007$life_exp, my_intervals)

data_2007 <- data_2007 %>% 
  mutate(life_expectancy_binned = my_bins)

data_2007 %>%
  group_by(life_expectancy_binned) %>%
  summarise(frequency = n()) 

ggplot(data_2007,aes(life_expectancy_binned)) +
  geom_bar(aes(color=continent),width = 0.5)+
  theme_bw()+
  theme(legend.position = "bottom",aspect.ratio = 0.8)

ggplot(data_2007,aes(life_expectancy_binned)) +
  geom_bar(aes(fill=continent),width = 0.5)+
  theme_bw()+
  theme(legend.position = "bottom",aspect.ratio = 0.8)
############## ############## ############## ############## 

