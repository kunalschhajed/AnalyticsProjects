## mergered all 4 files into one

# load data
#dmef1 = read.csv("/Users/liangjulia/Downloads/CSFinalProject/DMEFExtractContactsV01.csv")
#str(dmef1)
dmef2 = read.csv("DMEFExtractLines.csv")
dmef3 = read.csv("DMEFExtractOrders.csv")
dmef4 = read.csv("DMEFExtractSummary.csv")
dmef5 = merge(dmef2, dmef3)
dmef6 = merge(dmef5, dmef4)
dmef1 = read.csv("DMEFExtractContacts.csv")
dmef7 = merge(dmef6, dmef1)
library(purrr)
#map_dbl(dmef6, ~sum(is.na(.)))
data1 <- na.omit(dmef7)
str(data1)

# Creating Training and Testing Sets -  
library(caTools)

set.seed(1234)
data1split = sample.split(data1, SplitRatio = 0.70)
dataTrain = subset(data1, split==TRUE)
dataTest = subset(data1, split==FALSE)

#x=table(dataTest$LineDollars)
#x

lm.model1 <- lm(LineDollars ~., data=dataTrain, family = 'binomial' )
summary(lm.model1)

# Multiple R^2 is 0.323 for this linear regression model



# after this analysis, select the ones shows obvious trend, and rebuild the model see if we can have better results

#lm.model2 <- lm(LineDollars ~ OccupCd + AgeCode + IncCode + HomeCode + LengthRes 
#                + Pets + PaymentType + Gift + StoreDist + FirstChannel + FirstDollar
#                + FirstYYMM + HomeValue + Child0_2 + Child3_5 + Child6_11 + Child17_18
#                , data=dataTrain, family = 'binomial' )
#summary(lm.model2)

data2 = subset(data1, select = -c(Dwelling, Cooking, Camping, DogOwner) )
str(data2)

set.seed(1234)
data2split = sample.split(data2, SplitRatio = 0.70)
data2Train = subset(data2, split==TRUE)
data2Test = subset(data2, split==FALSE)

lm.model3 <- lm(LineDollars ~., data=data2Train, family = 'binomial' )
summary(lm.model3)

### Build a CART model to classfy these customers
# Build a classification tree CART model on the training data
sales.CT = rpart(Gift ~., data=dataTrain, method = "class", minbucket = 10)

# Plot the tree
prp(sales.CT)

Dollar.CT = rpart(LineDollars ~., data=dataTrain, method = "class", minbucket = 10)

# Plot the tree
prp(Dollar.CT)

lm.model5 <- lm(LineDollars ~ OrderMethod + Gift, data=dataTrain, family = 'binomial' )
summary(lm.model5)

HomeCode.CT = rpart(HomeCode ~., data=dataTrain, method = "class", minbucket = 10)

# Plot the tree
prp(HomeCode.CT)

OrderMethod.CT = rpart(OrderMethod ~., data=dataTrain, method = "class", minbucket = 10)

# Plot the tree
prp(OrderMethod.CT)

StoreDist.CT = rpart(StoreDist ~., data=dataTrain, method = "class", minbucket = 10)

# Plot the tree
prp(StoreDist.CT)


