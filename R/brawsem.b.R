
# This file is a generated template, your changes will not be overwritten

BrawSEMClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "BrawSEMClass",
    inherit = BrawSEMBase,
    private = list(
      .init = function() {
        # initialization code 

          setBrawOpts(reducedOutput=TRUE,reportHTML=TRUE,
                      fontScale=1.5,fullGraphSize=0.5,
                      autoPrint=FALSE
          )

      },
      
      .run = function() {

        if (self$options$clearHistory) {
          setBrawRes("historySEM",NULL)
          return()  
        }
        
        stages<-list()
        rawStages<-list(self$options$Stage1,
                     self$options$Stage2,
                     self$options$Stage3,
                     self$options$Stage4,
                     self$options$Stage5)
        rawStagesOn<-c(self$options$Stage1On,
                       self$options$Stage2On,
                       self$options$Stage3On,
                       self$options$Stage4On,
                       self$options$Stage5On)
        if (self$options$causalDirection=="up") {
          rawStages<-rev(rawStages)
          rawStagesOn<-rev(rawStagesOn)
        }
        for (ist in 1:length(rawStages)) {
          stage<-rawStages[[ist]]
          if (!is.null(stage) && rawStagesOn[ist]) {
            stages<-c(stages,list(stage))
          }
        }
# self$results$debug$setContent(stages)
# self$results$debug$setVisible(TRUE)
# return()
        
        addSource<-self$options$addSource
        addDest<-self$options$addDest
        add<-list()
        nAdd<-min(length(addSource),length(addDest))
        if (nAdd>0) {
          for (i in 1:nAdd) {
            thisAdd<-list(c(addSource[i],addDest[i]))
            add<-c(add,thisAdd)
          }
        }

        removeSource<-self$options$removeSource
        removeDest<-self$options$removeDest
        remove<-list()
        nRemove<-min(length(removeSource),length(removeDest))
        if (nRemove>0){
          for (i in 1:nRemove){
            thisRemove<-list(c(removeSource[i],removeDest[i]))
            remove<-c(remove,thisRemove)
          }
        }
        pathmodel<-list(path=
                   list(
                        stages=stages,
                        depth=self$options$Depth,
                        only_ivs=self$options$onlySource,
                        only_dvs=self$options$onlyDest,
                        within_stage=0,
                        add=add,
                        remove=remove
                   )
        )

        if (length(stages)<=1) {
          self$results$semGraph$setState(NULL)
          self$results$reportSEM$setState(NULL)
          return()
        }
        
        dataFull<-prepareSample(self$data)
        liveData<-dataFull$data[,2:ncol(dataFull$data)]
        if (ncol(dataFull$data)==2) liveData<-matrix(liveData,ncol=ncol(dataFull$data)-1)

        model_data<-list(pid=1:length(dataFull$data[,1]),
                         data=liveData,
                         varnames=dataFull$variables$name,
                         varcat=dataFull$variables$type=="Categorical"
        )

        sem<-fit_sem_model(pathmodel,model_data)
        setBrawRes("sem",sem)
        
        self$results$semGraph$setState("SEM")
        outputReport<-reportSEMModel(sem,self$options$ShowType,TRUE)
        self$results$reportSEM$setContent(outputReport)
        
        },


      .semPlotGraph=function(image, ...) {
        outputGraph <- image$state[1]
        if (!is.null(outputGraph)) {
          switch(outputGraph,
                 "System"    =outputGraph<-showSystem(),
                 "Hypothesis"=outputGraph<-showHypothesis(),
                 "Design"    =outputGraph<-showDesign(),
                 "Population"=outputGraph<-showPopulation(),
                 "Prediction"=outputGraph<-showPrediction(),
                 "Sample"    =outputGraph<-showMarginals(style="unsorted"),
                 "Describe"  =outputGraph<-showDescription(),
                 "Infer"     =outputGraph<-showInference(showType=image$state[2],dimension=image$state[3]),
                 "Likelihood"=outputGraph<-showPossible(showType=image$state[2],cutaway=as.logical(image$state[3])),
                 "Multiple"  =outputGraph<-showMultiple(showType=image$state[2],dimension=image$state[3],effectType=image$state[4]),
                 "MetaSingle"  =outputGraph<-showMetaSingle(),
                 "MetaMultiple"  =outputGraph<-showMetaMultiple(),
                 "Explore"   =outputGraph<-showExplore(showType=image$state[2],dimension=image$state[3],effectType=image$state[4]),
                 "LM" =outputGraph<-plotGLM(lm,image$state[2]),
                 "SEM" =outputGraph<-plotSEMModel(braw.res$sem)
          )
          print(outputGraph)
          return(TRUE)
        } else {
          return(FALSE)
        }
      }
    )
)
