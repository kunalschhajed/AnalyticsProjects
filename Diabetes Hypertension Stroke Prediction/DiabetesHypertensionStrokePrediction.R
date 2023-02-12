data = read.csv("health_data.csv")
str(data)
set.seed(88)
#install.packages("caTools")
library(caTools)

#####################################################
#Diabetes Prediction
#####################################################

#splitting data into train and test according to diabetes data
split = sample.split(data$Diabetes, SplitRatio = 0.75)
DiabetesTrain = subset(data, split==TRUE)
DiabetesTest = subset(data, split==FALSE)

#building the Logit model

DiabetesModel = glm(Diabetes ~ Age + Sex + PhysActivity + Fruits + HighChol + BMI + HeartDiseaseorAttack  + Veggies + HvyAlcoholConsump + GenHlth + DiffWalk + Hypertension, data = DiabetesTrain, family = binomial)
summary(DiabetesModel)

#Evaluating the model
DiabetesTest$PredictedRisk = predict(DiabetesModel, type="response", newdata = DiabetesTest)
tbl = table(DiabetesTest$Diabetes, DiabetesTest$PredictedRisk > 0.45) 
accuracy_model = sum(diag(tbl))/sum(tbl) #74.25%

#BaseLine Accuracy
BaseLineAccuracy = sum(data$Diabetes)/nrow(data) #50%




#####################################################
#Hypertension Prediction
#####################################################

#splitting data into train and test according to diabetes data
split = sample.split(data$Hypertension, SplitRatio = 0.75)
HypertensionTrain = subset(data, split==TRUE)
HypertensionTest = subset(data, split==FALSE)

#building the Logit model

HypertensionModel = glm(Hypertension ~ Age + Sex + PhysActivity + Fruits + HighChol + BMI + HeartDiseaseorAttack  + Veggies + GenHlth  + PhysHlth + DiffWalk + Diabetes, data = HypertensionTrain, family = binomial)
summary(HypertensionModel)

#Evaluating the model
HypertensionTest$PredictedRisk = predict(HypertensionModel, type="response", newdata = HypertensionTest)
tbl1 = table(HypertensionTest$Hypertension, HypertensionTest$PredictedRisk > 0.47) 
accuracy_model1 = sum(diag(tbl1))/sum(tbl1) #74.32%

#BaseLine Accuracy
BaseLineAccuracy1 = sum(data$Hypertension)/nrow(data) #56.34%

#####################################################
#Stroke Prediction
#####################################################

#splitting data into train and test according to diabetes data
split = sample.split(data$Stroke, SplitRatio = 0.75)
StrokeTrain = subset(data, split==TRUE)
StrokeTest = subset(data, split==FALSE)

#building the Logit model

StrokeModel = glm(Stroke ~ Age + Sex + PhysActivity + Fruits + HighChol + BMI + HeartDiseaseorAttack  + Veggies + GenHlth + DiffWalk + Hypertension + Diabetes, data = StrokeTrain, family = binomial)
summary(StrokeModel)

#Evaluating the model
StrokeTest$PredictedRisk = predict(StrokeModel, type="response", newdata = StrokeTest)
tbl2 = table(StrokeTest$Stroke, StrokeTest$PredictedRisk > 0.5) 
accuracy_model2 = sum(diag(tbl2))/sum(tbl2) #93.78

#BaseLine Accuracy
BaseLineAccuracy2 = 1-sum(StrokeTrain$Stroke)/nrow(StrokeTrain) #93.78%



############################################################################
#CART MODEL
############################################################################
library("caTools")
library(rpart)
library("rpart.plot")

#checking correlation
cor(data)  #no high correlation


#####################################################
#Diabetes Prediction CART Model
#####################################################

DiabCart = rpart(Diabetes ~ ., method="class", data=DiabetesTrain, minbucket=3000)
prp(DiabCart)

DiabCartPredict = predict(DiabCart, newdata=DiabetesTest, type="class") 
tbl = table(DiabetesTest$Diabetes, DiabCartPredict) 
sum(diag(tbl))/sum(tbl) #70.73%

#Baseline Model
1-sum(DiabetesTest$Diabetes)/nrow(DiabetesTest) 


#####################################################
#Hypertension Prediction CART Model
#####################################################

