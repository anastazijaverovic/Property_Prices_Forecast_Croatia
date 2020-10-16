# Data source:
# https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.PCAP.CD#
# https://www.hnb.hr/en/web/guest/statistics/statistical-data/financial-sector/other-monetary-financial-institutions/credit-institutions/interest-rates

# Data preprocessing

gdp_per_capita = read.csv("gdp_per_capita.csv", sep=",", nrows = 1,check.names = FALSE)
house_price_index = read.csv("house_price_index.csv", sep=";",check.names = FALSE)
housing_loans_interest_rates = read.csv("housing_loans_interest_rates.csv", sep=";",check.names = FALSE)

# Get the average of monthly interest rates on yearly basis

library(dplyr)



year = unique(as.numeric(substr(colnames(housing_loans_interest_rates[-1]),4,5)))
mutate(housing_loans_interest_rates, year = year)


housing_loans_interest_rates[year] <- NA

cbind(housing_loans_interest_rates, setNames( lapply(year, function(x) x=NA), year) )

#next - group by distinct year values and get the average of the interest rates

group_by(distinct(as.data.frame(as.numeric(substr(colnames(housing_loans_interest_rates[-1]),4,5))))) %>%
summarise(mean_int_rates = mean(as.numeric(substr(colnames(housing_loans_interest_rates[-1]),4,5))),n = n())



# Binding datasets by rows

