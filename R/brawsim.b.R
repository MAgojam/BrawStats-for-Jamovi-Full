
# This file is a generated template, your changes will not be overwritten
# label: '5. <span style="color:#1276b9;"><b>Real Differences:</b></span> when should replication fail?'


BrawSimClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "BrawSimClass",
  inherit = BrawSimBase,
  private = list(
    .init = function() {
      # initialization code 
    },
    
    .run = function() {
      a<-R.Version()$version.string
      rVersion<-as.numeric(regmatches(a,gregexpr("[0-9]*\\.[0-9]*",a))[[1]][1])
      if (rVersion>=4.5) Jamovi<-2.7 else Jamovi<-2.6
      
      # debug information
      on.exit(if (!is.null(braw.res$debug)) {self$results$debug$setContent(braw.res$debug);self$results$debug$setVisible(TRUE)}
      )
      
      showHelp<-"Key" # or "Help"

      # initialization code here
      if (is.null(braw.res$statusStore)) {

        setBrawOpts(fullOutput=0,reportHTML=TRUE,
                    fullGraphSize=0.5,
                    npointsMax=501,
                    timeLimit=2,
                    autoShow=FALSE,
                    autoPrint=FALSE
        )
        setBrawEnv("graphicsType","HTML")
        
        basicsResults<-emptyPlot("Basics",useHelp=FALSE)
        metaSciResults<-emptyPlot("MetaScience",useHelp=FALSE)
        simResults<-emptyPlot("Simulation",useHelp=FALSE)

        statusStore<-list(lastOutput="System",
                          simResults=simResults,
                          metaSciResults=metaSciResults,
                          basicsResults=basicsResults,
                          showSampleType="Blank",
                          showInferParam="Basic",
                          showInferDimension="1D",
                          showMultipleParam="Basic",
                          showMultipleDimension="1D",
                          whichShowMultipleOut="all",
                          showExploreParam="Basic",
                          showExploreStyle="stats",
                          whichShowExploreOut="all",
                          doBasics=4,
                          showPlan=TRUE,
                          nestedHelp=TRUE,
                          startHelpWhich=0,
                          basicsHelpWhich=c(0,0),
                          metaSciHelpWhich=0,
                          simHelpWhich=0,
                          openJamovi=0,
                          topMode=self$options$topMode,
                          planMode=self$options$planMode,
                          exploreMode=self$options$exploreMode,
                          nrowTableLM=1,
                          nrowTableSEM=1,
                          counter=c()
        )
        simHistory<-list(
          history=NULL,
          historyData=NULL,
          historyOptions=NULL,
          historyPlace=0
        )
        setBrawRes("simSingle",nullPlot())
        setBrawRes("simMultiple",nullPlot())
        setBrawRes("simExplore",nullPlot())
        
        self$results$simGraphHTML$setContent(statusStore$simResults)
        setBrawRes("statusStore",statusStore)
        return()
      }

      # nothing to do?
      if (is.element(self$options$topMode,c("LearnHelp","Settings"))) {
        return()
      }

      statusStore<-braw.res$statusStore
      

## make all the standard things we need
      {
        # save the previous set up
        oldH<-braw.def$hypothesis
        oldD<-braw.def$design
        oldE<-braw.def$evidence
        oldX<-braw.def$explore
        oldM<-braw.def$metaAnalysis
        # get the new set up
        setBraw(self)

        # anything important changed?
        changedH<- !identical(oldH,braw.def$hypothesis)
        changedD<- !identical(oldD,braw.def$design)
        changedE<- !identical(oldE,braw.def$evidence)
        changedX<- !identical(oldX,braw.def$explore)
        changedM<- !identical(oldM,braw.def$metaAnalysis)
        changedMsource<-(oldM$nstudies!=braw.def$metaAnalysis$nstudies 
                         || oldM$sourceBias!=braw.def$metaAnalysis$sourceBias)
      }
      
## now set up help/instructions
      # this is done after we have set up the hypothesis
      self$results$simSystemHTML$setContent('')
      if (self$options$brawHelp) {
        if (showHelp=="Key") {
          simHelp<-BrawInstructions("Key")
        } else {
          simHelp<-brawSimHelp(indent=100)
        }
      } else {
        simHelp<-NULL
      }

## ignore changes in the ModeSelectors
      if(self$options$planMode!=statusStore$planMode
           || self$options$exploreMode!=statusStore$exploreMode) {
          statusStore$planMode<-self$options$planMode
          statusStore$exploreMode<-self$options$exploreMode
          setBrawRes("statusStore",statusStore)
          return()
        }

      
## proceed to actions

      # we are going back or forwards in the history
      simHistory<-braw.res$simHistoryStore
      # at this stage, we assume nothing new for the history
      updateHistoryNow<-FALSE
      addHistory<-FALSE
      if (self$options$simGoBack || self$options$simGoForwards) {
        h<-readHistory(simHistory,self$options$simGoBack)
        outputNow<-h$outputNow
        historyOptions<-h$historyOptions
        simHistory<-h$history
        
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
        
      }
      
      # we are doing something new
      if (!self$options$simGoBack && !self$options$simGoForwards) {
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
        numberSamples<-self$options$numberSamples

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
        
        # unless we have done something, we will make the same output as last time
        outputNow<-NULL
        # are we just asking for a different display of the current explore?
        if (!is.null(braw.res$explore) && statusStore$lastOutput=="Explore") {
          if (showExploreParam != statusStore$showExploreParam ||
              showExploreStyle != statusStore$showExploreStyle ||
              whichShowExploreOut != statusStore$whichShowExploreOut)
            outputNow<-"Explore"
        }
        # or multiple?
        if (!is.null(braw.res$multiple) && statusStore$lastOutput=="Multiple") {
          if (showMultipleParam != statusStore$showMultipleParam ||
              showMultipleDimension != statusStore$showInferDimension || 
              whichShowMultipleOut != statusStore$whichShowMultipleOut)
            outputNow<-"Multiple"
        }
        # or result?
        if (!is.null(braw.res$result) && is.element(statusStore$lastOutput,c("Basic","Sample","Describe","Infer","Variables","Likelihood"))) {
          if (showInferParam != statusStore$showInferParam ||
              showInferDimension != statusStore$showInferDimension)
            outputNow<-"Infer"
          if (showSampleType != statusStore$showSampleType)
            outputNow<-showSampleType
          # are we asking for a different analysis?
          if (changedE) {
            h1<-braw.def$hypothesis$IV2$name
            a<-doAnalysis(sample=braw.res$result)
            h2<-braw.res$result$hypothesis$IV2$name
            setBrawRes("result",a)
            addHistory<-TRUE
            updateHistoryNow<-TRUE
            outputNow<-showSampleType
          }
          # or metaAnalysis?
          if (!is.null(braw.res$metaSingle) && statusStore$lastOutput=="MetaSingle") {
            # same data new analysis
            if (!changedMsource) {
            doMetaAnalysis(braw.res$metaSingle,keepStudies=TRUE)
            addHistory<-TRUE
            updateHistoryNow<-TRUE
            outputNow<-"MetaSingle"
            }
          }
        }
        
        if (is.null(outputNow)) {
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
          if (changedE) {
            setBrawRes("multiple",NULL)
            setBrawRes("explore",NULL)
            setBrawRes("metaAnalysis",NULL)
            setBrawRes("metaMultiple",NULL)
          }
          if (changedM) {
            setBrawRes("metaMultiple",NULL)
            setBrawRes("metaSingle",NULL)
            if (statusStore$lastOutput=="Explore" && self$options$MetaAnalysisOn)
              setBrawRes("explore",NULL)
          }
        }
        
        # in theory this blanks the screen while the new display is being calculated
        # in practice it is all too fast
        # if (!self$options$stopBtn)
        # if (any(c(makeSampleNow,
        #           makeMultipleNow && statusStore$lastOutput!="Multiple",
        #           makeExploreNow && statusStore$lastOutput!="Explore"
        #           ))) {
        #   nullResults<-emptyPlot(self$options$topMode)
        #   self$results$simGraphHTML$setContent(nullResults)
        #   private$.checkpoint()
        # }
        
        # now we start doing new things
        # did we ask for a new sample?
        if (makeSampleNow) {
          # make a sample - either straight sample or single metaAnalysis
          if (self$options$MetaAnalysisOn) {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$metaSingle) || is.element(statusStore$lastOutput,c("MetaSingle","metaSci"))) {
            oldTimeLimit<-braw.env$timeLimit
            setBrawEnv("timeLimit",Inf)
            mA<-doMetaAnalysis(NULL)
            
            setBrawEnv("timeLimit",oldTimeLimit)
              addHistory<-TRUE
              updateHistoryNow<-TRUE
              # }
            outputNow<-"MetaSingle"
          } else {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$result) || is.element(statusStore$lastOutput,c(showSampleType,"metaSci"))) {
              doSingle()
              addHistory<-TRUE
              updateHistoryNow<-TRUE
              # }
            if (showSampleType=="Likelihood") doPossible(possible)
            outputNow<-showSampleType
            updateHistoryNow<-TRUE
          }
        }

        # did we ask for new multiples?
        if (makeMultipleNow) {
          if (self$options$MetaAnalysisOn) {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$metaMultiple) || is.element(statusStore$lastOutput,c("MetaMultiple","metaSci"))) {
              doMetaMultiple(numberSamples,braw.res$metaMultiple)
              addHistory<-TRUE
              updateHistoryNow<-TRUE
              # }
            outputNow<-"MetaMultiple"
          } else {
            setBrawRes("debug",c())
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$multiple) || is.element(statusStore$lastOutput,c("Multiple"))) {
            ns<-ceiling(max(0,numberSamples/10))
            if (changedH || changedD || is.null(braw.res$multiple)) targetN<-numberSamples
            else targetN<-braw.res$multiple$count+numberSamples
            while (is.null(braw.res$multiple) || braw.res$multiple$count<targetN) {
              doMultiple(nsims=ns,multipleResult=braw.res$multiple)
              
              setBrawEnv("graphicsType","HTML")
              svgBox(height=350,aspect=1.5,fontScale=1.2)
              simMultiple<-paste0(showMultiple(showType=showMultipleParam,dimension=showMultipleDimension,effectType=whichShowMultipleOut,orientation=showMultipleOrient),
                                  reportMultiple(showType=showMultipleParam,effectType=whichShowMultipleOut,reportStats=self$options$reportInferStats),
                                  ''
              )
              setBrawRes("simMultiple",simMultiple)
              open<-2
              tabs<-c("Plan","Single","Multiple","Explore")
              tabContents<-c(showPlan(),braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore)
              if (!is.null(simHelp)) {
                tabs<-c(tabs,showHelp)
                tabContents<-c(tabContents,simHelp)
              }
              simResults<-generate_tab(
                title="Simulation:",
                plainTabs=TRUE,
                titleWidth=100,
                width=600,
                tabs=tabs,
                tabContents=tabContents,
                open=open+1
              )
              self$results$simGraphHTML$setContent(simResults)
              statusStore$simResults<-simResults
              setBrawRes("statusStore",statusStore)
              private$.checkpoint()
              if (self$options$stopBtn) break
            }
            if (statusStore$lastOutput!="Multiple" || changedH || changedD || changedE) addHistory<-TRUE
            updateHistoryNow<-TRUE
            # } 
            outputNow<-"Multiple"
          }
        }
        
        # did we ask for new explore?
        if (makeExploreNow) {
          numberExplores<-self$options$numberExplores
          # # do we need to do this, or are we just returning to the existing one?
          # if (is.null(braw.res$explore) || is.element(statusStore$lastOutput,c("Explore","metaSci"))) {
          ns<-ceiling(max(2,numberExplores/10))
          if (is.null(braw.res$explore$count)) targetN<-numberExplores
          else targetN<-braw.res$explore$count+numberExplores
          while (is.null(braw.res$explore$count) || (braw.res$explore$count<targetN)) {
            ns<-min(targetN-braw.res$explore$count,ns)
            exploreResult<-doExplore(nsims=ns,exploreResult=braw.res$explore,
                                     doingMetaAnalysis=self$options$MetaAnalysisOn)
            
            svgBox(height=350,aspect=1.5,fontScale=1.2)
            setBrawEnv("graphicsType","HTML")
              simExplore<-paste0(showExplore(showType=showExploreParam,showHist=(showExploreStyle=="hist"),effectType=whichShowExploreOut),
                                 reportExplore(showType=showExploreParam,effectType=whichShowExploreOut,reportStats=self$options$reportInferStats)
              )
              setBrawRes('simExplore',simExplore)
              open<-3
              tabs<-c("Plan","Single","Multiple","Explore")
              tabContents<-c(showPlan(),braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore)
              if (!is.null(simHelp)) {
                tabs<-c(tabs,showHelp)
                tabContents<-c(tabContents,simHelp)
              }
              simResults<-generate_tab(
                title="Simulation:",
                plainTabs=TRUE,
                titleWidth=100,
                width=600,
                tabs=tabs,
                tabContents=tabContents,
                open=open+1
              )
              self$results$simGraphHTML$setContent(simResults)
              statusStore$simResults<-simResults
              setBrawRes("statusStore",statusStore)
              private$.checkpoint()
              if (self$options$stopBtn) break
          }
            if (statusStore$lastOutput!="Explore" || changedH || changedD || changedE || changedX) addHistory<-TRUE
            updateHistoryNow<-TRUE
            # }
          outputNow<-"Explore"
        }
      }
      
      # what are we showing?
      # main results graphs/reports
      if (is.null(outputNow) && (changedH || changedD))  {outputNow<-"Plan";open<-0}

      if (!is.null(outputNow))  {
          svgBox(height=350,aspect=1.5,fontScale=1.2)
          setBrawEnv("graphicsType","HTML")
          if (is.element(outputNow,c("Basic","Variables","Sample","Describe","Infer","Likelihood","MetaSingle"))) {
            switch(outputNow,
                   "Basic"= simSingle<-paste0(showDescription(),reportInference()),
                   "Variables" = simSingle<-paste0(showMarginals(style="all"),reportSample()),
                   "Sample"= simSingle<-paste0(showSample(),reportSample()),
                   "Describe"= simSingle<-paste0(showDescription(),reportDescription()),
                   "Infer"= simSingle<-paste0(showInference(showType=showInferParam,dimension=showInferDimension),reportInference()),
                   "Likelihood"=simSingle<-paste0(showPossible(showType=self$options$likelihoodType,cutaway=(self$options$likelihoodCutaway=="cutaway")),reportLikelihood()),
                   "MetaSingle"  =simSingle<-paste0(showMetaSingle(),reportMetaSingle())
            )
            setBrawRes("simSingle",simSingle)
            open<-1
          }
          if (is.element(outputNow,c("MetaMultiple","Multiple"))) {
            switch(outputNow,
                   "MetaMultiple"  =simMultiple<-paste0(showMetaMultiple(showType=showMetaParam,dimension=showMetaDimension),reportMetaMultiple()),
                   "Multiple"      =simMultiple<-paste0(showMultiple(showType=showMultipleParam,dimension=showMultipleDimension,effectType=whichShowMultipleOut,orientation=showMultipleOrient),
                                                   reportMultiple(showType=showMultipleParam,effectType=whichShowMultipleOut,reportStats=self$options$reportInferStats)
                   )
            )
            setBrawRes("simMultiple",simMultiple)
            open<-2
          }
          if (is.element(outputNow,c("Explore"))) {
            simExplore<-paste0(showExplore(showType=showExploreParam,showHist=(showExploreStyle=="hist"),effectType=whichShowExploreOut),
                                          reportExplore(showType=showExploreParam,effectType=whichShowExploreOut,reportStats=self$options$reportInferStats)
            )
            setBrawRes("simExplore",simExplore)
            open<-3
          }
          tabs<-c("Plan","Single","Multiple","Explore")
          tabContents<-c(showPlan(),braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore)
          if (!is.null(simHelp)) {
            tabs<-c(tabs,showHelp)
            tabContents<-c(tabContents,simHelp)
          }
          simResults<-generate_tab(
            title="Simulation:",
            plainTabs=TRUE,
            titleWidth=100,
            width=600,
            tabs=tabs,
            tabContents=tabContents,
            open=open+1
          )
          self$results$simGraphHTML$setContent(simResults)
          statusStore$simResults<-simResults
      }
      
      if (!is.null(braw.res$debug)) {
        self$results$debug$setContent(braw.res$debug)
        self$results$debug$setVisible(TRUE)
      }
      
      # update statusStore
      {
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
      setBrawRes("statusStore",statusStore)
      }
      
      # update history
      if (updateHistoryNow) {
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
        simHistory<-updateHistory(simHistory,historyOptions,outputNow,addHistory)
      }
      setBrawRes("simHistoryStore",simHistory)

      # now we save any results to the Jamovi spreadsheet
      sendData2Jamovi(outputNow,"Simulation",self)

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
                                                     effectType=image$state[4])
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
