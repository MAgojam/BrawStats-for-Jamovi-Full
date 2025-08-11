makeHelpOut<-function(brawHelp,statusStore) {
  indent<-0
  titleWidth<-135
  if (statusStore$nestedHelp) {
    indent<-20
    titleWidth<-0
  }
  if (brawHelp) {
    basicHelp<-brawBasicHelp(open=statusStore$basicHelpWhich,indent,titleWidth)
    demoHelp<-brawDemosHelp(open=statusStore$demoHelpWhich,indent,titleWidth,statusStore$doDemos)
    investgHelp<-brawInvestgHelp(open=statusStore$investgHelpWhich,indent,titleWidth)
    simHelp<-brawSimHelp(open=statusStore$simHelpWhich,indent,titleWidth)
    jamoviHelp<-brawJamoviHelp(open=statusStore$openJamovi,indent,titleWidth,
                               braw.def$hypothesis,braw.def$design)
    
    if (statusStore$nestedHelp) {
      open0<-max(0,statusStore$basicHelpWhich,any(statusStore$demoHelpWhich>0)*2,(statusStore$investgHelpWhich>0)*3,(statusStore$simHelpWhich>0)*4,(statusStore$openJamovi>0)*5)
      help<-generate_tab(
        title="Help:",
        plainTabs=TRUE,
        titleWidth=50,
        tabs=c("Start","Basics","MetaScience","Simulation","Jamovi","Key"),
        tabContents=c(basicHelp,demoHelp,investgHelp,simHelp,jamoviHelp,BrawInstructions("Key")),
        open=open0
      )
    } else help<-paste0(basicHelp,investgHelp,demoHelp,simHelp,jamoviHelp) 
  } else help<-''
  
  return(help)
}