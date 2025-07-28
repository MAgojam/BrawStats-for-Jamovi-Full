
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
      a<-R.Version()$version.string
      rVersion<-as.numeric(regmatches(a,gregexpr("[0-9]*\\.[0-9]*",a))[[1]][1])
      if (rVersion>=4.5) Jamovi<-2.7 else Jamovi<-2.6
      # self$results$debug$setContent(Jamovi)
      # self$results$debug$setVisible(TRUE)
      # return()

      firstRun<-FALSE
      updateHistory<-FALSE
      # initialization code here
      if (is.null(braw.res$statusStore)) {
        firstRun<-TRUE

        setBrawOpts(fullOutput=0,reportHTML=TRUE,
                    fontScale=1.5,fullGraphSize=0.5,
                    npointsMax=1000,
                    autoPrint=FALSE
        )
        setBrawEnv("graphicsType","HTML")
        svgBox(height=350,aspect=1.5)
        
        demoResults<-generate_tab(
          title="Demonstration:",
          plainTabs=TRUE,
          titleWidth=100,
          tabs=c("Single","Multiple","Explore"),
          tabContents=c(nullPlot(),nullPlot(),nullPlot()),
          open=0
        )
        investgResults<-generate_tab(
          title="Investigation:",
          plainTabs=TRUE,
          titleWidth=100,
          # tabs=c("Single","Multiple","Comments"),
          # tabContents=c(nullPlot(),nullPlot(),nullPlot()),
          tabs=c("Graph","Report"),
          tabContents=c(nullPlot(),nullPlot()),
          open=0
        )
        simResults<-generate_tab(
          title="Simulation:",
          plainTabs=TRUE,
          titleWidth=100,
          tabs=c("Single","Multiple","Explore"),
          tabContents=c(nullPlot(),nullPlot(),nullPlot()),
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
                          nrowTableSEM=1
        )
        history<-list(
          history=NULL,
          historyData=NULL,
          historyOptions=NULL,
          historyPlace=0
        )
        np<-nullPlot()
        setBrawRes("investgG",np)
        setBrawRes("investgR",np)
        setBrawRes("simSingle",np)
        setBrawRes("simMultiple",np)
        setBrawRes("simExplore",np)
        
      } else {
        statusStore<-braw.res$statusStore
        history<-braw.res$historyStore
      }
      
## some interface stuff
      # get which tabs are open in help structure
      {
      opens<-c(statusStore$basicHelpWhich,statusStore$demoHelpWhich,statusStore$investgHelpWhich,statusStore$simHelpWhich)
      statusStore<-whichTabsOpen(self,statusStore)
      newopens<-c(statusStore$basicHelpWhich,statusStore$demoHelpWhich,statusStore$investgHelpWhich,statusStore$simHelpWhich)
      changedL<-!all(opens==newopens)
      # get the demo status
      doingDemo<-(self$options$basicMode=="Demonstrations")
      }
      
      # get the investigation controls
      {
      investgControls<-c(self$options$doMeta1ABtn,self$options$doMeta1AmBtn,
                         self$options$doMeta1BBtn,self$options$doMeta1BmBtn,
                         self$options$doMeta1CBtn,self$options$doMeta1CmBtn,
                         self$options$doMeta2ABtn,self$options$doMeta2AmBtn,
                         self$options$doMeta2BBtn,self$options$doMeta2BmBtn,
                         self$options$doMeta3ABtn,self$options$doMeta3AmBtn,
                         self$options$doMeta3BBtn,self$options$doMeta3BmBtn,
                         self$options$doMeta4ABtn,self$options$doMeta4AmBtn,
                         self$options$doMeta4BBtn,self$options$doMeta4BmBtn,
                         self$options$doMeta5ABtn,self$options$doMeta5AmBtn,
                         self$options$doMeta5BBtn,self$options$doMeta5BmBtn)
      investgNames<-c("Inv1A","Inv1Am",
                      "Inv1B","Inv1Bm",
                      "Inv1C","Inv1Cm",
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
        doingInvestg<-investgNames[investgControls]
        doingInvestg<-doingInvestg[1]
      }
      }
      
