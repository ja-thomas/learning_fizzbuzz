library(devtools)
load_all("../mlr/")


source("createFizzbuzzData.R")

n = 10000


task = makeClassifTask(data = createData(n), target = "y")


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

res = benchmark(lrns, task, cv10, measures = acc)




