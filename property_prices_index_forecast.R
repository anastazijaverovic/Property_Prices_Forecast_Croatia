# Data source:
# https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.PCAP.CD#
# https://www.hnb.hr/en/web/guest/statistics/statistical-data/financial-sector/other-monetary-financial-institutions/credit-institutions/interest-rates

# Data preprocessing

gdp_per_capita = read.csv("gdp_per_capita.csv", sep=",", nrows = 1,check.names = FALSE)
house_price_index = read.csv("house_price_index.csv", sep=";",check.names = FALSE)
housing_loans_interest_rates = read.csv("housing_loans_interest_rates.csv", sep=";",check.names = FALSE)


housing_loans_interest_rates <- head(housing_loans_interest_rates,1)
names(housing_loans_interest_rates) <- as.numeric(substr(colnames(housing_loans_interest_rates[-1]),4,5))
names(housing_loans_interest_rates)[1] <- "Loan type"
names(housing_loans_interest_rates)[ncol(housing_loans_interest_rates)] <- "20"

# Get the average of monthly interest rates on yearly basis

library(dplyr)

year = unique(as.numeric(substr(colnames(housing_loans_interest_rates[-1]),4,5)))

#next - group by distinct year values and get the average of the interest rates

group_by(year) %>%
summarise(mean_int_rates = mean(as.numeric(substr(colnames(housing_loans_interest_rates[-1]),4,5))),n = n())

housing_loans_interest_rates <- lapply(housing_loans_interest_rates, as.character)
housing_loans_interest_rates <- gsub(",",".",housing_loans_interest_rates)
housing_loans_interest_rates <- lapply(housing_loans_interest_rates, as.double)


colMeans(housing_loans_interest_rates[2:12])


# Binding datasets by rows

