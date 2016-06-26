library(devtools)
load_all("../mlr/")


source("createFizzbuzzData.R")

n = 10000
data = createData(n)

task = makeClassifTask(id = "fizzbuzz", data = data, target = "y")


lrns = list(
  makeLearner("classif.ranger"),
  makeLearner(id = "xg1000", "classif.xgboost", nrounds = 1000),
  makeLearner(id = "xg200", "classif.xgboost", nrounds = 200),
  makeLearner("classif.svm", cost = 0.341, 
             gamma = 0.00246), #Pars don't seem to matter at all
  makeLearner("classif.nnet", size = 10),
  makeLearner("classif.h2o.deeplearning",
              activation = "Rectifier",
              hidden = c(200, 200),
              epochs = 10,
              train_samples_per_iteration = -1)
)

rdesc = makeResampleDesc("CV", iters = 10, stratify = TRUE)

res = benchmark(lrns, task, cv10, measures = mmce)

save(res, file = "result.RData")

major_class = max(table(data$y))/sum(table(data$y))

plotBMRBoxplots(res) + geom_hline(yintercept = major_class)
ggsave("result.png")

