library(mlr)


lrn = makeLearner("classif.svm")
ps = makeParamSet(
  makeNumericParam("cost", -15, 15, trafo = function(x) 2^x),
  makeNumericParam("gamma", -15, 15, trafo = function(x) 2^x))


ctrl = makeTuneControlRandom()

rs = makeResampleDesc("Holdout")

rs = tuneParams(learner = lrn, task = task, par.set = ps,
                resampling = rs, control = ctrl, measures = acc)
