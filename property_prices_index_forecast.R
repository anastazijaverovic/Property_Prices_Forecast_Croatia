# Data source:
#https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.PCAP.CD#

# Data preprocessing

gdp_per_capita = read.csv("gdp_per_capita.csv", sep=",", nrows = 1)
house_price_index = read.csv("house_price_index.csv", sep=";")
