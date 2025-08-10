
# This file is a generated template, your changes will not be overwritten

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
      # self$results$debug$setContent(c("start",length(braw.res$multiple$result$rIV)))
      # self$results$debug$setVisible(TRUE)
      # return()

      firstRun<-FALSE
      # at this stage, we assume nothing new for the history
      updateHistoryNow<-FALSE
      addHistory<-FALSE
      # initialization code here
      if (is.null(braw.res$statusStore)) {
        # self$results$debug$setContent("init")
        firstRun<-TRUE

        setBrawOpts(fullOutput=0,reportHTML=TRUE,
                    fullGraphSize=0.5,
                    npointsMax=1000,
                    autoPrint=FALSE
        )
        setBrawEnv("graphicsType","HTML")
        svgBox(height=350,aspect=1.5,fontScale=1.2)
        blankPlot<-nullPlot()
        
        demoResults<-generate_tab(
          title="Demonstration:",
          plainTabs=TRUE,
          titleWidth=100,
          tabs=c("Single","Multiple","Explore","Plan"),
          tabContents=rep(blankPlot,4),
          open=0
        )
        investgResults<-generate_tab(
          title="Investigation:",
          plainTabs=TRUE,
          titleWidth=100,
          tabs=c("Data","Schematic"),
          tabContents=rep(blankPlot,2),
          tabLink='https://doingpsychstats.wordpress.com/investigations/',
          tabLinkLabel=paste0('\U24D8',' here'),
          outerHeight=380,
          open=0
        )
        simResults<-generate_tab(
          title="Simulation:",
          plainTabs=TRUE,
          titleWidth=100,
          tabs=c("Single","Multiple","Explore","Plan"),
          tabContents=rep(blankPlot,4),
          open=0
        )
        
        statusStore<-list(lastOutput="System",
                          demoResults=demoResults,
                          investgResults=investgResults,
                          simResults=simResults,
                          showSampleType="Blank",
                          showInferParam="Basic",
                          showInferDimension="1D",
                          showMultipleParam="Basic",
                          showMultipleDimension="1D",
                          whichShowMultipleOut="all",
                          showExploreParam="Basic",
                          showExploreStyle="stats",
                          whichShowExploreOut="all",
                          doDemos=4,
                          showPlan=TRUE,
                          nestedHelp=TRUE,
                          basicHelpWhich=0,
                          demoHelpWhich=c(0,0),
                          investgHelpWhich=0,
                          simHelpWhich=0,
                          openJamovi=0,
                          planMode="planH",
                          basicMode="LearnHelp",
                          exploreMode="Design",
                          nrowTableLM=1,
                          nrowTableSEM=1,
                          counter=0
        )
        simHistory<-list(
          history=NULL,
          historyData=NULL,
          historyOptions=NULL,
          historyPlace=0
        )
        invHistory<-list(
          history=NULL,
          historyData=NULL,
          historyOptions=NULL,
          historyPlace=0
        )
        setBrawRes("investgD",blankPlot)
        setBrawRes("investgS",blankPlot)
        setBrawRes("investgR",blankPlot)
        setBrawRes("simSingle",blankPlot)
        setBrawRes("simMultiple",blankPlot)
        setBrawRes("simExplore",blankPlot)
        
      } else {
        statusStore<-braw.res$statusStore
        simHistory<-braw.res$simHistoryStore
        invHistory<-braw.res$invHistoryStore
      }

      # save the old set up
      oldH<-braw.def$hypothesis
      oldD<-braw.def$design
      oldE<-braw.def$evidence
      oldX<-braw.def$explore
      oldM<-braw.def$metaAnalysis
      
      
      if (any(self$options$stopBtn)) stopBtn<-TRUE else stopBtn<-FALSE 
