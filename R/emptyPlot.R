emptyPlot<-function(mode) {

    switch(mode,
           "Basics"=tabs<-c("Single","Multiple","Explore"),
           "MetaScience"=tabs<-c("Data","Schematic"),
           "Simulation"=tabs<-c("Single","Multiple","Explore")
    )
    switch(mode,
           "Basics"=tabTitle<-"Basics:",
           "MetaScience"=tabTitle<-"MetaScience:",
           "Simulation"=tabTitle<-"Simulation:"
    )
    nullResults<-generate_tab(
      title=tabTitle,
      plainTabs=TRUE,
      titleWidth=100,
      tabs=tabs,
      tabContents=rep(nullPlot(),length(tabs)),
      outerHeight=450,
      open=0
    )
    return(nullResults)
    # self$results$simGraphHTML$setContent(nullResults)
  
}