#################### DAY 2 part4 #################### 
#                                                   #  
#                  Data wrangling                   #
#                                                   #
#####################################################

# 2.5 Data manipulation verbs

# but first lets us introduce the concept of pipe `%>%`
head(diamonds)
table(diamonds$cut)

diamonds$price %>% mean()
diamonds$price %>% sqrt()


#- `mutate()` adds new variables that are functions of existing variables

#- `select()` picks variables based on their names

#- `filter()` picks cases based on their values

#- `summarise()` reduces multiple values down to a single summary

#- `arrange()` changes the ordering of the rows.


# 2.5.1 filter
filter(diamonds, cut == "Ideal") 
ideal_diamonds <- diamonds %>% filter(cut == "Ideal")

# 2.5.2 mutate
mutate(diamonds, price_per_carat = price/carat)
diamonds_updated <- mutate(diamonds, price_per_carat = price/carat)

expensive_diamonds <- diamonds %>% mutate(price_per_carat = price/carat) %>% 
  filter(price_per_carat > 1500) 



# 2.5.3 summarise
diamonds %>% summarise(mean = mean(price), 
                       std_dev = sd(price))

# 2.5.4 group_by()
diamonds %>% 
  group_by(cut) %>% 
  summarize(price = mean(price), carat = mean(carat))
  
#remember that pipes can be combined like that:
#I woke up %>% 
#  showered %>% 
#  dressed %>% 
#  had coffee %>% 
#  came to an R course

diamonds %>% 
  group_by(cut) %>% 
  summarize(price = mean(price), carat = mean(carat)) %>%
  ggplot(aes(x=price,y=carat,label=cut))+
  geom_point(size=2)+
  geom_text(position = position_jitter())+
  theme_bw()


# 2.5.5 Using select()

diamonds_filt <- select(diamonds, carat, cut, clarity,depth)
colnames(diamonds_filt)

# 2.5.6 using count
diamonds %>%
  filter(cut=='Good') %>%
  count(color,sort=TRUE)

# as an alternative syntax without dplyr
good_diamonds <- diamonds[diamonds$cut=='Good',]
table(good_diamonds$color)

# 2.5.6 creating new variables after summarising info

diamonds %>% 
  mutate(price_per_carat = price/carat) %>%
  group_by(cut,color) %>%
  summarize(mean_carat = mean(carat),
          sd_carat = sd(carat),
          mean_price_per_carat = mean(price_per_carat),
          sd_price_per_carat = sd(price_per_carat),
          mean_depth = mean(depth),
          sd_depth = sd(depth))


#combine this with a scatter plot
diamonds %>% 
  mutate(price_per_carat = price/carat) %>%
  group_by(cut,color) %>%
  summarize(mean_carat = mean(carat),
            se_carat = sd(carat)/length(carat),
            mean_price_per_carat = mean(price_per_carat),
            se_price_per_carat = sd(price_per_carat)/length(price_per_carat),
            mean_depth = mean(depth),
            se_depth = sd(depth)/length(depth)) %>%
  
  ggplot(aes(x=mean_price_per_carat,y=mean_depth,color=cut)) +
  geom_point(size=1)+
  theme_bw()+
  theme(legend.position = "bottom")

#add the error bars
diamonds %>% 
  mutate(price_per_carat = price/carat) %>%
  group_by(cut,color) %>%
  summarize(mean_carat = mean(carat),
            se_carat = sd(carat)/length(carat),
            mean_price_per_carat = mean(price_per_carat),
            se_price_per_carat = sd(price_per_carat)/length(price_per_carat),
            mean_depth = mean(depth),
            se_depth = sd(depth)/length(depth)) %>%
  ggplot(aes(x=mean_price_per_carat,y=mean_depth,color=cut)) +
  geom_point(size=1.2)+
  ylab('mean depth')+
  xlab('mean price per carat ± std error')+
  geom_errorbar(aes(xmin=mean_price_per_carat-se_price_per_carat, 
                    xmax=mean_price_per_carat+se_price_per_carat), width=.15,
                position=position_dodge(0.05))+
  theme_bw()+
  theme(legend.position = "bottom")

############## exercise e2.5 ############## 

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


############## ############## ############## ############## 
#solution of e2.5

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