## are we doing an investigation
      {
      investgControls<-c(self$options$doMeta0Btn,self$options$doMeta0mBtn,
                         self$options$doMeta1IBtn,self$options$doMeta1ImBtn,
                         self$options$doMeta1ABtn,self$options$doMeta1AmBtn,
                         self$options$doMeta1BBtn,self$options$doMeta1BmBtn,
                         self$options$doMeta2ABtn,self$options$doMeta2AmBtn,
                         self$options$doMeta2BBtn,self$options$doMeta2BmBtn,
                         self$options$doMeta3ABtn,self$options$doMeta3AmBtn,
                         self$options$doMeta3BBtn,self$options$doMeta3BmBtn,
                         self$options$doMeta4ABtn,self$options$doMeta4AmBtn,
                         self$options$doMeta4BBtn,self$options$doMeta4BmBtn,
                         self$options$doMeta5ABtn,self$options$doMeta5AmBtn,
                         self$options$doMeta5BBtn,self$options$doMeta5BmBtn)
      investgNames<-c("Inv0I","Inv0Im",
                      "Inv0I","Inv0Im",
                      "Inv1A","Inv1Am",
                      "Inv1B","Inv1Bm",
                      "Inv2A","Inv2Am",
                      "Inv2B","Inv2Bm",
                      "Inv3A","Inv3Am",
                      "Inv3B","Inv3Bm",
                      "Inv4A","Inv4Am",
                      "Inv4B","Inv4Bm",
                      "Inv5A","Inv5Am",
                      "Inv5B","Inv5Bm"
                      )
      if (any(investgControls)) {
        # statusStore$showPlan<-FALSE
        emptyPlot(self)
        private$.checkpoint()

        doingInvestg<-investgNames[investgControls]
        doingInvestg<-doingInvestg[1]
      } else       {
        doingInvestg<-NULL
      }
      
      # investigations history?
      if ((self$options$invGoBack || self$options$invGoForwards)) {
        h<-readHistory(invHistory,self$options$invGoBack)
        doingInvestg<-h$historyOptions
        outputNow<-h$outputNow
        invHistory<-h$history
      }
      
      # are we doing investigations?
      if (!is.null(doingInvestg)) {
        switch(substr(doingInvestg,1,4),
               "Inv0"={
                 world<-NULL
                 pNull<-NULL
                 sN<-NULL
               },
               "Inv1"={
                 world<-NULL
                 pNull<-self$options$meta1pNull
                 sN<-NULL
               },
               "Inv2"={
                 world<-self$options$meta2World
                 pNull<-self$options$meta2pNull
                 sN<-self$options$meta2SampleSize
               },
               "Inv3"={
                 world<-self$options$meta3World
                 pNull<-self$options$meta3pNull
                 sN<-self$options$meta3SampleSize
               },
               "Inv4"={
                 world<-self$options$meta4World
                 pNull<-self$options$meta4pNull
                 sN<-self$options$meta4SampleSize
               },
               "Inv5"={
                 world<-NULL
                 pNull<-NULL
                 sN<-NULL
               }
        )
        if (substr(doingInvestg,6,6)=='m') nl<-10 else nl<-1
        nreps<-10
        numberSamples<-self$options$metaMultiple
        if (!identical(oldH,braw.def$hypothesis) || !identical(oldD,braw.def$design) || is.null(braw.res$multiple)) 
             targetN<-numberSamples
        else targetN<-braw.res$multiple$count+numberSamples
        while ((is.null(braw.res$multiple)) || (braw.res$multiple$count<targetN)) {
          investgResults<-doInvestigation(doingInvestg,
                                          world=world,rp=self$options$metaDefaultRp,pNull=pNull,
                                          sN=sN,sBudget=self$options$meta2SampleBudget,sSplits=self$options$meta2SampleSplits,
                                          sMethod=self$options$meta3SampleMethod,sCheating=self$options$meta3Cheating,
                                          sReplicationPower=self$options$meta4RepPower,sReplicationSigOriginal=self$options$meta4SigOriginal=="yes",
                                          nreps=nreps
          )
          self$results$simGraphHTML$setContent(investgResults)
          statusStore$investgResults<-investgResults
          setBrawRes("statusStore",statusStore)
          private$.checkpoint()
          if (stopBtn) break
        }
        
        statusStore$lastOutput<-"investg"
        statusStore$investgResults<-investgResults
        setBrawRes("statusStore",statusStore)
        setBrawRes("invHistoryStore",invHistory)
        
        if (substr(doingInvestg,6,6)=="m") sendData2Jamovi("Multiple",self)
        else sendData2Jamovi("Single",self)
        return()
      }
      
      }

