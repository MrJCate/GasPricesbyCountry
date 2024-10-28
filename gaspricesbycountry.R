# Ensure the tidyverse and ggplot2 packages are installed
# install.packages("tidyverse")
# install.packages("ggplot2")

# Load packages
library("tidyverse")
library("ggplot2")

# Read data and set to variable
print ("Starting..")
gas <- read.csv("/Users/justecat/Documents/Code/R/gasprices.csv") 
gas

# Converting format from wide to long
gas.liters <- gas %>% pivot_longer(cols=c('USA', 'China', 'Germany', 'Japan', 'India',
                                   'UK', 'France', 'Brazil', 'Italy', 'Canada'),
                          names_to='Country',
                          values_to='price')
gas.liters

# Data is in liter. Convert to gallons
gas.usd <- gas.liters %>%
              mutate(price = price * 3.78541)

# # Plot UAS vs China
uas_china_plot <- ggplot(subset(gas.usd, Country %in% c('USA','China')), aes(x=Year, y=USD / Gallon)) +
  geom_line(aes(x = Year, y = price, group = Country, color = Country)) +
  ggtitle("Gas Prices In The USA and Canada") +
  scale_x_continuous(breaks=seq(2000,2020,by=2))
uas_china_plot
ggsave("uas_china_plot.png")

# # Plot all 10 countries
all_plot <- ggplot(gas.usd, aes(x=Year, y=USD / Gallon)) +
  geom_line(aes(x = Year, y = price, group = Country, color = Country)) +
  ggtitle("Gas Prices Around The World") +
  scale_x_continuous(breaks=seq(2000,2020,by=2))
all_plot
ggsave("all_plot.png")