HypertensionCart = rpart(Hypertension ~ ., method="class", data=HypertensionTrain, minbucket=5000)
prp(HypertensionCart)

HypertensionCartPredict = predict(HypertensionCart, newdata=HypertensionTest, type="class") 
tbl = table(HypertensionTest$Hypertension, HypertensionCartPredict) 
sum(diag(tbl))/sum(tbl) #71.97%

#Baseline Model
BaseLineAccuracy1 = sum(data$Hypertension)/nrow(data) #56.34%


#####################################################
#Stroke Prediction CART Model
#####################################################

StrokeCart = rpart(Stroke ~ ., method="class", data=StrokeTrain)
prp(StrokeCart)

StrokeCartPredict = predict(StrokeCart, newdata=StrokeTest, type="class") 
tbl = table(StrokeTest$Stroke, StrokeCartPredict) 
sum(diag(tbl))/sum(tbl) 

#Baseline Model
BaseLineAccuracy2 = sum(data$Stroke)/nrow(data) #62.17%

#############################################################################
#exploratory analysis
#############################################################################
datasplit = sample.split(data, SplitRatio = 0.3)
data2 = subset(data, datasplit == TRUE)

distances = dist(data2, method="euclidean") 
clusterHealth = hclust(distances, method="ward.D") plot(clusterHealth)

clusterGroups = cutree(clusterHealth, k=4)
tapply(data2$Age, clusterGroups, mean)
tapply(data2$Sex, clusterGroups, mean)
tapply(data2$HighChol, clusterGroups, mean)
tapply(data2$CholCheck, clusterGroups, mean)
tapply(data2$BMI, clusterGroups, mean)
tapply(data2$Smoker, clusterGroups, mean)
tapply(data2$HeartDiseaseorAttack, clusterGroups, mean)
tapply(data2$PhysActivity, clusterGroups, mean)
tapply(data2$Fruits, clusterGroups, mean)
tapply(data2$Veggies, clusterGroups, mean)
tapply(data2$HvyAlcoholConsump, clusterGroups, mean)
tapply(data2$GenHlth, clusterGroups, mean)
tapply(data2$MentHlth, clusterGroups, mean)
tapply(data2$PhysHlth, clusterGroups, mean)
tapply(data2$DiffWalk, clusterGroups, mean)
tapply(data2$Diabetes, clusterGroups, mean)
tapply(data2$Hypertension, clusterGroups, mean)
tapply(data2$Stroke, clusterGroups, mean)

######################################################################
#Random Forests
######################################################################
#Diabetes

set.seed(888)
split = sample.split(Data$Diabetes, SplitRatio = 0.75)
DiabetesTrain = subset(Data, split==TRUE)
DiabetesTest = subset(Data, split==FALSE)

DiabetesTrain$Diabetes = as.factor(DiabetesTrain$Diabetes)
DiabetesTest$Diabetes = as.factor(DiabetesTest$Diabetes)

DiabetesForest = randomForest(Diabetes ~ Age + Sex + HighChol + CholCheck + BMI + Smoker + HeartDiseaseorAttack + PhysActivity + Fruits + Veggies + HvyAlcoholConsump + GenHlth + MentHlth + PhysHlth + DiffWalk + Hypertension + Stroke, data = DiabetesTrain)

DiabetesPredictForest = predict(DiabetesForest, newdata=DiabetesTest)
tbl = table(DiabetesTest$Diabetes, DiabetesPredictForest)
sum(diag(tbl))/sum(tbl) #Accuracy results: 0.7494907



#Hypertension

set.seed(888)
split = sample.split(Data$Hypertension, SplitRatio = 0.75)
HypertensionTrain = subset(Data, split==TRUE)
HypertensionTest = subset(Data, split==FALSE)

HypertensionTrain$Hypertension = as.factor(HypertensionTrain$Hypertension)
HypertensionTest$Hypertension = as.factor(HypertensionTest$Hypertension)

HypertensionForest = randomForest(Hypertension ~ Age + Sex + HighChol + CholCheck + BMI + Smoker + HeartDiseaseorAttack + PhysActivity + Fruits + Veggies + HvyAlcoholConsump + GenHlth + MentHlth + PhysHlth + DiffWalk + Diabetes + Stroke, data = HypertensionTrain)

