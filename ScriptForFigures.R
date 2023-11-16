#Loads in library packages and the data/excel sheets from web scraping 
library(readxl)
library(ggplot2)
library(dplyr)

NewYork <- read_excel("C:/Users/wokkj/Downloads/Senior Research Web Scraping.xlsx", sheet = "New York")
Massachusetts <- read_excel("C:/Users/wokkj/Downloads/Senior Research Web Scraping.xlsx", sheet = "Massachusetts")
Connecticut <- read_excel("C:/Users/wokkj/Downloads/Senior Research Web Scraping.xlsx", sheet = "Connecticut")

#Remote or not relative frequency bar graph
remote <- (NewYork$is_remote > 0) #Remote contains true or false values for whether the job is remote or not
remote <- factor(remote, levels = c(TRUE, FALSE), labels = c("Remote", "Not Remote")) #Makes remote say remote or not remote instead of just true or false values
d.remote <- data.frame(remote) #Creates a data frame from remote
d.remote <- na.omit(d.remote) #Removes NA values within d.remote
ggplot(d.remote, aes(x = remote, y = ..count.. / sum(..count..), fill = remote)) + geom_bar() + 
  ggtitle("Is the job remote in New York") + labs(x = "Remote?", y = "Relative Frequency") + 
  theme(legend.position="none") + scale_fill_manual(values = c('#3993dd', '#e71d36')) #Creates a relative frequency bar graph


remote <- (Massachusetts$is_remote > 0)
remote <- factor(remote, levels = c(TRUE, FALSE), labels = c("Remote", "Not Remote"))
d.remote <- data.frame(remote)
ggplot(d.remote, aes(x = remote, y = ..count.. / sum(..count..), fill = remote)) + geom_bar() + 
  ggtitle("Is the job remote in Massachusetts") + labs(x = "Remote?", y = "Relative Frequency") + 
  theme(legend.position="none") + scale_fill_manual(values = c('#3993dd', '#e71d36'))


remote <- (Connecticut$is_remote > 0)
remote <- factor(remote, levels = c(TRUE, FALSE), labels = c("Remote", "Not Remote"))
d.remote <- data.frame(remote)
ggplot(d.remote, aes(x = remote, y = ..count.. / sum(..count..), fill = remote)) + geom_bar() + 
  ggtitle("Is the job remote in Connecticut") + labs(x = "Remote?", y = "Relative Frequency") + 
  theme(legend.position="none") + scale_fill_manual(values = c('#3993dd', '#e71d36'))



#Salary vs Location Scatterplot (One quanatative and one categorical so side by side boxplots)
df <- data.frame(NewYork$location, NewYork$min_amount) #Creates a data frame of New York job locations and job minimum salary

t <- table(df$NewYork.location) #Creates a table of New York job locations
d <- data.frame(t) #Creates a data frame from the table t
# n <- names(d)
d2 <- d %>% filter(d$Freq >= 20) #Creates d2 which is d but filters out any locations that don't have at least 20 job postings
d2 #Displays d2

df <- df %>% filter(NewYork$location %in% d2$Var1) #Filters out those locations that don't have at least 20 job postings from df
df <- na.omit(df) #Removes any NA values from df
df <- df %>% filter(df$NewYork.location != "NY, USA") #Filters out locations that are listed as NY, USA without the specific location
df <- df %>% filter(df$NewYork.location != "USA") #Filters out locations that are listed as USA without the specific location

df <- df %>% filter(df$NewYork.min_amount >= 10000) #Filters out jobs that have a min_amount lower than 10000 to remove hourly wages

options(scipen = 999) #Gets rid of scientific notation

ggplot(df, aes(df$NewYork.location, df$NewYork.min_amount, fill=df$NewYork.location)) + 
  geom_boxplot(show.legend=FALSE) + ggtitle("Comparison of Salary's between locations in New York") + 
  labs(x="location", y="min salary") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust =)) #Graphs the side-by-side boxplot


df <- data.frame(Massachusetts$location, Massachusetts$min_amount)

t <- table(df$Massachusetts.location)
d <- data.frame(t)
n <- names(d)
d2 <- d %>% filter(d$Freq >= 17)
d2

df <- df %>% filter(Massachusetts$location %in% d2$Var1)
df <- na.omit(df)
df <- df %>% filter(df$Massachusetts.location != "USA")
df <- df %>% filter(df$Massachusetts.location != "MA, USA")

df <- df %>% filter(df$Massachusetts.min_amount >= 10000)

ggplot(df, aes(df$Massachusetts.location, df$Massachusetts.min_amount, fill=df$Massachusetts.location)) + 
  geom_boxplot(show.legend=FALSE) + ggtitle("Comparison of Salary's between locations in Massachusetts") + 
  labs(x="location", y="min salary") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust =))


df <- data.frame(Connecticut$location, Connecticut$min_amount)

t <- table(df$Connecticut.location)
d <- data.frame(t)
n <- names(d)
d2 <- d %>% filter(d$Freq >= 10)
d2

