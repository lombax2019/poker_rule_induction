# created three new variables in dataset via excel:
# card_first_count: =large(frequency([C1:C5],[C1:C5]),1)
# card_second_count: =large(frequency([C1:C5],[C1:C5]),2)
# face_count: =countif([C1:C5],"=1")+countif([C1:C5],">10")
# suit_count: =max(frequency([S1:S5],[S1:S5]))

# set directory and loaded data
setwd("~/Poker Rule Induction")
train <- read.csv("train.csv")
test <- read.csv("test.csv")

# loaded and ran randomForest
library(randomForest)
set.seed(415)
fit <- randomForest(as.factor(hand) ~ S1 + S2 + S3 + S4 + S5 + C1 + C2 + C3 + C4 + C5 + card_first_count + card_second_count + face_count + suit_count, data=train, importance=TRUE, ntree=500)

# viewed results: card_count helped greatly
varImpPlot(fit)

# assigned id column to test data
id <- rownames(test)
test <- cbind(id=id, test)

# applied prediction and wrote submit file
prediction <- predict(fit, test)
submit <- data.frame(id=test$id, hand=prediction)
write.csv(submit, file="firstattempt.csv", row.names=FALSE)
