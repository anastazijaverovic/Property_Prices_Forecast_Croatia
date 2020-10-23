# Data source:
# https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.PCAP.CD#
# https://www.hnb.hr/en/web/guest/statistics/statistical-data/financial-sector/other-monetary-financial-institutions/credit-institutions/interest-rates

# Data preprocessing

#gdp_per_capita in US$
gdp_per_capita = read.csv("gdp_per_capita.csv", sep=";", nrows = 1,check.names = FALSE)
house_price_index = read.csv("house_price_index.csv", sep=";", dec = ".", check.names = FALSE)
housing_loans_interest_rates = read.csv("housing_loans_interest_rates_2.csv", sep=";",check.names = FALSE)

housing_loans_interest_rates <- sapply(housing_loans_interest_rates, gsub, pattern = ",", replacement= ".")


library(dplyr)

gdp_per_capita <- gdp_per_capita[4:ncol(gdp_per_capita)] %>%
  select(starts_with("Series Name"),starts_with("201"))

house_price_index <- house_price_index[7:ncol(house_price_index)]

# we will take only housing loans (first row) - next analysis - some other housing loan rate type
housing_loans_interest_rates <- head(housing_loans_interest_rates,1) %>%
  select(starts_with("Loan"), starts_with("201", ignore.case = TRUE))

housing_loans_interest_rates <- housing_loans_interest_rates[4:ncol(housing_loans_interest_rates)]

# transpose the datasets

gdp_per_capita_1 <- as.data.frame(matrix(gdp_per_capita))
rownames(gdp_per_capita_1) <- colnames(gdp_per_capita)

house_price_index_1 <- as.data.frame(matrix(house_price_index))
rownames(house_price_index_1) <- colnames(house_price_index)

housing_loans_interest_rates_1 <- as.data.frame(matrix(housing_loans_interest_rates))
rownames(housing_loans_interest_rates_1) <- colnames(housing_loans_interest_rates)


# edit names of the columns

colnames(gdp_per_capita) <- "gdp_per_capita (us$)"
colnames(house_price_index) <- "house_price_index"
colnames(housing_loans_interest_rates) <- "housing_loans_interest_rates"


# Binding datasets by rows

rbind(gdp_per_capita[-1],head(housing_loans_interest_rates[-1],1))

#

housing_loans_interest_rates <- lapply(housing_loans_interest_rates, as.character)
housing_loans_interest_rates <- gsub(",",".",housing_loans_interest_rates)
housing_loans_interest_rates <- lapply(housing_loans_interest_rates, as.double)
