#################### DAY 1 part1 #################### 
#                                                   #  
#   Quick recap on basic programming concepts       #
#                                                   #
#####################################################

# 1.1 load an R package, then explore the R studio environment
#The `ggplot2` package is a very popular package for data visualisation.

#install.packages("ggplot2")
library(ggplot2)
help(diamonds)
View(diamonds)

# 1.2 little warm up with arithmetics

#be careful the order of the operators
10^2 + 36
3 + 5 * 2
(3 + 5) * 2
3 + 5 * 2 ^ 2  # hard to read
(3 + (5 * (2 ^ 2)))    # clear, if you remember the rules
2/10000 #Really small or large numbers get a scientific notation: `2 * 10^(-4)`.
5e3  # Note the lack of minus here 


# 1.3 mathematical functions
#we dont have to remember everything, we can always search online or use help pages
sum(10, 20, 30, 40, 50)
sin(1)  # trigonometry functions
log(1)  # natural logarithm loge()
log10(10) # base-10 logarithm

# 1.4 comparing things
1 == 1    #equality (note two equals signs, read as "is equal to")
1 != 4    #inequality (read as "is not equal to")
1 < 2     #less than
1 <= 1    #less than or equal to
1 > 0     #greater than
1 >= -9   #greater than or equal to

# 1.5 variables
#a fundamendal concept in programming in general
#In computing, a variable is a piece of memory that stores a value that can be changed. 
#A variable can refer to anything from numbers and strings to objects, collections, and pointers. 
#variables are essential in software programs—without them, most modern computing functions would be impossible.

x <- 100
x <- x + 1 
y <- x * 2
x <- sum

############## Little exercise e1.5 ############## 
# Which of the following are valid R variable names?

#min_height
#max.height
#_age
#.mass
#MaxLength
#min-length
#2widths
#celsius2kelvin

############## ############## ############## ############## 


#################### DAY 1 part1 #################### 
#                                                   #  
#                 Data types                        #
#                                                   #
#####################################################

# 1.6 
#Lets inspect different data types and work with variables
my_numeric <- 42.5
my_character <- "some text"
my_logical <- TRUE
my_date <- as.Date("05/29/2018", "%m/%d/%Y")
my_numeric_str <- '42.5'

my_numeric_str + 1
my_numeric + 1

#verify the data type of a variable with the `class()` function: e.g.
class(my_numeric)
class(my_date)
class(my_numeric_str)

#list all objects in the environment
ls()
ls(pat='max.')
ls(pat='my_')
ls(all.names = TRUE)

#remove objects from the environment
rm(my_numeric)                            # remove a single object
rm(my_character, my_logical)              # remove multiple objects
rm(list = c('my_date', 'my_numeric_str'))     # remove a list of objects
rm(list = ls()) 


# 1.6.1 Vectors
my_vector <- c(1, 2, 3, 4)
my_vector > 4
x <- 1:5
my_vector_2 <- c(0, x, 20, 0)                      
my_vector_2[2]       # inspect entry 2 from vector my_vector_2
my_vector_2[2:3]     # inspect entries 2 and 3
my_vector_2[c(1:3)]
length(my_vector_2)  # get vector length

my_games <- c("basketball", "ski", "billiard")
my_games

#There is something called *type coercion*, and it is the source of many surprises
#and the reason why we need to be aware of the basic data types and how R will
#interpret them. When R encounters a mix of types (here numeric and character) to
#be combined into a single vector, it will force them all to be the same type. 

coercion_vector <- c('a', TRUE)
coercion_vector
another_coercion_vector <- c(0, TRUE)
another_coercion_vector

#The coercion rules go: 
#`logical` -> `integer` -> `double`/`numeric` -> `complex` -> `character`, 
#where -> can be read as *are transformed into
character_vector_example <- c('1','2','4')
character_vector_example
character_vector_example + 1
character_coerced_to_numeric <- as.numeric(character_vector_example)
character_coerced_to_numeric
character_coerced_to_numeric <- character_coerced_to_numeric - 1
character_coerced_to_numeric
numeric_coerced_to_logical <- as.logical(character_coerced_to_numeric)
numeric_coerced_to_logical

# In conclusion: some surprising things can happen when R forces one basic data type into another....
#Be careful and always inspect your data from one part of the analysis to another

# 1.6.2 Matrices
my_matrix <- matrix(1:12, nrow=3,ncol=4, byrow = TRUE)
my_matrix
my_matrix[2, 4]

class(my_matrix)
typeof(my_matrix)
my_matrix[2, 4] <- 4.33
typeof(my_matrix)
str(my_matrix)

dim(my_matrix)
ncol(my_matrix)
nrow(my_matrix)

#note on Missing Values

my_matrix[2,3] <- NA

#In real data analysis, it is often the case that we are missing some data in a
#data set. For example, say we want to add tail length to our dataset, but one of
#our cats wouldn't hold still long enough to be measured... we know it has a
#tail (so we can't record it as `0`), but we don't know what it is. We also
#can't record it using a word or code (character; such as `"missing"`) because
#vectors in R all have to be the same type, and weight is numeric. A common
#practice is to use a placeholder value such as `9999`, but that can cause
#problems if we neglect to deal with it properly, so it's not recommended. R has
#a special placeholder for missing values called `NA` - it looks a lot like a
#character value, but it is not - it is a special value that has the same type as
#the vector in which it is found.


