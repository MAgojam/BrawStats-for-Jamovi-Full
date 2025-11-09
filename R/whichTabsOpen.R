whichTabsOpen<-function(self,statusStore) {

  statusStore$basicsHelpWhich<-0
  statusStore$metaSciHelpWhich<-0
  statusStore$simHelpWhich<-0
  statusStore$openJamovi<-0
  
if (self$options$simHelp) statusStore$simHelpWhich<-c(4,1)
if (self$options$simPlanHelp) statusStore$simHelpWhich<-c(4,2)
if (self$options$simSingleHelp) statusStore$simHelpWhich<-c(4,3)
if (self$options$simMultipleHelp) statusStore$simHelpWhich<-c(4,4)
if (self$options$simExploreHelp) statusStore$simHelpWhich<-c(4,5)

if (self$options$metaHelp) statusStore$metaSciHelpWhich<-c(3,1)
if (self$options$meta1Help) statusStore$metaSciHelpWhich<-c(3,2)
if (self$options$meta2Help) statusStore$metaSciHelpWhich<-c(3,3)
if (self$options$meta3Help) statusStore$metaSciHelpWhich<-c(3,4)
if (self$options$meta4Help) statusStore$metaSciHelpWhich<-c(3,5)
if (self$options$meta5Help) statusStore$metaSciHelpWhich<-c(3,6)

if (self$options$basicsHelp) statusStore$basicsHelpWhich<-c(2,1,0)
if (self$options$basics1Help) statusStore$basicsHelpWhich<-c(2,2,1)
if (self$options$basics2Help) statusStore$basicsHelpWhich<-c(2,3,1)
if (self$options$basics3Help) statusStore$basicsHelpWhich<-c(2,4,1)
if (self$options$basics4Help) statusStore$basicsHelpWhich<-c(2,5,1)
if (self$options$basics5Help) statusStore$basicsHelpWhich<-c(2,6,1)
if (self$options$basics6Help) statusStore$basicsHelpWhich<-c(2,7,1)
  if (self$options$basics7Help) statusStore$basicsHelpWhich<-c(2,8,1)
  if (self$options$basics8Help) statusStore$basicsHelpWhich<-c(2,9,1)
  if (self$options$basics9Help) statusStore$basicsHelpWhich<-c(2,10,1)
  

opens<-c(statusStore$basicsHelpWhich,statusStore$metaSciHelpWhich,statusStore$simHelpWhich)
if (any(opens)) {
  statusStore$helpOpens<-opens[opens>0]
} else statusStore$helpOpens<-0

return(statusStore)
}
