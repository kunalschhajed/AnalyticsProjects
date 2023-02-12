LineItems = read.csv("DMEFExtractLines.csv")
str(LineItems)


#install.packages("dplyr")
library(dplyr)
#install.packages("lubridate")
library(lubridate)


LineItems$OrderDate = as.Date(as.character(LineItems$OrderDate), format = "%Y%m%d")
LineItems$MonthDiff = interval(LineItems$OrderDate, "2007-12-31") %/% months(1)


Recency = aggregate(LineItems$MonthDiff, list(LineItems$Cust_ID), FUN = min)
Frequency = aggregate(LineItems$Cust_ID, list(LineItems$Cust_ID), FUN = length)
Monetary = aggregate(LineItems$LineDollars, list(LineItems$Cust_ID), FUN = sum)

Merged_Data = merge(Recency, Frequency, by = "Group.1", all = TRUE)
RFM = merge(Merged_Data, Monetary, by = "Group.1", all = TRUE)

colnames(RFM) = c('Cust_ID', 'Recency', 'Frequency', 'Monetary')

RFM$Recency_Score = cut(RFM$Recency, 9 ,labels=F)
RFM$Frequency_Score = cut(RFM$Frequency, 9 ,labels=F)
RFM$Monetary_Score = cut(RFM$Monetary, 9 ,labels=F)

RFM$RFM_Score = RFM$Recency_Score*100 + RFM$Frequency_Score*10 + RFM$Monetary_Score

head(RFM, 20)