## basic definitions      
      {
      # make all the standard things we need
      # store the option variables inside the braw package
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
      {
        opens<-c(statusStore$basicHelpWhich,statusStore$demoHelpWhich,statusStore$investgHelpWhich,statusStore$simHelpWhich)
        statusStore<-whichTabsOpen(self,statusStore)
        newopens<-c(statusStore$basicHelpWhich,statusStore$demoHelpWhich,statusStore$investgHelpWhich,statusStore$simHelpWhich)
        changedL<-!all(opens==newopens)
        
        helpOutput<-makeHelpOut(self$options$brawHelp,statusStore)
        planOutput<-makeSystemOut(self,statusStore,FALSE,FALSE,FALSE)
        # if (statusStore$showPlan)
        # helpOutput<-makeSystemOut(self,statusStore,FALSE,FALSE,FALSE,helpOutput)
      
      # only change this if there has been a change in what it displays
        if (any(c(firstRun,changedH,changedD,changedE,changedL)))
          self$results$simSystemHTML$setContent(helpOutput)
      }
      
## ignore changes in the ModeSelectors
      {
      if (self$options$basicMode!=statusStore$basicMode 
          || self$options$planMode!=statusStore$planMode
          || self$options$exploreMode!=statusStore$exploreMode) {
        if (is.element(self$options$basicMode,c("Demonstrations","Investigations","Simulations"))) 
        if (self$options$basicMode!=statusStore$basicMode) {
          switch(self$options$basicMode,
                 "Demonstrations"=self$results$simGraphHTML$setContent(statusStore$demoResults),
                 "Investigations"=self$results$simGraphHTML$setContent(statusStore$investgResults),
                 "Simulations"=self$results$simGraphHTML$setContent(statusStore$simResults)
          )
        private$.checkpoint()
        }
        
        statusStore$basicMode<-self$options$basicMode
        statusStore$planMode<-self$options$planMode
        statusStore$exploreMode<-self$options$exploreMode
        setBrawRes("statusStore",statusStore)

        sendData2Jamovi(statusStore$lastOutput,self)
        return()
      }
      }

## proceed to actions

      # we are going back or forwards in the history
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
        
        updateHistoryNow<-FALSE
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
            setBrawRes("result",doAnalysis(sample=braw.res$result))
            addHistory<-TRUE
            updateHistoryNow<-TRUE
          }
          # or metaAnalysis?
          if (!is.null(braw.res$metaSingle) && statusStore$lastOutput=="MetaSingle") {
            # same data new analysis
            if (!changedMsource) {
            braw.res$metaSingle<-doMetaAnalysis(braw.res$metaSingle,keepStudies=TRUE)
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
        
        if (!stopBtn)
        if (any(c(makeSampleNow,
                  makeMultipleNow && statusStore$lastOutput!="Multiple",
                  makeExploreNow && statusStore$lastOutput!="Explore"
                  ))) {
          emptyPlot(self)
          private$.checkpoint()
        }
        # now we start doing new things
        # did we ask for a new sample?
        if (makeSampleNow) {
          # make a sample - either straight sample or single metaAnalysis
          if (self$options$MetaAnalysisOn) {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$metaSingle) || is.element(statusStore$lastOutput,c("MetaSingle","investg"))) {
              doMetaAnalysis(NULL)
              addHistory<-TRUE
              updateHistoryNow<-TRUE
              # }
            outputNow<-"MetaSingle"
          } else {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$result) || is.element(statusStore$lastOutput,c(showSampleType,"investg"))) {
              doSingle()
              addHistory<-TRUE
              updateHistoryNow<-TRUE
              # }
            if (showSampleType=="Likelihood")
              doPossible(possible)
            outputNow<-showSampleType
            updateHistoryNow<-TRUE
          }
        }
        
        # did we ask for new multiples?
        if (makeMultipleNow) {
          if (self$options$MetaAnalysisOn) {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$metaMultiple) || is.element(statusStore$lastOutput,c("MetaMultiple","investg"))) {
              doMetaMultiple(numberSamples,braw.res$metaMultiple)
              addHistory<-TRUE
              updateHistoryNow<-TRUE
              # }
            outputNow<-"MetaMultiple"
          } else {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$multiple) || is.element(statusStore$lastOutput,c("Multiple"))) {
            ns<-min(10,numberSamples/10)
            if (changedH || changedD || is.null(braw.res$multiple)) targetN<-numberSamples
            else targetN<-braw.res$multiple$count+numberSamples
            while ((is.null(braw.res$multiple)) || (braw.res$multiple$count<targetN)) {
              doMultiple(nsims=ns,multipleResult=braw.res$multiple)
              
              setBrawEnv("graphicsType","HTML")
              svgBox(height=350,aspect=1.5,fontScale=1.2)
              simMultiple<-paste0(showMultiple(showType=showMultipleParam,dimension=showMultipleDimension,effectType=whichShowMultipleOut,orientation=showMultipleOrient),
                                  reportMultiple(showType=showMultipleParam,effectType=whichShowMultipleOut,reportStats=self$options$reportInferStats)
              )
              setBrawRes("simMultiple",simMultiple)
              open<-2
              simResults<-generate_tab(
                title="Simulation:",
                plainTabs=TRUE,
                titleWidth=100,
                tabs=c("Single","Multiple","Explore","Plan"),
                tabContents=c(braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore,planOutput),
                open=open
              )
              self$results$simGraphHTML$setContent(simResults)
              statusStore$simResults<-simResults
              setBrawRes("statusStore",statusStore)
              private$.checkpoint()
              if (stopBtn) break
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
          # if (is.null(braw.res$explore) || is.element(statusStore$lastOutput,c("Explore","investg"))) {
          numberSamples          
          ns<-max(10,numberExplores/10)
          for (ij in 1:(numberExplores/ns)) {
            exploreResult<-doExplore(nsims=ns,exploreResult=braw.res$explore,
                                     doingMetaAnalysis=self$options$MetaAnalysisOn)
            
            svgBox(height=350,aspect=1.5,fontScale=1.2)
            setBrawEnv("graphicsType","HTML")
              simExplore<-paste0(showExplore(showType=showExploreParam,showHist=(showExploreStyle=="hist"),effectType=whichShowExploreOut),
                                 reportExplore(showType=showExploreParam,effectType=whichShowExploreOut,reportStats=self$options$reportInferStats)
              )
              setBrawRes('simExplore',simExplore)
              open<-3
              simResults<-generate_tab(
                title="Simulation:",
                plainTabs=TRUE,
                titleWidth=100,
                tabs=c("Single","Multiple","Explore","Plan"),
                tabContents=c(braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore,planOutput),
                open=open
              )
              self$results$simGraphHTML$setContent(simResults)
              statusStore$simResults<-simResults
              setBrawRes("statusStore",statusStore)
              private$.checkpoint()
              if (stopBtn) break
          }
            if (statusStore$lastOutput!="Explore" || changedH || changedD || changedE || changedX) addHistory<-TRUE
            updateHistoryNow<-TRUE
            # }
          outputNow<-"Explore"
        }
      }
      
      # what are we showing?
      # main results graphs/reports
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
          if (self$options$basicMode=="Demonstrations") {
            demoResults<-generate_tab(
              title="Demonstration:",
              plainTabs=TRUE,
              titleWidth=100,
              tabs=c("Single","Multiple","Explore","Plan"),
              tabContents=c(braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore,planOutput),
              open=open
            )
            self$results$simGraphHTML$setContent(demoResults)
            statusStore$demoResults<-demoResults
          } else {
            simResults<-generate_tab(
              title="Simulation:",
              plainTabs=TRUE,
              titleWidth=100,
              tabs=c("Single","Multiple","Explore","Plan"),
              tabContents=c(braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore,planOutput),
              open=open
            )
            self$results$simGraphHTML$setContent(simResults)
            statusStore$simResults<-simResults
          }
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
      sendData2Jamovi(outputNow,self)

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
