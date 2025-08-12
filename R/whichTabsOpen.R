whichTabsOpen<-function(self,statusStore) {

old_simHelpWhich<-statusStore$simHelpWhich
if (self$options$simHelp) statusStore$simHelpWhich<-1
if (self$options$simPlanHelp) statusStore$simHelpWhich<-2
if (self$options$simSingleHelp) statusStore$simHelpWhich<-3
if (self$options$simMultipleHelp) statusStore$simHelpWhich<-4
if (self$options$simExploreHelp) statusStore$simHelpWhich<-5
if (statusStore$simHelpWhich==old_simHelpWhich) statusStore$simHelpWhich<-0


old_metaSciHelpWhich<-statusStore$metaSciHelpWhich
if (self$options$metaHelp) statusStore$metaSciHelpWhich<-1
if (self$options$meta1Help) statusStore$metaSciHelpWhich<-2
if (self$options$meta2Help) statusStore$metaSciHelpWhich<-3
if (self$options$meta3Help) statusStore$metaSciHelpWhich<-4
if (self$options$meta4Help) statusStore$metaSciHelpWhich<-5
if (self$options$meta5Help) statusStore$metaSciHelpWhich<-6
if (statusStore$metaSciHelpWhich==old_metaSciHelpWhich) statusStore$metaSciHelpWhich<-0

old_demoHelpWhich<-statusStore$demoHelpWhich
if (self$options$demosHelp) statusStore$demoHelpWhich<-c(1,0)
if (self$options$demo1Help) statusStore$demoHelpWhich<-c(2,1)
if (self$options$demo2Help) statusStore$demoHelpWhich<-c(3,1)
if (statusStore$doDemos>2 && self$options$demo3Help) statusStore$demoHelpWhich<-c(4,1)
if (statusStore$doDemos>3 && self$options$demo4Help) statusStore$demoHelpWhich<-c(5,1)
if (self$options$doDemo1AhBtn) statusStore$demoHelpWhich<-c(2,2)
if (self$options$doDemo1BhBtn) statusStore$demoHelpWhich<-c(2,3)
if (self$options$doDemo1ChBtn) statusStore$demoHelpWhich<-c(2,4)
if (self$options$doDemo2AhBtn) statusStore$demoHelpWhich<-c(3,2)
if (self$options$doDemo2BhBtn) statusStore$demoHelpWhich<-c(3,3)
if (self$options$doDemo2ChBtn) statusStore$demoHelpWhich<-c(4,4)
if (self$options$doDemo3AhBtn) statusStore$demoHelpWhich<-c(4,2)
if (self$options$doDemo3BhBtn) statusStore$demoHelpWhich<-c(4,3)
if (self$options$doDemo3ChBtn) statusStore$demoHelpWhich<-c(4,4)
if (statusStore$doDemos>3) {
  if (self$options$doDemo4AhBtn) statusStore$demoHelpWhich<-c(5,2)
  # if (self$options$doDemo4BhBtn) statusStore$demoHelpWhich<-c(5,3)
  # if (self$options$doDemo4ChBtn) statusStore$demoHelpWhich<-c(5,4)
}
if (statusStore$doDemos>4) {
  if (self$options$doDemo5AhBtn) statusStore$demoHelpWhich<-c(6,2)
}
if (all(statusStore$demoHelpWhich==old_demoHelpWhich))statusStore$demoHelpWhich<-c(0,0)

statusStore$openJamovi<-0
if (self$options$doDemo1A2Btn) statusStore$openJamovi<-1
if (self$options$doDemo4A2Btn) statusStore$openJamovi<-1

return(statusStore)
}
