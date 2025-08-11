emptyPlot<-function(self) {

    switch(self$options$basicMode,
           "Basics"=tabs<-c("Single","Multiple","Explore"),
           "MetaScience"=tabs<-c("Data","Schematic","Report"),
           "Simulation"=tabs<-c("Single","Multiple","Explore")
    )
    switch(self$options$basicMode,
           "Basics"=tabTitle<-"Basics:",
           "MetaScience"=tabTitle<-"MetaScience:",
           "Simulation"=tabTitle<-"Simulation:"
    )
    nullResults<-generate_tab(
      title=tabTitle,
      plainTabs=TRUE,
      titleWidth=100,
      tabs=tabs,
      tabContents=c(nullPlot(),nullPlot(),nullPlot()),
      open=0
    )
    self$results$simGraphHTML$setContent(nullResults)
  
}