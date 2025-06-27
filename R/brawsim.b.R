
# This file is a generated template, your changes will not be overwritten

BrawSimClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "BrawSimClass",
  inherit = BrawSimBase,
  private = list(
    .init = function() {
      # initialization code 
    },
    
    .run = function() {
      # debug information
      
      # self$results$debug$setContent(braw.res)
      # self$results$debug$setVisible(TRUE)
      # return()

      # initialization code here
      if (is.null(braw.res$statusStore)) {
        self$results$SystemHTML$setVisible(FALSE)
        
        setBrawOpts(reducedOutput=TRUE,reportHTML=TRUE,
                    fontScale=1.5,fullGraphSize=0.5,
                    autoPrint=FALSE
        )
        statusStore<-list(lastOutput="System",
                          showSampleType="Variables",
                          showInferParam="Basic",
                          showInferDimension="1D",
                          showMultipleParam="Basic",
                          showMultipleDimension="1D",
                          whichShowMultipleOut="all",
                          showExploreParam="Basic",
                          showExploreStyle="stats",
                          whichShowExploreOut="all",
                          doDemos=4,
                          nestedHelp=TRUE,
                          basicHelpWhich=0,
                          demoHelpWhich=c(0,0),
                          simHelpWhich=0,
                          openJamovi=0,
                          planMode="planH",
                          learnMode="LearnHelp",
                          exploreMode="Design",
                          nrowTableLM=1,
                          nrowTableSEM=1
        )
        history<-list(
          history=NULL,
          historyData=NULL,
          historyOptions=NULL,
          historyPlace=0
        )
        
      } else {
        statusStore<-braw.res$statusStore
        history<-braw.res$historyStore
      }
      
      # check which results are visible
      if (self$options$showHTML) {
        if (self$results$simGraph$visible) self$results$simGraph$setVisible(FALSE)
        if (self$results$simReport$visible) self$results$simReport$setVisible(FALSE)
        if (!self$results$simGraphHTML$visible) self$results$simGraphHTML$setVisible(TRUE)
      } else {
        if (self$results$simGraphHTML$visible) self$results$simGraphHTML$setVisible(FALSE)
        if (!self$results$simGraph$visible) self$results$simGraph$setVisible(TRUE)
        if (!self$results$simReport$visible) self$results$simReport$setVisible(TRUE)
      }
      
      # ignore changes in the ModeSelectors
      if (self$options$learnMode!=statusStore$learnMode) {
        statusStore$learnMode<-self$options$learnMode
        setBrawRes("statusStore",statusStore)
        setBrawRes("historyStore",history)
        return()
      }
      if (self$options$planMode!=statusStore$planMode) {
        statusStore$planMode<-self$options$planMode
        setBrawRes("statusStore",statusStore)
        setBrawRes("historyStore",history)
        return()
      }
      if (self$options$exploreMode!=statusStore$exploreMode) {
        statusStore$exploreMode<-self$options$exploreMode
        setBrawRes("statusStore",statusStore)
        setBrawRes("historyStore",history)
        return()
      }
      
      # get which tabs are open in help structure
      statusStore<-whichTabsOpen(self,statusStore)
      
      # save the existing definitions
      oldH<-braw.def$hypothesis
      oldD<-braw.def$design
      oldE<-braw.def$evidence
      oldX<-braw.def$explore
      oldM<-braw.def$metaAnalysis
      
      # make all the standard things we need
      # store the option variables inside the braw package
      setBraw(self)
      
      changedH<- !identical(oldH,braw.def$hypothesis)
      changedD<- !identical(oldD,braw.def$design)
      changedE<- !identical(oldE,braw.def$evidence)
      changedX<- !identical(oldX,braw.def$explore)
      changedM<- !identical(oldM,braw.def$metaAnalysis)
      
      # now set up help/instructions
      # this is done after we have set up the hypothesis
      helpOutput<-makeHelpOut(self,statusStore)
      systemHTML<-makeSystemOut(self,statusStore,changedH,changedD,changedE,helpOutput)

      if (nchar(systemHTML)>0) {
        self$results$BrawStatsInstructions$setContent(systemHTML)
        if (!self$results$BrawStatsInstructions$visible) 
          self$results$BrawStatsInstructions$setVisible(TRUE)
      } else {
        if (self$results$BrawStatsInstructions$visible)  
          self$results$BrawStatsInstructions$setVisible(FALSE)
      }
      
      # we are going back or forwards in the history
      if (self$options$goBack || self$options$goForwards) { 
        nhist<-length(history$history)
        if (self$options$goBack) history$historyPlace<-max(history$historyPlace-1,1)
        if (self$options$goForwards) history$historyPlace<-min(history$historyPlace+1,nhist)

        outputNow<-history$history[history$historyPlace]
        
        historyOptions<-history$historyOptions[[history$historyPlace]]
        showSampleType<-historyOptions$showSampleType
        showInferParam<-historyOptions$showInferParam
        showInferDimension<-historyOptions$showInferDimension
        showMultipleParam<-historyOptions$showMultipleParam
        showMultipleOrient<-historyOptions$showMultipleOrient
        showMultipleDimension<-historyOptions$showMultipleDimension
        whichShowMultipleOut<-historyOptions$whichShowMultipleOut
        showExploreParam<-historyOptions$showExploreParam
        showExploreStyle<-historyOptions$showExploreStyle
        whichShowExploreOut<-historyOptions$whichShowExploreOut
        
        setBrawRes("result",history$historyData[[history$historyPlace]]$result)
        setBrawRes("multiple",history$historyData[[history$historyPlace]]$multiple)
        setBrawRes("explore",history$historyData[[history$historyPlace]]$explore)
        setBrawRes("metaSingle",history$historyData[[history$historyPlace]]$metaSingle)
        setBrawRes("metaMultiple",history$historyData[[history$historyPlace]]$metaMultiple)
      }
      
      if (!self$options$goBack && !self$options$goForwards) {
        # unless we have done something, we will make the same output as last time
        outputNow<-NULL
        # at this stage, we assume nothing new for the history
        addHistory<-FALSE 
        
        # get some display parameters for later
        # single sample
        makeSampleNow<-self$options$makeSampleBtn
        showSampleType<-self$options$showSampleType
        showInferParam<-paste0(self$options$inferVar1,";",self$options$inferVar2)
        showInferDimension<-self$options$showInferDimension
        
        # multiple samples
        makeMultipleNow<-self$options$makeMultipleBtn
        showMultipleParam<-self$options$showMultipleParam
        if (is.element(showMultipleParam,c("Basic","Custom"))) {
          showMultipleParam<-paste0(self$options$inferVar1,";",self$options$inferVar2)
        } 
        if (is.element(showMultipleParam,c("Single"))) {
          showMultipleParam<-self$options$inferVar1
          showMultipleOrient<-"horz"
        } else showMultipleOrient<-"vert"
        showMultipleDimension<-self$options$showMultipleDimension
        whichShowMultipleOut<-self$options$whichShowMultiple
        
        # explore
        makeExploreNow<-self$options$makeExploreBtn
        showExploreParam<-self$options$showExploreParam
        if (is.element(showExploreParam,c("Single"))) {
          showExploreParam<-self$options$inferVar1
        } 
        if (is.element(showExploreParam,c("Basic","Custom"))) {
          showExploreParam<-paste0(self$options$inferVar1,";",self$options$inferVar2)
        } 
        showExploreStyle<-self$options$showExploreStyle
        whichShowExploreOut<-self$options$whichShowMultiple
        
        # metaAnalysis 
        showMetaParam<-paste0(self$options$metaVar1,";",self$options$metaVar2)
        showMetaDimension<-self$options$showMultipleDimension
        
        # are we just asking for a different display of the current explore?
        if (!self$options$showHTML && !is.null(braw.res$explore) && statusStore$lastOutput=="Explore") {
          if (showExploreParam != statusStore$showExploreParam ||
              showExploreStyle != statusStore$showExploreStyle ||
              whichShowExploreOut != statusStore$whichShowExploreOut)
            outputNow<-"Explore"
        }
        # or multiple?
        if (!self$options$showHTML && !is.null(braw.res$multiple) && statusStore$lastOutput=="Multiple") {
          if (showMultipleParam != statusStore$showMultipleParam ||
              showMultipleDimension != statusStore$showInferDimension || 
              whichShowMultipleOut != statusStore$whichShowMultipleOut)
            outputNow<-"Multiple"
        }
        # or result?
        if (!self$options$showHTML && !is.null(braw.res$result) && is.element(statusStore$lastOutput,c("Basic","Sample","Describe","Infer","Variables","Likelihood"))) {
          if (showInferParam != statusStore$showInferParam ||
              showInferDimension != statusStore$showInferDimension)
            outputNow<-"Infer"
          if (showSampleType != statusStore$showSampleType)
            outputNow<-showSampleType
        }
        
        # are any of the existing stored results now invalid?
        if (changedH || changedD) {
          setBrawRes("result",NULL)
          setBrawRes("multiple",NULL)
          setBrawRes("explore",NULL)
          setBrawRes("metaAnalysis",NULL)
          setBrawRes("metaMultiple",NULL)
          outputNow<-NULL
        }
        if (changedX) {
          setBrawRes("explore",NULL)
        }
        # are any of the existing stored results needing new analysis?
        if (changedE) {
          setBrawRes("multiple",NULL)
          setBrawRes("explore",NULL)
          setBrawRes("metaAnalysis",NULL)
          setBrawRes("metaMultiple",NULL)
          if (!is.null(braw.res$result) && is.element(statusStore$lastOutput,c("Basic","Sample","Describe","Infer","Variables","Likelihood"))) {
            setBrawRes("result",doAnalysis(sample=braw.res$result))
            addHistory<-TRUE
            outputNow<-showSampleType
          }
        }
        if (changedM) {
          setBrawRes("metaMultiple",NULL)
          changedMsource<-(oldM$nstudies!=braw.def$metaAnalysis$nstudies 
                           || oldM$sourceBias!=braw.def$metaAnalysis$sourceBias)
          if (changedMsource) {
            setBrawRes("metaSingle",NULL)
          }
          if (statusStore$lastOutput=="MetaSingle" && !changedMsource) {
            # same data new analsis
            braw.res$metaSingle<-doMetaAnalysis(braw.res$metaSingle,keepStudies=TRUE)
            addHistory<-TRUE
            outputNow<-"MetaSingle"
          }
          if (statusStore$lastOutput=="Explore" && self$options$MetaAnalysisOn)
            setBrawRes("explore",NULL)
        }

        # now we start doing new things
        # did we ask for a new sample?
        if (makeSampleNow) {
          # make a sample - either striaght sample or single metaAnalysis
          if (self$options$MetaAnalysisOn) {
            # do we need to do this, or are we just returning to the existing one?
            if (self$options$showHTML || is.null(braw.res$metaSingle) || statusStore$lastOutput=="MetaSingle") {
              doMetaAnalysis(NULL)
              addHistory<-TRUE
            }
            outputNow<-"MetaSingle"
          } else {
            # do we need to do this, or are we just returning to the existing one?
            if (self$options$showHTML || is.null(braw.res$result) || statusStore$lastOutput==showSampleType) {
              doSingle()
              addHistory<-TRUE
            }
            outputNow<-showSampleType
          }
        }
        
        # did we ask for new multiples?
        if (makeMultipleNow) {
          numberSamples<-self$options$numberSamples
          if (self$options$MetaAnalysisOn) {
            # do we need to do this, or are we just returning to the existing one?
            if (self$options$showHTML || is.null(braw.res$metaMultiple) || statusStore$lastOutput=="MetaMultiple") 
              doMetaMultiple(numberSamples,braw.res$metaMultiple)
            outputNow<-"MetaMultiple"
          } else {
            # do we need to do this, or are we just returning to the existing one?
            if (is.null(braw.res$multiple) || statusStore$lastOutput=="Multiple") {
              doMultiple(nsims=numberSamples,multipleResult=braw.res$multiple)
              if (self$options$showHTML || statusStore$lastOutput!="Multiple" || changedH || changedD || changedE) addHistory<-TRUE
            } 
            outputNow<-"Multiple"
          }
        }
        
        # did we ask for new explore?
        if (makeExploreNow) {
          numberExplores<-self$options$numberExplores
          # do we need to do this, or are we just returning to the existing one?
          if (self$options$showHTML || is.null(braw.res$explore) || statusStore$lastOutput=="Explore") {
            exploreResult<-doExplore(nsims=numberExplores,exploreResult=braw.res$explore,
                                     doingMetaAnalysis=self$options$MetaAnalysisOn)
            if (statusStore$lastOutput!="Explore" || changedH || changedD || changedE || changedX) addHistory<-TRUE
          }
          outputNow<-"Explore"
        }
      } 
      
      # what are we showing?
      # main results graphs/reports
      if (!is.null(outputNow))  {
        
        if (outputNow=="Likelihood") {
          possible<-makePossible(UsePrior=self$options$likelihoodUsePrior,
                                 prior=makeWorld(worldOn=TRUE,
                                                 populationPDF=self$options$priorPDF,
                                                 populationRZ=self$options$priorRZ,
                                                 populationPDFk=self$options$priorLambda,
                                                 populationNullp=self$options$priorNullP)
          )
          possibleResult<-doPossible(possible)
          likelihoodCutaway<-(self$options$likelihoodCutaway=="cutaway")
        }
        
        if (self$options$showHTML) {
          svgBox(height=350,aspect=1.5)
          setBrawEnv("graphicsType","HTML")
          if (!is.null(braw.res$result))
            switch(self$options$showSampleType,
                   "Basic"= graphSingle<-paste0(showDescription(),reportInference()),
                   "Variables" = graphSingle<-paste0(showMarginals(style="all"),reportSample()),
                   "Sample"= graphSingle<-paste0(showSample(),reportSample()),
                   "Describe"= graphSingle<-paste0(showDescription(),reportDescription()),
                   "Infer"= graphSingle<-paste0(showInference(showType=showInferParam,dimension=showInferDimension),reportInference()),
                   "Likelihood"=graphSingle<-paste0(showPossible(showType=self$options$likelihoodType,cutaway=likelihoodCutaway),reportLikelihood()),
                   "MetaSingle"  =graphSingle<-paste0(showMetaSingle(),reportMetaSingle()),
                   "MetaMultiple"  =graphSingle<-paste0(showMetaMultiple(showType=showMetaParam,dimension=showMetaDimension),reportMetaMultiple()),
            )
          else graphSingle<-nullPlot()
          if (!is.null(braw.res$multiple))
            graphMultiple<-paste0(showMultiple(showType=showMultipleParam,dimension=showMultipleDimension,effectType=whichShowMultipleOut),
                                  reportMultiple(showType=showMultipleParam,effectType=whichShowMultipleOut,reportStats=self$options$reportInferStats)
            )
          else graphMultiple<-nullPlot()
          if (!is.null(braw.res$explore))
            graphExplore<-paste0(showExplore(showType=showExploreParam,showHist=(showExploreStyle=="hist"),effectType=whichShowExploreOut),
                                 reportExplore(showType=showExploreParam,effectType=whichShowExploreOut,reportStats=self$options$reportInferStats)
            )
          else graphExplore<-nullPlot()
          switch(outputNow,
                 "System"= open<-0,
                 "Basic"= open<-1,
                 "Variables"= open<-1,
                 "Sample"= open<-1,
                 "Describe"= open<-1,
                 "Infer"= open<-1,
                 "Likelihood"=open<-1,
                 "Multiple"= open<-2,
                 "Explore"= open<-3,
                 {open<-0}
          )
            brawResults<-generate_tab(
              title="Results:",
              titleWidth=50,
              tabs=c("Single Sample","Multiple Samples","Explore"),
              tabContents = c(
                graphSingle,
                graphMultiple,
                graphExplore
              ),
              open=open
            )
            # self$results$debug$setContent(outputNow)
            # self$results$debug$setVisible(TRUE)
            
          self$results$simGraphHTML$setContent(brawResults)
        } else {
          
          switch(outputNow,
                 "System"= self$results$simGraph$setState(outputNow),
                 "Basic"= self$results$simGraph$setState("Describe"),
                 "Variables"= self$results$simGraph$setState(c(outputNow,"all")),
                 "Sample"= self$results$simGraph$setState(outputNow),
                 "Describe"= self$results$simGraph$setState(outputNow),
                 "Infer"= self$results$simGraph$setState(c(outputNow,showInferParam,showInferDimension)),
                 "Likelihood"= self$results$simGraph$setState(c(outputNow,self$options$likelihoodType,likelihoodCutaway)),
                 "Multiple"= self$results$simGraph$setState(c(outputNow,showMultipleParam,showMultipleDimension,whichShowMultipleOut,showMultipleOrient)),
                 "Explore"= self$results$simGraph$setState(c(outputNow,showExploreParam,(showExploreStyle=="hist"),whichShowExploreOut,!self$options$fixedAxes)),
                 "MetaSingle"  =self$results$simGraph$setState(outputNow),
                 "MetaMultiple"  =self$results$simGraph$setState(c(outputNow,showMetaParam,showMetaDimension)),
                 self$results$simGraph$setState(outputNow)
          )
          
          switch(outputNow,
                 "System"= self$results$simReport$setContent(reportPlot(NULL)),
                 "Basic"= self$results$simReport$setContent(reportInference()),
                 "Variables"= self$results$simReport$setContent(reportSample()),
                 "Sample"= self$results$simReport$setContent(reportSample()),
                 "Describe"= self$results$simReport$setContent(reportDescription()),
                 "Infer"= self$results$simReport$setContent(reportInference()),
                 "Likelihood"=self$results$simReport$setContent(reportLikelihood()),
                 "Multiple"= self$results$simReport$setContent(reportMultiple(showType=showMultipleParam,effectType=whichShowMultipleOut,reportStats=self$options$reportInferStats)),
                 "Explore"= self$results$simReport$setContent(reportExplore(showType=showExploreParam,reportStats=self$options$reportInferStats)),
                 "MetaSingle"  =self$results$simReport$setContent(reportMetaSingle()),
                 "MetaMultiple"  =self$results$simReport$setContent(reportMetaMultiple(reportStats=self$options$reportInferStats)),
                 self$results$simReport$setContent(reportPlot(NULL))
          )
        }
      } else {
        if (!self$options$showHTML) {
          # self$results$simReport$setContent(reportPlot(NULL))
          # self$results$simGraph$setVisible(FALSE)
        }
      }
      
      # save everything for the next round      
      statusStore$showSampleType<-showSampleType
      statusStore$showInferParam<-showInferParam
      statusStore$showInferDimension<-showInferDimension
      statusStore$showMultipleParam<-showMultipleParam
      statusStore$showMultipleDimension<-showMultipleDimension
      statusStore$whichShowMultipleOut<-whichShowMultipleOut
      statusStore$showExploreParam<-showExploreParam
      statusStore$showExploreStyle<-showExploreStyle
      statusStore$whichShowExploreOut<-whichShowExploreOut
      if (!is.null(outputNow))  statusStore$lastOutput<-outputNow
      
      if (!is.null(outputNow) && !self$options$goBack && !self$options$goForwards) {
        historyOptions<-list(showSampleType=showSampleType,
                             showInferParam=showInferParam,
                             showInferDimension=showInferDimension,
                             showMultipleParam=showMultipleParam,
                             showMultipleOrient=showMultipleOrient,
                             showMultipleDimension=showMultipleDimension,
                             whichShowMultipleOut=whichShowMultipleOut,
                             showExploreParam=showExploreParam,
                             showExploreStyle=showExploreStyle,
                             whichShowExploreOut=whichShowExploreOut
        )
        history<-updateHistory(history,historyOptions,outputNow,addHistory)
      }
      
      # now we save any results to the Jamovi spreadsheet
      # single result first
      if (self$options$sendSample && !is.null(braw.res$result)) {
        if (is.null(braw.def$hypothesis$IV2)) {
          newVariables<-data.frame(braw.res$result$participant,braw.res$result$dv,braw.res$result$iv,braw.res$result$dv+NA)
          names(newVariables)<-c("ID",braw.def$hypothesis$DV$name,braw.def$hypothesis$IV$name,"-")
        } else {
          newVariables<-data.frame(braw.res$result$participant,braw.res$result$dv,braw.res$result$iv,braw.res$result$iv2)
          names(newVariables)<-c("ID",braw.def$hypothesis$DV$name,braw.def$hypothesis$IV$name,braw.def$hypothesis$IV2$name)
        }
        
        keys<-1:length(newVariables)
        measureTypes<-sapply(newVariables,function(x) { if (is.character(x)) "Nominal" else "Continuous"})
        
        self$results$sendSample$set(keys=keys,titles=names(newVariables),
                                    descriptions=rep("simulated",length(newVariables)),
                                    measureTypes=measureTypes
        )
        self$results$sendSample$setValues(newVariables)
      }
      # then multiple result
      q<-NULL
      if (self$options$sendMultiple) {
        if (!is.null(outputNow) && outputNow=="MetaSingle") {
          q<-braw.res$metaSingle$result
        } 
        if (!is.null(outputNow) && outputNow=="Multiple") {
          q<-mergeMultiple(braw.res$multiple$result,braw.res$multiple$nullresult)
        }
        if (!is.null(q)) {
          newMultiple<-data.frame(q$rIV,q$nval+0.0,q$pIV)
          newMultiple<-newMultiple[!is.na(q$rIV),]
          names(newMultiple)<-c("rs","n","p")
          nvars<-ncol(newMultiple)
          
          keys<-1:nvars
          self$results$sendMultiple$set(keys=keys,titles=names(newMultiple),
                                        descriptions=rep("simulated",nvars),
                                        measureTypes=rep("Continuous",nvars)
          )
          self$results$sendMultiple$setValues(newMultiple)
        }
      }
      if (self$options$sendExplore && !is.null(outputNow) && outputNow=="Explore") {
        newExplore<-reportExplore(returnDataFrame=TRUE,showType=showExploreParam,reportStats=self$options$reportInferStats)
        nvars<-ncol(newExplore)
        
        keys<-1:nvars
        self$results$sendExplore$set(keys=keys,titles=names(newExplore),
                                     descriptions=rep("simulated",nvars),
                                     measureTypes=rep("Continuous",nvars)
        )
        self$results$sendExplore$setValues(newExplore)
      }
      
      setBrawRes("statusStore",statusStore)
      setBrawRes("historyStore",history)
      # end of .run()
    },
    
    .plotSimGraph=function(image, ...) {
      outputGraph <- image$state[1]
      if (!is.null(outputGraph)) {
        setBrawEnv("graphicsType","ggplot")
        switch(outputGraph,
               "System"    =outputGraph<-showSystem("all"),
               "Hypothesis"=outputGraph<-showSystem("hypothesis"),
               "Design"    =outputGraph<-showSystem("design"),
               "Population"=outputGraph<-showSystem("population"),
               "Prediction"=outputGraph<-showSystem("prediction"),
               "Variables"    =outputGraph<-showMarginals(style=image$state[2]),
               "Sample"    =outputGraph<-showSample(),
               "Describe"  =outputGraph<-showDescription(),
               "Infer"     =outputGraph<-showInference(showType=image$state[2],dimension=image$state[3]),
               "Likelihood"=outputGraph<-showPossible(showType=image$state[2],cutaway=as.logical(image$state[3])),
               "Multiple"  =outputGraph<-showMultiple(showType=image$state[2],dimension=image$state[3],effectType=image$state[4],orientation=image$state[5]),
               "MetaSingle"  =outputGraph<-showMetaSingle(),
               "MetaMultiple"  =outputGraph<-showMetaMultiple(showType=image$state[2],dimension=image$state[3]),
               "Explore"   =outputGraph<-showExplore(showType=image$state[2],
                                                     showHist=image$state[3],
                                                     effectType=image$state[4],
                                                     autoYlim=image$state[5])
        )
        print(outputGraph)
        return(TRUE)
      } else {
        return(FALSE)
      }
    },
    
    .plotReport=function(image, ...) {
      outputGraph <- image$state[1]
      if (!is.null(outputGraph)) {
        switch(outputGraph,
               "System"    =outputGraph<-reportTerms(),
               "Prediction"    =outputGraph<-reportTerms(),
               "Variables"    =outputGraph<-reportSample(),
               "Sample"    =outputGraph<-reportSample(),
               "Describe"  =outputGraph<-reportDescription(),
               "Infer"     =outputGraph<-reportInference(),
               "MetaSingle"  =outputGraph<-reportMetaSingle(),
               "MetaMultiple"  =outputGraph<-reportMetaMultiple(),
               "Multiple"  =outputGraph<-reportMultiple(showType=image$state[2],effectType=image$state[2]),
               "Explore"   =outputGraph<-reportExplore(showType=image$state[2])
        )
        print(outputGraph)
        return(TRUE)
      } else {
        return(FALSE)
      }
    }
  )
)
