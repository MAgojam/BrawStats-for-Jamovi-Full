
# This file is a generated template, your changes will not be overwritten

BrawLMClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "BrawLMClass",
    inherit = BrawLMBase,
    private = list(
      .init = function() {
        # initialization code 
        
        setBrawOpts(reducedOutput=TRUE,reportHTML=TRUE,
                 fontScale=1.5,fullGraphSize=0.5,
                 autoPrint=FALSE
                 )
      },
      
      .run = function() {

        if (is.null(self$options$IV) || is.null(self$options$DV)) {
          self$results$lmGraph$setState(NULL)
          self$results$lmReport$setState(NULL)
          return()
        }
        
          dataFull<-prepareSample(self$data)
          data<-dataFull$data[c("participant",self$options$DV,self$options$IV)]

          result<-generalAnalysis(data,InteractionOn=FALSE)
          lm<-list(result=result,DV=list(name=self$options$DV),IVs=list(name=self$options$IV))
          setBrawRes("lm",lm)
          
          self$results$lmGraph$setState(c("LM",self$options$whichR))
          outputText<-reportGLM(lm,p_or_r=self$options$inferWhich)
          self$results$lmReport$setContent(outputText)
          
      },
      
      
      .lmPlotGraph=function(image, ...) {
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
                 "LM" =outputGraph<-plotGLM(braw.res$lm,image$state[2]),
                 "SEM" =outputGraph<-plotPathModel(braw.res$sem)
          )
          print(outputGraph)
          return(TRUE)
        } else {
          return(FALSE)
        }
      }
    )
)
