makeSystemOut<-function(self,statusStore,changedH,changedD,changedE,helpOutput) {
  oldHTML<-braw.env$graphicsType
  setBrawEnv("graphicsType","HTML")
  
  if (nchar(helpOutput)>0) {
    plain<-TRUE
    systemHTML<-paste0(helpOutput,'<div><br></div>')
  }
  else {
    systemHTML<-""
    plain<-FALSE
  }

  switch(self$options$showHypothesisLst,
         "Default"={
           openSystem<-0
           if (changedD && braw.def$design$sNRand) openSystem<-2
           if (changedD && !braw.def$design$sNRand) openSystem<-1
           if (changedH) openSystem<-1
           if (changedE) openSystem<-1
         },
         "Hypothesis"={openSystem<-1},
         "Design"={openSystem<-2}
  ) 
  
  svgBox(200*self$options$systemMag)
  h<-showSystem("hypothesis")
  svgBox(180*self$options$systemMag)
  sd<-showSystem("design")
  svgBox(180)
  rd<-reportDesign()
  svgBox(200*self$options$systemMag)
  e<-showSystem("prediction")
  # l<-showPossible(NA,showType="Samples")
  systemHTML<-paste0(systemHTML,
                     generate_tab(
                       titleWidth=50,
                       title="Plan:",
                       plain=plain,
                       tabs=c("Hypothesis","Design"),
                       tabContents = c(
                         joinHTML(h,e),
                         joinHTML(sd,rd)
                       ),
                       open=openSystem
                     )
  )
  # restore everything we might have changed
  setBrawEnv("graphicsType",oldHTML)
  svgBox(400)
  
  return(systemHTML)
}