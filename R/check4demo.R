partBS<-function(doing) toupper(gsub('[A-Za-z]*[0-9]*([A-Da-d]*)','\\1',doing))
stepBS<-function(doing) gsub('[A-Za-z]*([0-9]*)[A-Da-d]*','\\1',doing)
singleBS<-function(doing) !grepl('m',tolower(gsub('[A-Za-z]*[0-9]*[A-Da-d]*([rm]*)','\\1',doing)),fixed=TRUE)


check4basics<-function(self,private) {
  
  doingHistory<-TRUE
  statusStore<-braw.res$statusStore
  
  args<-list(IV="Perfectionism",IV2=NULL,DV="ExamGrade",
             rIV=NULL,rIV2=NULL,rIVIV2=NULL,rIVIV2DV=NULL,
             sN=NULL,sMethod=NULL,sDataFormat=NULL,
             sOutliers=0, sDependence=0,
             analyse=c(TRUE,FALSE,FALSE,FALSE),
             allScatter=NULL
  )
  
  basicsControls<-c( self$options$doBasics1ABtn,self$options$doBasics1AmBtn,
                     self$options$doBasics1BBtn,self$options$doBasics1BmBtn,
                     self$options$doBasics1CBtn,self$options$doBasics1CmBtn,
                     self$options$doBasics2ABtn,
                     self$options$doBasics2BBtn,
                     self$options$doBasics2CBtn,
                     self$options$doBasics3ABtn,
                     self$options$doBasics3BBtn,
                     self$options$doBasics3CBtn,
                     
                     self$options$doBasics31ABtn,
                     self$options$doBasics31BBtn,
                     
                     self$options$doBasics4ABtn,self$options$doBasics4AmBtn,
                     self$options$doBasics4BBtn,self$options$doBasics4BmBtn,
                     self$options$doBasics4CBtn,self$options$doBasics4CmBtn,
                     
                     self$options$doBasics5RBtn,
                     self$options$doBasics5ABtn,self$options$doBasics5AmBtn,
                     self$options$doBasics5BBtn,self$options$doBasics5BmBtn,
                     self$options$doBasics5CBtn,self$options$doBasics5CmBtn,
                     
                     self$options$doBasics6RBtn,
                     self$options$doBasics6ABtn,self$options$doBasics6AmBtn,
                     self$options$doBasics6BBtn,self$options$doBasics6BmBtn,
                     self$options$doBasics6CBtn,self$options$doBasics6CmBtn,
                     
                     self$options$doBasics7ABtn,self$options$doBasics7AmBtn,
                     self$options$doBasics7BBtn,self$options$doBasics7BmBtn,
                     self$options$doBasics8ABtn,self$options$doBasics8AmBtn,
                     self$options$doBasics8BBtn,self$options$doBasics8BmBtn,
                     self$options$doBasics8CBtn,self$options$doBasics8CmBtn,
                     
                     self$options$doBasics9ABtn,self$options$doBasics9AmBtn,
                     self$options$doBasics9BBtn,self$options$doBasics9BmBtn,
                     self$options$doBasics9CBtn,self$options$doBasics9CmBtn,
                     self$options$doBasics10ABtn,self$options$doBasics10AmBtn,
                     self$options$doBasics10BBtn,self$options$doBasics10BmBtn,
                     self$options$doBasics10CBtn,self$options$doBasics10CmBtn,
                     FALSE
  )
  basicsNames<-c("Step1A","Step1Am",
               "Step1B","Step1Bm",
               "Step1C","Step1Cm",
               "Step2A",
               "Step2B",
               "Step2C",
               "Step3A",
               "Step3B",
               "Step3C",
               "Step31A",
               "Step31B",
               "Step4A","Step4Am",
               "Step4B","Step4Bm",
               "Step4C","Step4Cm",
               "Step5R",
               "Step5A","Step5Am",
               "Step5B","Step5Bm",
               "Step5C","Step5Cm",
               "Step6R",
               "Step6A","Step6Am",
               "Step6B","Step6Bm",
               "Step6C","Step6Cm",
               "Step7A","Step7Am",
               "Step7B","Step7Bm",
               "Step8A","Step8Am",
               "Step8B","Step8Bm",
               "Step8C","Step8Cm",
               "Step9A","Step9Am",
               "Step9B","Step9Bm",
               "Step9C","Step9Cm",
               "Step10A","Step10Am",
               "Step10B","Step10Bm",
               "Step10C","Step10Cm",
               ""
  )
  basicsStep6Analysis<-NULL
  if (any(basicsControls)) {
    # hit a button before the previous one was completed
    if (length(which(basicsControls))>1) return(FALSE)
    doingBasics<-basicsNames[which(basicsControls)]
    if (is.null(doingBasics)) return(FALSE)
    if (doingBasics=="Step6R") doingBasics<-paste0("Step",braw.res$basicsDone[1],braw.res$basicsDone[2],"r")
  } else {
    return(FALSE)
    # code below doesn't work and so is never run
    # it is supposed to do an automatic update when the analysis terms are changed
    doingBasics<-NULL
    if (braw.res$basicsDone[1]=="5") {
      basicsStep5Analysis<-c(self$options$doBasics5Main1,self$options$doBasics5Main2,self$options$doBasics5Interaction,FALSE)
      changedAnalysis<-any(statusStore$basicsStep5Analysis!=basicsStep5Analysis)
      if (changedAnalysis)
        doingBasics<-paste0("Step",braw.res$basicsDone[1],braw.res$basicsDone[2],"r")
    }   
    if (braw.res$basicsDone[1]=="6") {
      basicsStep6Analysis<-c(self$options$doBasics6Main1,self$options$doBasics6Main2,FALSE,FALSE)
      changedAnalysis<-any(statusStore$basicsStep6Analysis!=basicsStep6Analysis)
      if (changedAnalysis)
        doingBasics<-paste0("Step",braw.res$basicsDone[1],braw.res$basicsDone[2],"r")
    }   
    if (is.null(doingBasics)) return(FALSE)
  }

  doingMultiple<-!singleMS(doingBasics)
  
  if (stepBS(doingBasics)=="1") {
    args$IV=self$options$doBasics1IV
    args$DV<-self$options$doBasics1DV
  } 
  if (doingBasics=="Step1B") {
    args$sMethod=self$options$doBasics1BSampling 
    args$sOutliers<-self$options$doBasics1BOutliers 
    args$sDependence<-self$options$doBasics1BDependence
  } 
  if (doingBasics=="Step1C") 
    args$sN=self$options$doBasics1CSampleSize 
  
  if (stepBS(doingBasics)=="2") {
    args$rIV=self$options$doBasics2EffectSize 
    args$sN=self$options$doBasics2SampleSize 
  }
  
  if (stepBS(doingBasics)=="3") {
    args$rIV=self$options$doBasics3EffectSize 
    args$sN=self$options$doBasics3SampleSize 
  }
  
  if (stepBS(doingBasics)=="4") {
    args$rIV=self$options$doBasic45EffectSize1
    args$rIV2=self$options$doBasics4EffectSize2
    args$sN=self$options$doBasics4SampleSize
  }
  
  if (stepBS(doingBasics)=="5") {
    if (!is.null(basicsStep5Analysis)) args$analyse<-basicsStep5Analysis
    else args$analyse<-c(self$options$doBasics5Main1,self$options$doBasics5Main2,self$options$doBasics5Interaction,FALSE)
    statusStore$basicsStep5Analysis<-args$analyse
    
    args$rIV=self$options$doBasics5EffectSize1
    args$rIV2=self$options$doBasics5EffectSize2
    args$rIVIV2DV=self$options$doBasics5EffectSize1x2
    args$sN=self$options$doBasics5SampleSize 
  }
  
  if (stepBS(doingBasics)=="6") {
    if (!is.null(basicsStep6Analysis)) args$analyse<-basicsStep6Analysis
    else args$analyse<-c(self$options$doBasics6Main1,self$options$doBasics6Main2,FALSE,FALSE)
    statusStore$basicsStep6Analysis<-args$analyse
    
    # args$rIV=self$options$doBasics6EffectSize1
    # args$rIV2=self$options$doBasics6EffectSize2
    args$rIVIV2=self$options$doBasics6EffectSize12
    args$sN=self$options$doBasics6SampleSize 
  }
  
  if (stepBS(doingBasics)=="8") {
    args$allScatter<-FALSE
    args$sDataFormat<-"wide"
  }
  
  if (stepBS(doingBasics)=="10") {
    args$rIV=self$options$doBasics10AMain1Effect
    args$rIV2=0
    args$rIVIV2DV=self$options$doBasics10AInteractionEffect
  }
  
  basicsResults<-doBasics(doingBasics,showOutput=FALSE,
                               IV=args$IV,IV2=args$IV2,DV=args$DV,
                               rIV=args$rIV,rIV2=args$rIV2,rIVIV2=args$rIVIV2,rIVIV2DV=args$rIVIV2DV,
                               sN=args$sN,sMethod=args$sMethod,
                               sDataFormat=args$sDataFormat,
                               sOutliers=args$sOutliers, sDependence=args$sDependence,
                               analyse=args$analyse,
                               allScatter=args$allScatter
  )
  self$results$simGraphHTML$setContent(basicsResults)
  
  statusStore$lastOutput<-"basics"
  statusStore$basicsResults<-basicsResults
  setBrawRes("statusStore",statusStore)
  
  if (doingMultiple) sendData2Jamovi("Multiple",self)
  else sendData2Jamovi("Single",self)
  return(TRUE)
}