HypertensionPredictForest = predict(HypertensionForest, newdata=HypertensionTest)
tbl = table(HypertensionTest$Hypertension, HypertensionPredictForest)
sum(diag(tbl))/sum(tbl) #Accuracy results: 0.7326996


#Stroke

set.seed(888)
split = sample.split(Data$Stroke, SplitRatio = 0.75)
StrokeTrain = subset(Data, split==TRUE)
StrokeTest = subset(Data, split==FALSE)

StrokeTrain$Stroke = as.factor(StrokeTrain$Stroke)
StrokeTest$Stroke = as.factor(StrokeTest$Stroke)

StrokeForest = randomForest(Stroke ~ Age + Sex + HighChol + CholCheck + BMI + Smoker + HeartDiseaseorAttack + PhysActivity + Fruits + Veggies + HvyAlcoholConsump + GenHlth + MentHlth + PhysHlth + DiffWalk + Diabetes + Hypertension, data = StrokeTrain)

StrokePredictForest = predict(StrokeForest, newdata=StrokeTest)
tbl = table(StrokeTest$Stroke, StrokePredictForest)
sum(diag(tbl))/sum(tbl) #Accuracy results: 0.9373055

##################################################################################
#Logit Regression
##################################################################################
#####################################################
#Diabetes Prediction
#####################################################

#splitting data into train and test according to diabetes data
split = sample.split(data$Diabetes, SplitRatio = 0.75)
DiabetesTrain = subset(data, split==TRUE)
DiabetesTest = subset(data, split==FALSE)

#building the Logit model

DiabetesModel = glm(Diabetes ~ Age + Sex + PhysActivity + Fruits + HighChol + BMI + HeartDiseaseorAttack  + Veggies + HvyAlcoholConsump + GenHlth + DiffWalk + Hypertension, data = DiabetesTrain, family = binomial)
summary(DiabetesModel)

#Evaluating the model
DiabetesTest$PredictedRisk = predict(DiabetesModel, type="response", newdata = DiabetesTest)
tbl = table(DiabetesTest$Diabetes, DiabetesTest$PredictedRisk > 0.45) 
accuracy_model = sum(diag(tbl))/sum(tbl) #74.25%

#BaseLine Accuracy
BaseLineAccuracy = sum(data$Diabetes)/nrow(data) #50%




#####################################################
#Hypertension Prediction
#####################################################

#splitting data into train and test according to diabetes data
split = sample.split(data$Hypertension, SplitRatio = 0.75)
HypertensionTrain = subset(data, split==TRUE)
HypertensionTest = subset(data, split==FALSE)

#building the Logit model

HypertensionModel = glm(Hypertension ~ Age + Sex + PhysActivity + Fruits + HighChol + BMI + HeartDiseaseorAttack  + Veggies + GenHlth  + PhysHlth + DiffWalk + Diabetes, data = HypertensionTrain, family = binomial)
summary(HypertensionModel)

#Evaluating the model
HypertensionTest$PredictedRisk = predict(HypertensionModel, type="response", newdata = HypertensionTest)
tbl1 = table(HypertensionTest$Hypertension, HypertensionTest$PredictedRisk > 0.47) 
accuracy_model1 = sum(diag(tbl1))/sum(tbl1) #74.32%

#BaseLine Accuracy
BaseLineAccuracy1 = sum(data$Hypertension)/nrow(data) #56.34%

#####################################################
#Stroke Prediction
#####################################################

#splitting data into train and test according to diabetes data
split = sample.split(data$Stroke, SplitRatio = 0.75)
StrokeTrain = subset(data, split==TRUE)
StrokeTest = subset(data, split==FALSE)

#building the Logit model

StrokeModel = glm(Stroke ~ Age + Sex + PhysActivity + Fruits + HighChol + BMI + HeartDiseaseorAttack  + Veggies + GenHlth + DiffWalk + Hypertension + Diabetes, data = StrokeTrain, family = binomial)
summary(StrokeModel)

#Evaluating the model
StrokeTest$PredictedRisk = predict(StrokeModel, type="response", newdata = StrokeTest)
tbl2 = table(StrokeTest$Stroke, StrokeTest$PredictedRisk > 0.5) 
accuracy_model2 = sum(diag(tbl2))/sum(tbl2) #93.78

#BaseLine Accuracy
BaseLineAccuracy2 = 1-sum(StrokeTrain$Stroke)/nrow(StrokeTrain) #93.78%