# 1.6.3 Data frames and tibbles
#Inspect a built-in data frame

help(mtcars)
mtcars
head(mtcars)
str(mtcars)
dim(mtcars)
colnames(mtcars)
rownames(mtcars)
View(mtcars)

#the operator $
mtcars$cyl
mtcars[,2]
mtcars[,'cyl']

typeof(mtcars$cyl)
summary(mtcars$cyl)   # use $ to extract another variable from a data frame
mtcars$mpg
summary(mtcars$mpg)

#Inspect a built-in tibble
help(diamonds)
diamonds
str(diamonds)  # built-in in library ggplot2
head(diamonds)
dim(diamonds)
colnames(diamonds)
rownames(diamonds)
View(diamonds)

# 1.6.4 Lists
#you can store practically any piece of information in it!

my_list <- list(A = 1, 
                B = c(1:20), 
                C = seq(1, 4, length=5),
                D = c("Dimi", "Gon",'Eirik','Nina'))

names(my_list)
str(my_list)

#explore different ways to access the lists
my_list$A
my_list$D

my_list[[2]]

my_list[3]
my_list[[3]]

#what about this ?
my_list$E <- mtcars
str(my_list)

# 1.6.5 Factors
#Another important data structure is called a *factor*. Factors usually look like
#character data, but are typically used to represent categorical information that
#have a defined set of values. In modeling functions, it's important to know what the baseline levels are. This
#is assumed to be the first factor, but by default factors are labeled in
#alphabetical order.

mydata <- c("patient","patient","patient" ,"control", "control", "patient")
mydata
factor_ordering_example <- factor(mydata, levels = c("patient", "control"))
factor_ordering_example
str(factor_ordering_example)

#for now we will leave it here and showcase more examples with factors along the way

############## Little exercise e1.6 ############## 

#1. Create a vector `fav_music` with the names of your favourite artists/bands.

#2. Create a vector `num_records` with the number of records you have in your collection of each of those artists.

#3. Create a vector `num_concerts` with the number of times you attended a concert of these artists.

#4. Put everything together in a data frame, assign the name `my_music` to this data frame and change the labels of the information stored in the columns to `artist`, `records` and `concerts`.

#5. Extract the variable `num_records` from the data frame `my_music`. 

#6. Calculate the total number of records in your collection (for the defined set of artists).

#7. Check the structure of the data frame, ask for a `summary`.

############## ############## ############## ############## 


#################### DAY 1 part1 #################### 
#                                                   #  
#              Import/Export data                   #
#                                                   #
#####################################################


# Important note on path names
getwd()
setwd('/Users/kleftogi/Desktop/Journal_clubs_and_Students/R_programming_prep/My_R_repo/')

#use a full path
path <- file.path("/Users/kleftogi/Desktop/Journal_clubs_and_Students/R_programming_prep/My_R_repo/")
#use a relative path
path <- file.path('./Days_1_2/')


# 1.7 import a txt file

path <- file.path("/Users/kleftogi/Desktop/Journal_clubs_and_Students/R_programming_prep/My_R_repo/data")
path.hotdogs <- file.path(path, "hotdogs.txt")
path.hotdogs

hotdogs <- read.table(path.hotdogs, header = FALSE, 
                      col.names = c("type", "calories", "sodium"))

str(hotdogs)    # inspect data imported
dim(hotdogs)
View(hotdogs)
head(hotdogs)
#find the unique values in the type column
unique(hotdogs$type)

# 1.8 import a csv file
path.pools <- file.path(path, "swimming_pools.csv")
path.pools
pools <- read.csv(path.pools)
str(pools)    # inspect data imported
dim(pools)
View(pools)
head(pools)
unique(pools$Address)

#lets try now this version of the data importation function
pools <- read.csv(path.pools, stringsAsFactors = TRUE)
str(pools)

# 1.9 import an excel file
library(readxl) 
path.urbanpop <- file.path(path, "urbanpop.xlsx") 
path.urbanpop
excel_sheets(path.urbanpop) # list sheet names with `excel_sheets()`

#if the sheet argument is not specified, by default the first sheet will be loaded

pop_1 <- read_excel(path.urbanpop, sheet = 1) 
pop_2 <- read_excel(path.urbanpop, sheet = 2) 
pop_3 <- read_excel(path.urbanpop, sheet = 3) 

str(pop_1) 
str(pop_2)
str(pop_3) 

pop_list <- list(pop_1, pop_2) 
names(pop_list)
names(pop_list) <- c('1960-1966',"1967-1974")
names(pop_list)

# There are many different packages that allow us to import different data types
# for example we can import SPSS or Strata files, or even platform-specific data types
# for example there are packages to load images, cytometry data, or gene expression data


# 1.10 export a xlsx file
# we will need the following package
#install.packages("xlsx")
library(xlsx)
write.xlsx(pop_1, 'data/my_first_export.xlsx', sheetName = "page1", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

