emptyPlot<-function(self) {

    switch(self$options$basicMode,
           "Demonstrations"=tabs<-c("Single","Multiple","Explore"),
           "Investigations"=tabs<-c("Data","Schematic"),
           "Simulations"=tabs<-c("Single","Multiple","Explore")
    )
    switch(self$options$basicMode,
           "Demonstrations"=tabTitle<-"Demonstration:",
           "Investigations"=tabTitle<-"Investigation:",
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