# Data source:
# https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.PCAP.CD#
# https://www.hnb.hr/en/web/guest/statistics/statistical-data/financial-sector/other-monetary-financial-institutions/credit-institutions/interest-rates

# Data preprocessing

#gdp_per_capita in US$
gdp_per_capita = read.csv("gdp_per_capita.csv", sep=";", nrows = 1,check.names = FALSE)
house_price_index = read.csv("house_price_index.csv", sep=";", dec = ".", check.names = FALSE)
#1
housing_loans_interest_rates = read.csv("housing_loans_interest_rates_2.csv", sep=";",check.names = FALSE)

library(dplyr)

gdp_per_capita <- gdp_per_capita[4:ncol(gdp_per_capita)] %>%
  select(starts_with("Series Name"),starts_with("201"))

house_price_index <- house_price_index[7:ncol(house_price_index)]

# we will take only housing loans (first row) - next analysis - some other housing loan rate type
#2
housing_loans_interest_rates <- head(housing_loans_interest_rates,1) %>%
  select(starts_with("Loan"), starts_with("201", ignore.case = TRUE))

housing_loans_interest_rates <- sapply(housing_loans_interest_rates, gsub, pattern = ",", replacement= ".")

# transpose the datasets

gdp_per_capita_1 <- as.data.frame(matrix(gdp_per_capita))
rownames(gdp_per_capita_1) <- colnames(gdp_per_capita)

house_price_index_1 <- as.data.frame(matrix(house_price_index))
rownames(house_price_index_1) <- colnames(house_price_index)

housing_loans_interest_rates_1 <- as.data.frame(matrix(tail(housing_loans_interest_rates,-1)))
rownames(housing_loans_interest_rates_1) <- colnames(housing_loans_interest_rates)


# edit names of the columns

colnames(gdp_per_capita) <- "gdp_per_capita (us$)"
colnames(house_price_index) <- "house_price_index"
colnames(housing_loans_interest_rates) <- "housing_loans_interest_rates"

# edit names of the rows

rownames(housing_loans_interest_rates_1) <- c("2013","2014","2015","2016","2017","2018","2019")

# Binding datasets by rows

housing_loans_interest_rates_1 <- tail(housing_loans_interest_rates_1,-2)

dataset <- bind_cols(bind_cols(gdp_per_capita_1, house_price_index_1),housing_loans_interest_rates_1)

rownames(dataset) <- c("2015","2016","2017","2018","2019")
colnames(dataset) <- c("gdp_per_capita (us$)","house_price_index","housing_loans_interest_rates")

dataset$`gdp_per_capita (us$)` <- as.numeric(as.character(dataset$`gdp_per_capita (us$)`))
dataset$house_price_index <- as.numeric(as.character(dataset$house_price_index))
dataset$housing_loans_interest_rates <- as.numeric(as.character(dataset$housing_loans_interest_rates))


# Dependent variable - house price index

# Splitting the dataset into the Training set and Test set

library(caTools)

set.seed(123)
split = sample.split(dataset$`gdp_per_capita (us$)`, SplitRatio = 0.7)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


# Feature Scaling - not needed in Multiple Linear Regression

#training_set = scale(training_set)
#test_set = scale(test_set)

# Fitting Multiple Linear Regressor to the training set

regressor = lm(house_price_index ~ .,
               data = training_set)

# Predicting the test set results

y_pred = predict(regressor,
                 newdata = test_set)

# Backward elimination

# Visualizing the dataset - house price index,gdp per capita and interest rates per year

ggplot() +
  geom_point(aes(x = row.names(dataset), y = scale(dataset$house_price_index)),
             color = 'red') +
  geom_line(aes(x = row.names(dataset), y = scale(dataset$housing_loans_interest_rates), group = 1),
            color = 'blue') +
  geom_line(aes(x = row.names(dataset), y = scale(dataset$`gdp_per_capita (us$)`), group = 1),
            color = 'dark green')

# House price index isn't linear but polynomial -> using polynomial regression



