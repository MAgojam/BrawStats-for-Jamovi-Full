makeHelpOut<-function(self,statusStore) {
  indent<-0
  titleWidth<-135
  if (statusStore$nestedHelp) {
    indent<-50
    titleWidth<-0
  }
  if (self$options$brawHelp) {
    basicHelp<-brawbasicHelp(open=statusStore$basicHelpWhich,indent,titleWidth)
    simHelp<-brawsimHelp(open=statusStore$simHelpWhich,indent,titleWidth)
    jamoviHelp<-brawJamoviHelp(open=statusStore$openJamovi,indent,titleWidth,
                               braw.def$hypothesis,braw.def$design)
    
    demoHelp<-brawDemosHelp(statusStore$demoHelpWhich,indent,titleWidth,statusStore$doDemos)
    
    if (statusStore$nestedHelp) {
      open0<-max(0,statusStore$basicHelpWhich,any(statusStore$demoHelpWhich>0)*2,(statusStore$simHelpWhich>0)*3,(statusStore$openJamovi>0)*4)
      help<-generate_tab(
        title="Help:",
        plainTabs=TRUE,
        titleWidth=50,
        tabs=c("Basic","Demos","Simulations","Jamovi","Key"),
        tabContents=c(basicHelp,demoHelp,simHelp,jamoviHelp,BrawInstructions("Key")),
        open=open0
      )
    } else help<-paste0(basicHelp,demoHelp,simHelp,jamoviHelp) 
    statusStore$basicHelpWhich<-0 # so closed next time round
  } else help<-''
  
  return(help)
}