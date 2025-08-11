emptyPlot<-function(self) {

    switch(self$options$basicMode,
           "Basics"=tabs<-c("Single","Multiple","Explore"),
           "MetaScience"=tabs<-c("Data","Schematic"),
           "Simulations"=tabs<-c("Single","Multiple","Explore")
    )
    switch(self$options$basicMode,
           "Basics"=tabTitle<-"Basics:",
           "MetaScience"=tabTitle<-"MetaScience:",
           "Simulations"=tabTitle<-"Simulation:"
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
    self$results$simGraphHTML$setContent(nullResults)
  
}