#######################################################################################
#K-means clustering
#######################################################################################
library(caret)
prepoch = preProcess(health) # pre-processes the data
healthNorm = predict(prepoch, health)

summary(healthNorm)
apply(healthNorm,2,sd)

# K-means clustering for 3 clusters
set.seed(88)
KmeansClusthealth1 = kmeans(healthNorm, centers = 3, iter.max = 1000)
KmeansClusthealth1 
KmeansClusthealth1$centers

table(KmeansClusthealth1$cluster)

## Compare the average values in each of the variables for the 3 clusters with unnormalized data
colMeans(health[KmeansClusthealth1$cluster == 1, ])
colMeans(health[KmeansClusthealth1$cluster == 2, ])
colMeans(health[KmeansClusthealth1$cluster == 3, ])

# K-means clustering for 5 clusters
set.seed(88)
KmeansClusthealth2 = kmeans(healthNorm, centers = 5, iter.max = 1000)
KmeansClusthealth2 
KmeansClusthealth2$centers
table(KmeansClusthealth2$cluster)
## Compare the average values in each of the variables for the 3 clusters with unnormalized data
colMeans(health[KmeansClusthealth2$cluster == 1, ])
colMeans(health[KmeansClusthealth2$cluster == 2, ])
colMeans(health[KmeansClusthealth2$cluster == 3, ])
colMeans(health[KmeansClusthealth2$cluster == 4, ])
colMeans(health[KmeansClusthealth2$cluster == 5, ])

# K-means clustering for 10 clusters
set.seed(88)
KmeansClusthealth3 = kmeans(healthNorm, centers = 10, iter.max = 1000)
KmeansClusthealth3 
KmeansClusthealth3$centers
## Compare the average values in each of the variables for the 3 clusters with unnormalized data
colMeans(health[KmeansClusthealth3$cluster == 1, ])
colMeans(health[KmeansClusthealth3$cluster == 2, ])
colMeans(health[KmeansClusthealth3$cluster == 3, ])
colMeans(health[KmeansClusthealth3$cluster == 4, ])
colMeans(health[KmeansClusthealth3$cluster == 5, ])
colMeans(health[KmeansClusthealth3$cluster == 6, ])
colMeans(health[KmeansClusthealth3$cluster == 7, ])
colMeans(health[KmeansClusthealth3$cluster == 8, ])
colMeans(health[KmeansClusthealth3$cluster == 9, ])
colMeans(health[KmeansClusthealth3$cluster == 10, ])

############################################################################
#CART MODEL
############################################################################
library("caTools")
library(rpart)
library("rpart.plot")

#checking correlation
cor(data)  #no high correlation
#####################################################
#Diabetes Prediction CART Model
#####################################################
DiabCart = rpart(Diabetes ~ ., method="class", data=DiabetesTrain, minbucket=3000)
prp(DiabCart)

DiabCartPredict = predict(DiabCart, newdata=DiabetesTest, type="class") 
tbl = table(DiabetesTest$Diabetes, DiabCartPredict) 
sum(diag(tbl))/sum(tbl) #70.73%

#Baseline Model
1-sum(DiabetesTest$Diabetes)/nrow(DiabetesTest) 
#####################################################
#Hypertension Prediction CART Model
#####################################################
HypertensionCart = rpart(Hypertension ~ ., method="class", data=HypertensionTrain, minbucket=5000)
prp(HypertensionCart)

HypertensionCartPredict = predict(HypertensionCart, newdata=HypertensionTest, type="class") 
tbl = table(HypertensionTest$Hypertension, HypertensionCartPredict) 
sum(diag(tbl))/sum(tbl) #71.97%

#Baseline Model
BaseLineAccuracy1 = sum(data$Hypertension)/nrow(data) #56.34%


#####################################################
#Stroke Prediction CART Model
#####################################################

StrokeCart = rpart(Stroke ~ ., method="class", data=StrokeTrain)
prp(StrokeCart)

StrokeCartPredict = predict(StrokeCart, newdata=StrokeTest, type="class") 
tbl = table(StrokeTest$Stroke, StrokeCartPredict) 
sum(diag(tbl))/sum(tbl) 

#Baseline Model
BaseLineAccuracy2 = sum(data$Stroke)/nrow(data) #62.17%






