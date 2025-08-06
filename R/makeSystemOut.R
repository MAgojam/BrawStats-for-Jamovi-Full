makeSystemOut<-function(self,statusStore,changedH,changedD,changedE,helpOutput="") {
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
  if (braw.def$hypothesis$effect$world$worldOn) {
    h<-showSystem("world")
  } else {
    h<-showSystem("hypothesis")
    # e<-showSystem("prediction")
    # h<-joinHTML(h,e)
  }
  h<-joinHTML(h,reportWorld())
  svgBox(180*self$options$systemMag)
  sd<-showSystem("design")
  svgBox(180)
  rd<-reportDesign()
  d<-joinHTML(sd,rd)
  # systemHTML<-paste0(systemHTML,
  #                    generate_tab(
  #                      titleWidth=50,
  #                      title="Plan:",
  #                      plain=plain,
  #                      tabs=c("Hypothesis"),
  #                      tabContents = c(joinHTML(h,d)),
  #                      open=openSystem
  #                    )
  # )
  
  # restore everything we might have changed
  setBrawEnv("graphicsType",oldHTML)
  svgBox(400)
  
  return(joinHTML(h,d))
}