## basic definitions      
      {
      # save the old ones
      oldH<-braw.def$hypothesis
      oldD<-braw.def$design
      oldE<-braw.def$evidence
      oldX<-braw.def$explore
      oldM<-braw.def$metaAnalysis
      
      # make all the standard things we need
      # store the option variables inside the braw package
      setBraw(self)
      
      # are we doing meta investigations?
      # set the design and hypothesis accordingly
      if (any(investgControls)) {
        invg<-substr(doingInvestg,1,4)
        switch(invg,
               "Inv1"={
                 switch(substr(doingInvestg,5,5),
                        "A"=hypothesis<-makeHypothesis(effect=makeEffect(world=getWorld("Plain"))),
                        "B"=hypothesis<-makeHypothesis(effect=makeEffect(world=getWorld("Binary"))),
                        "C"=hypothesis<-makeHypothesis(effect=makeEffect(world=getWorld("Psych50")))
                        )
                 if (substr(doingInvestg,5,5)!="A")
                   hypothesis$effect$world$populationNullp<-self$options$meta1pNull
               },
               "Inv2"={
                 hypothesis<-makeHypothesis(effect=makeEffect(world=getWorld(self$options$meta2World)))
                 if (self$options$meta2World!="Plain")
                   hypothesis$effect$world$populationNullp<-self$options$meta2pNull
               },
               "Inv3"={
                 hypothesis<-makeHypothesis(effect=makeEffect(world=getWorld(self$options$meta2World)))
                 if (self$options$meta3World!="Plain")
                   hypothesis$effect$world$populationNullp<-self$options$meta3pNull
               },
               "Inv4"={
                 hypothesis<-makeHypothesis(effect=makeEffect(world=getWorld(self$options$Meta4World)))
                 if (self$options$Meta4World!="Plain")
                   hypothesis$effect$world$populationNullp<-self$options$meta4pNull
               },
               "Inv5"={
                 if (substr(doingInvestg,5,5)=="A")
                   hypothesis<-makeHypothesis(effect=makeEffect(rIV=0.3/2,rIV2=0,rIVIV2DV=0.3/2))
                 else
                   hypothesis<-makeHypothesis(effect=makeEffect(rIV=0.3,rIV2=-sqrt(0.3),rIVIV2=sqrt(0.3)))
               }
        )
        setBrawDef("hypothesis",hypothesis)
        
        switch(invg,
               "Inv1"={
                 design<-makeDesign(sN=50)
               },
               "Inv2"={
                 switch(substr(doingInvestg,5,5),
                        "A"=design<-makeDesign(sN=self$options$meta2SampleSize),
                        "B"=design<-makeDesign(sN=self$options$meta2SampleBudget)
                          )
                 
               },
               "Inv3"={
                 design<-makeDesign(sN=self$options$meta3SampleSize)
                 switch(substr(doingInvestg,5,5),
                        "A"=design$sMethod<-makeSampling(self$options$meta3SampleMethod),
                        "B"={
                          design$sCheating<-self$options$Meta3Cheating
                          design$sCheatingLimit<-"Budget"
                          design$sCheatingBudget<-0.25
                        }
                 )
               },
               "Inv4"={
                 design<-makeDesign(sN=self$options$Meta4SampleSize)
                 switch(substr(doingInvestg,5,5),
                        "A"= {
                          design$Replication<-makeReplication(TRUE,Keep="Cautious",
                                                              forceSigOriginal=self$options$Meta4SigOriginal=="yes",Power=self$options$Meta4RepPower)
                        },
                        "B"={
                          design$Replication<-makeReplication(TRUE,Keep="MetaAnalysis",
                                                              forceSigOriginal=self$options$Meta4SigOriginal=="yes",Power=self$options$Meta4RepPower)
                        }
                 )
               },
               "Inv5"={
                 switch(substr(doingInvestg,5,5),
                        "A"={
                          if (self$options$Meta5SampleGroup=="a") range<-c(1,1) else range<-c(-1,-1)
                          design<-makeDesign(sN=1000,sIV2RangeOn=TRUE,sIV2Range=range)
                        },
                        "B"={
                          if (self$options$Meta5SampleGroup=="a") range<-c(0,0) else range<-c(-4,4)
                          design<-makeDesign(sN=1000,sIV2RangeOn=TRUE,sIV2Range=range)
                        }
                 )
                 evidence<-makeEvidence(AnalysisTerms=1)
                 setBrawDef("evidence",evidence)
               }
        )
        setBrawDef("design",design)
      }
      
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
      helpOutput<-makeHelpOut(self$options$brawHelp,statusStore)
      if (statusStore$showPlan)
        helpOutput<-makeSystemOut(self,statusStore,changedH,changedD,changedE,helpOutput)
      
      # only change this if there has been a change in what it displays
      if (any(c(firstRun,changedH,changedD,changedE,changedL)))
        self$results$simSystemHTML$setContent(helpOutput)
      }
      