df <- df %>% filter(Connecticut$location %in% d2$Var1)
df <- na.omit(df)
df <- df %>% filter(df$Connecticut.location != "CT, USA")

df <- df %>% filter(df$Connecticut.min_amount >= 10000)

ggplot(df, aes(df$Connecticut.location, df$Connecticut.min_amount, fill=df$Connecticut.location)) + 
  geom_boxplot(show.legend=FALSE) + ggtitle("Comparison of Salary's between locations in Connecticut") + 
  labs(x="location", y="min salary") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust =))



#Title vs Location per state (Both categorical so stacked bargraphs)
df <- data.frame(NewYork$location, NewYork$title) #Creates a data frame with New York job locations and job titles
t <- table(df$NewYork.location) #Creates a table from the data frame of New York job locations
d <- data.frame(t) #Creates a data frame from the table
# n <- names(d) 
d2 <- d %>% filter(d$Freq >= 20) #Creates d2 which is d but filters out any locations that don't have at least 20 job postings
d2 #Displays d2
df <- df %>% filter(NewYork$location %in% d2$Var1) #Filters out those locations that don't have at least 20 job postings from df
df <- df %>% filter(df$NewYork.location != "NY, USA") #Filters out locations that are listed as NY, USA instead of the specific location
df <- df %>% filter(df$NewYork.location != "USA") #Filters out locations that are listed as USA instead of the specific location

t <- table(df$NewYork.title) #Creates a table from the data frame of New York job titles
d <- data.frame(t) #Creates a data frame from the table
# n <- names(d)
d2 <- d %>% filter(d$Freq >= 24) #Creates d2 which is d but filters out any titles that don't have at least 24 job postings
d2 #Displays d2
df <- df %>% filter(NewYork.title %in% d2$Var1) #Filters out those titles that don't have at least 24 job postings from df

title <- df$NewYork.title #Sets title to the data frame of New York job titles
titlefactor <- factor(title) #Sets titlefactor to the title factor

jobs.location <- table(df$NewYork.location, titlefactor) #Creates jobs.location which is the table of the data frame of New York job locations and the titlefactor
jobs.location.conditional <- prop.table(jobs.location, margin = 1) #Creates jobs.location.conditional which is a proportional table of jobs.location
df.jobs.location <- data.frame(jobs.location.conditional) #Creates a data frame from jobs.location.conditional
ggplot(df.jobs.location, aes(Var1, Freq, fill = titlefactor)) + geom_col() +
  labs(y = "Proportion", fill = "Job Title", 
       title = "Proportion of job titles in each city in New York") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust =)) #Graphs the relative frequency stacked bar graph


df <- data.frame(Massachusetts$location, Massachusetts$title)
t <- table(df$Massachusetts.location)
d <- data.frame(t)
n <- names(d)
d2 <- d %>% filter(d$Freq >= 17)
d2
df <- df %>% filter(Massachusetts$location %in% d2$Var1)
df <- df %>% filter(df$Massachusetts.location != "MA, USA")
df <- df %>% filter(df$Massachusetts.location != "USA")

t <- table(df$Massachusetts.title)
d <- data.frame(t)
n <- names(d)
d2 <- d %>% filter(d$Freq >= 15)
d2
df <- df %>% filter(Massachusetts.title %in% d2$Var1)

title <- df$Massachusetts.title
titlefactor <- factor(title)

jobs.location <- table(df$Massachusetts.location, titlefactor)
jobs.location.conditional <- prop.table(jobs.location, margin = 1)
df.jobs.location <- data.frame(jobs.location.conditional)
ggplot(df.jobs.location, aes(Var1, Freq, fill = titlefactor)) + geom_col() +
  labs(y = "Proportion", fill = "Job Title", 
       title = "Proportion of job titles in each city in Massachusetts") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust =))


df <- data.frame(Connecticut$location, Connecticut$title)
t <- table(df$Connecticut.location)
d <- data.frame(t)
n <- names(d)
d2 <- d %>% filter(d$Freq >= 10)
d2
df <- df %>% filter(Connecticut$location %in% d2$Var1)
df <- df %>% filter(df$Connecticut.location != "CT, USA")

t <- table(df$Connecticut.title)
d <- data.frame(t)
n <- names(d)
d2 <- d %>% filter(d$Freq >= 3)
d2
df <- df %>% filter(Connecticut.title %in% d2$Var1)

title <- df$Connecticut.title
titlefactor <- factor(title)

jobs.location <- table(df$Connecticut.location, titlefactor)
jobs.location.conditional <- prop.table(jobs.location, margin = 1)
df.jobs.location <- data.frame(jobs.location.conditional)
ggplot(df.jobs.location, aes(Var1, Freq, fill = titlefactor)) + geom_col() +
  labs(y = "Proportion", fill = "Job Title", 
       title = "Proportion of job titles in each city in Connecticut") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust =))
