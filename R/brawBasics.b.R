
# This file is a generated template, your changes will not be overwritten
# label: '5. <span style="color:#1276b9;"><b>Real Differences:</b></span> when should replication fail?'


BrawBasicsClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "BrawBasicsClass",
  inherit = BrawBasicsBase,
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
        simResults<-emptyPlot("Simulation",useHelp=TRUE)

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
                          planMode='',
                          exploreMode='',
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

        self$results$simGraphHTML$setContent(statusStore$basicsResults)
        setBrawRes("statusStore",statusStore)
        return()
      }

      # nothing to do?
      if (is.element(self$options$topMode,c("LearnHelp","Settings"))) {
        return()
      }

      check4basics(self,private)
      return()
      
      # end of .run()
    }
  )
)