## ignore changes in the ModeSelectors
      # after help instructions are set up
      {
      if (self$options$basicMode!=statusStore$basicMode 
          || self$options$planMode!=statusStore$planMode
          || self$options$exploreMode!=statusStore$exploreMode) {
        if (self$options$basicMode!=statusStore$basicMode)
          switch(self$options$basicMode,
                 "Demonstrations"=self$results$simGraphHTML$setContent(statusStore$demoResults),
                 "Investigations"=self$results$simGraphHTML$setContent(statusStore$investgResults),
                 "Simulations"=self$results$simGraphHTML$setContent(statusStore$simResults)
          )
        statusStore$basicMode<-self$options$basicMode
        statusStore$planMode<-self$options$planMode
        statusStore$exploreMode<-self$options$exploreMode
        setBrawRes("statusStore",statusStore)
        setBrawRes("historyStore",history)
        
        sendData2Jamovi(statusStore$lastOutput,self)
        return()
      }
      }
      
      ## proceed to actions
      # investigation actions first
      if (any(investgControls)) {
        reportCounts=FALSE

        if (substr(doingInvestg,1,4)=="Inv5")
          setHypothesis(IV2=makeVariable("IV2","Interval"))

        if (substr(doingInvestg,6,6)!="m") {
          if (substr(doingInvestg,1,5)=="Inv2B") {
            setDesign(sN=floor(self$options$meta2SampleBudget/self$options$meta2SampleSplits))
            nreps<-floor(self$options$meta2SampleSplits)
            doMultiple(nreps,NULL)
            outputNow<-"Multiple"
            reportCounts<-TRUE
          } else {
            doSingle()
            outputNow<-"Description"
          }
          open<-1
          # we display replications as multiple results
          if (substr(doingInvestg,1,4)=="Inv4")  setBrawRes("multiple",braw.res$result)
        } else {
          if (doingInvestg=="Inv2Bm") {
            setDesign(sN=self$options$meta2SampleBudget)
            doExplore(50,explore=makeExplore("nSplits",vals=2^c(0,1,2,3,4,5),xlog=TRUE))
            outputNow<-"Explore"
            reportCounts<-TRUE
          } else {
            if (doingInvestg=="Inv3Bm") nreps<-50
            else                 nreps<-200
            doMultiple(nreps)
            outputNow<-"Multiple"
          }
          open<-2
        }
        

        if (is.element(doingInvestg,c("Inv5A","Inv5B"))) {
          result<-braw.res$result
          result$hypothesis$IV2<-NULL
          setBrawRes("result",result)
        } 
        if (is.element(doingInvestg,c("Inv5Am","Inv5Bm"))) {
          multiple<-braw.res$multiple
          multiple$hypothesis$IV2<-NULL
          multiple$result$hypothesis$IV2<-NULL
          switch(self$options$Meta5SampleGroup,
                 "a"={multiple$result$hypothesis$effect$rIV<-0.3},
                 "b"={multiple$result$hypothesis$effect$rIV<-0}
                 )
          setBrawRes("multiple",multiple)
        } 
        
        
      # display the results
        svgBox(height=350,aspect=1.5)
        setBrawEnv("graphicsType","HTML")
        setBrawEnv("reportCounts",reportCounts)
        setBrawEnv("fullOutput",1)
        switch(open,
               { 
                 if (is.element(doingInvestg,c("Inv2B","Inv4A","Inv4B"))) {
                   if (doingInvestg=="Inv2B") {
                     investgG<-showMultiple(showType="rse",dimension="1D",orientation="horz")
                     investgR<-reportMultiple(showType="NHST",reportStats=self$options$reportInferStats)
                   }
                   else {
                     investgG<-showMultiple()
                     investgR<-reportInference()
                   }
                 } else  {
                   investgG<-showDescription()
                   investgR<-reportInference()
                 }
               },
               {
                 if (doingInvestg=="Inv2Bm") {
                   investgG<-showExplore(showType="n(sig)")
                   investgR<-reportExplore(showType="n(sig)")
                 }
                 else {
                   if (is.element(doingInvestg,c("Inv5Am","Inv5Bm"))) {
                     investgG<-showMultiple(showType="rs",dimension="1D",orientation="horz")
                     investgR<-reportMultiple(showType="rs")
                   }
                   else   {
                     investgG<-showMultiple(showType="rse",dimension="1D",orientation="horz")
                     investgR<-reportMultiple(showType="NHST")
                   }
                 }
               }
        )
        setBrawRes("investgG",investgG)
        setBrawRes("investgR",investgR)
        investgResults<-
          generate_tab(
            title=paste0("Investigation",":"),
            plainTabs=TRUE,
            titleWidth=100,
            # tabs=c("Single","Multiple","Comments"),
            # tabContents=c(braw.res$investgSingle,braw.res$investgMultiple,investgComment(doingInvestg)),
            tabs=c("Graph","Report"),
            tabContents=c(braw.res$investgG,braw.res$investgR),
            tabLink=paste0('https://doingpsychstats.wordpress.com/investigations#',substr(doingInvestg,1,5)),
            tabLinkLabel=paste0(" Inv",substr(doingInvestg,4,6)),
            open=1
          )
        
        self$results$simGraphHTML$setContent(investgResults)
        
        statusStore$lastOutput<-"investg"
        statusStore$investgResults<-investgResults
        setBrawRes("statusStore",statusStore)
        
        sendData2Jamovi(outputNow,self)
        return()
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
        
        updateHistory<-FALSE
      }
      
      # we are doing something new
      if (!self$options$goBack && !self$options$goForwards) {
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
        # at this stage, we assume nothing new for the history
        addHistory<-FALSE 
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
          }
          # or metaAnalysis?
          if (!is.null(braw.res$metaSingle) && statusStore$lastOutput=="MetaSingle") {
            # same data new analysis
            if (!changedMsource) {
            braw.res$metaSingle<-doMetaAnalysis(braw.res$metaSingle,keepStudies=TRUE)
            addHistory<-TRUE
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
        
        # now we start doing new things
        # did we ask for a new sample?
        if (makeSampleNow) {
          # make a sample - either striaght sample or single metaAnalysis
          if (self$options$MetaAnalysisOn) {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$metaSingle) || is.element(statusStore$lastOutput,c("MetaSingle","investg"))) {
              doMetaAnalysis(NULL)
              addHistory<-TRUE
            # }
            outputNow<-"MetaSingle"
          } else {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$result) || is.element(statusStore$lastOutput,c(showSampleType,"investg"))) {
              doSingle()
              addHistory<-TRUE
            # }
            if (showSampleType=="Likelihood")
              doPossible(possible)
            outputNow<-showSampleType
          }
        }
        
        # did we ask for new multiples?
        if (makeMultipleNow) {
          if (self$options$MetaAnalysisOn) {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$metaMultiple) || is.element(statusStore$lastOutput,c("MetaMultiple","investg"))) {
              doMetaMultiple(numberSamples,braw.res$metaMultiple)
              addHistory<-TRUE
            # }
            outputNow<-"MetaMultiple"
          } else {
            # # do we need to do this, or are we just returning to the existing one?
            # if (is.null(braw.res$multiple) || is.element(statusStore$lastOutput,c("Multiple","investg"))) {
              doMultiple(nsims=numberSamples,multipleResult=braw.res$multiple)
              if (statusStore$lastOutput!="Multiple" || changedH || changedD || changedE) addHistory<-TRUE
            # } 
            outputNow<-"Multiple"
          }
        }
        
        # did we ask for new explore?
        if (makeExploreNow) {
          numberExplores<-self$options$numberExplores
          # # do we need to do this, or are we just returning to the existing one?
          # if (is.null(braw.res$explore) || is.element(statusStore$lastOutput,c("Explore","investg"))) {
            exploreResult<-doExplore(nsims=numberExplores,exploreResult=braw.res$explore,
                                     doingMetaAnalysis=self$options$MetaAnalysisOn)
            if (statusStore$lastOutput!="Explore" || changedH || changedD || changedE || changedX) addHistory<-TRUE
          # }
          outputNow<-"Explore"
        }
      } 
      
      # what are we showing?
      # main results graphs/reports
      if (!is.null(outputNow))  {
        
          svgBox(height=350,aspect=1.5)
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
          if (doingDemo) {
            demoResults<-generate_tab(
              title="Demonstration:",
              plainTabs=TRUE,
              titleWidth=100,
              tabs=c("Single","Multiple","Explore"),
              tabContents=c(braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore),
              open=open
            )
            self$results$simGraphHTML$setContent(demoResults)
            statusStore$demoResults<-demoResults
          } else {
            simResults<-generate_tab(
              title="Simulation:",
              plainTabs=TRUE,
              titleWidth=100,
              tabs=c("Single","Multiple","Explore"),
              tabContents=c(braw.res$simSingle,braw.res$simMultiple,braw.res$simExplore),
              open=open
            )
            self$results$simGraphHTML$setContent(simResults)
            statusStore$simResults<-simResults
          }
          
          updateHistory<-TRUE
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
      if (updateHistory) {
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
        setBrawRes("historyStore",history)
      }
      
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
