check4metaScience<-function(self,private) {
  
  doingHistory<-TRUE
  statusStore<-braw.res$statusStore
  
    metaSciControls<-c(self$options$doMeta0Btn,self$options$doMeta0mBtn,
                       self$options$doMeta0RBtn,self$options$doMeta0CBtn,
                       self$options$doMeta0ABtn,self$options$doMeta0AmBtn,
                       self$options$doMeta0ArBtn,self$options$doMeta0AmrBtn,
                       self$options$doMeta1ABtn,self$options$doMeta1AmBtn,
                       self$options$doMeta1BBtn,self$options$doMeta1BmBtn,
                       self$options$doMeta2ABtn,self$options$doMeta2AmBtn,
                       self$options$doMeta2BBtn,self$options$doMeta2BmBtn,
                       self$options$doMeta3ABtn,self$options$doMeta3AmBtn,
                       self$options$doMeta3BBtn,self$options$doMeta3BmBtn,
                       self$options$doMeta4ABtn,self$options$doMeta4AmBtn,
                       self$options$doMeta4ArBtn,self$options$doMeta4AmrBtn,
                       self$options$doMeta4AcBtn,self$options$doMeta4AmcBtn,
                       self$options$doMeta4BBtn,self$options$doMeta4BmBtn,
                       self$options$doMeta4BrBtn,self$options$doMeta4BmrBtn,
                       self$options$doMeta4BcBtn,self$options$doMeta4BmcBtn,
                       self$options$doMeta5ABtn,self$options$doMeta5AmBtn,
                       self$options$doMeta5ArBtn,self$options$doMeta5AmrBtn,
                       self$options$doMeta5BBtn,self$options$doMeta5BmBtn,
                       self$options$doMeta5BrBtn,self$options$doMeta5BmrBtn
    )
    metaSciNames<-c("Step0A","Step0Am","Step4Ar","Step4Ac",
                    "Step0A","Step0Am",
                    "Step0Ar","Step0Amr",
                    "Step1A","Step1Am",
                    "Step1B","Step1Bm",
                    "Step2A","Step2Am",
                    "Step2B","Step2Bm",
                    "Step3A","Step3Am",
                    "Step3B","Step3Bm",
                    "Step4A","Step4Am",
                    "Step4Ar","Step4Amr",
                    "Step4Ac","Step4Amc",
                    "Step4B","Step4Bm",
                    "Step4Br","Step4Bmr",
                    "Step4Bc","Step4Bmc",
                    "Step5A","Step5Am",
                    "Step5Ar","Step5Amr",
                    "Step5B","Step5Bm",
                    "Step5Br","Step5Bmr"
    )
    if (!any(metaSciControls)) return(FALSE)
      
      # statusStore$showPlan<-FALSE
      nullResults<-emptyPlot("MetaScience")
      self$results$simGraphHTML$setContent(nullResults)
      private$.checkpoint()
      
      doingMetaSci<-metaSciNames[metaSciControls]
      doingMetaSci<-doingMetaSci[1]

    
      sN<-self$options$metaDefaultN
      world<-self$options$metaDefaultWorld
      metaPublicationBias<-self$options$metaPublicationBias
      switch(stepMS(doingMetaSci),
             "0"={
               metaPublicationBias<-"no"
             },
             "1"={
               pRplus<-self$options$meta1pRplus
               rP<-self$options$meta1rp
             },
             "2"={
               pRplus<-self$options$meta2pRplus
               rP<-self$options$meta2rp
               sN<-self$options$meta2SampleSize
             },
             "3"={
               pRplus<-self$options$meta3pRplus
               rP<-self$options$meta3rp
             },
             "4"={
               pRplus<-self$options$meta4pRplus
               rP<-self$options$meta4rp
               if (partMS(doingMetaSci)=="A") 
                 sN<-self$options$meta4SampleSize
               metaPublicationBias<-"yes"
             },
             "5"={
               world<-"Plain"
               pRplus<-0
               sN<-250
               rP<-0.3
               metaPublicationBias<-"no"
             }
      )
      metaScience<-prepareMetaScience(doingMetaSci,
                                      world=world,rp=rP,pRplus=pRplus,metaPublicationBias=metaPublicationBias=="yes",
                                      sN=sN,
                                      sMethod=self$options$meta3SampleMethod,sCheating=self$options$meta3Cheating,
                                      sBudget=self$options$meta2SampleBudget,sSplits=self$options$meta2SampleSplits,
                                      sReplicationPower=self$options$metaDefaultRepPower,sReplicationOriginalAnomaly=self$options$meta4OriginalAnomaly
      )
      
      doingMultiple<-!singleMS(doingMetaSci)
      if (doingMultiple)  {
        if (is.null(braw.res$multiple) || 
            !identical(metaScience$hypothesis,braw.res$multiple$hypothesis) || 
            !identical(metaScience$design,braw.res$multiple$design)) 
          nDone<-0
        else    nDone<-braw.res$multiple$count
        targetN<-nDone+self$options$metaMultiple
        nreps<-max(1,ceiling(nDone/10))
      }
      else {
        nDone<-0
        targetN<-1
        nreps<-1
      }
      
      # startTime<-Sys.time()
      while (nDone<targetN) {
        nreps<-10
        if (nDone>=100) nreps<-50
        if (nDone>=500) nreps<-100
        nreps<-min(nreps,targetN-nDone)
        metaSciResults<-doMetaScience(metaScience,nreps=nreps,showOutput=FALSE,doHistory=FALSE)
        statusStore$metaSciResults<-metaSciResults
        if (doingMultiple) nDone<-braw.res$multiple$count
        else nDone<-1
        
        self$results$simGraphHTML$setContent(metaSciResults)
        if (doingMultiple) private$.checkpoint()
        if (self$options$stopBtn) break
      }
      metaSciResults<-doMetaScience(metaScience,nreps=0,showOutput=FALSE,doHistory=doingHistory)
      self$results$simGraphHTML$setContent(metaSciResults)
      
      statusStore$lastOutput<-"metaSci"
      statusStore$metaSciResults<-metaSciResults
      setBrawRes("statusStore",statusStore)
      
      if (doingMultiple) sendData2Jamovi("Multiple",self)
      else sendData2Jamovi("Single",self)
      return(TRUE)
}