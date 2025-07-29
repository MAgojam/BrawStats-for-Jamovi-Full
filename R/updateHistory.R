updateHistory<-function(history,historyOptions,outputNow,addHistory) {
  nHistory<-15
  
  if (is.null(history$history)) {
    nD<-1
  } else {
    if (addHistory) nD<-length(history$history)+1
    else            nD<-length(history$history)
  }
  history$history[nD]<-outputNow
  
  history$historyData[[nD]]<-list(hypothesis=braw.def$hypothesis,
                                  design=braw.def$design,
                                  evidence=braw.def$evidence,
                                  result=braw.res$result,
                                  multiple=braw.res$multiple,
                                  explore=braw.res$explore,
                                  metaSingle=braw.res$metaSingle,
                                  metaMultiple=braw.res$metaMultiple
  )
  history$historyOptions[[nD]]<-historyOptions
  if (nD>nHistory) {
    use<-(nD-(nHistory-1)):nD
    history$history<-history$history[use]
    history$historyData<-history$historyData[use]
    history$historyOptions<-history$historyOptions[use]
    nD<-nHistory
  }
  history$historyPlace<-nD
  return(history)
}

readHistory<-function(history,backwards) {
  nhist<-length(history$history)
  if (backwards) history$historyPlace<-max(history$historyPlace-1,1)
  else           history$historyPlace<-min(history$historyPlace+1,nhist)
  
  outputNow<-history$history[history$historyPlace]
  
  historyOptions<-history$historyOptions[[history$historyPlace]]
  
  setBrawDef("hypothesis",history$historyData[[history$historyPlace]]$hypothesis)
  setBrawDef("design",history$historyData[[history$historyPlace]]$design)
  setBrawDef("evidence",history$historyData[[history$historyPlace]]$evidence)
  
  setBrawRes("result",history$historyData[[history$historyPlace]]$result)
  setBrawRes("multiple",history$historyData[[history$historyPlace]]$multiple)
  setBrawRes("explore",history$historyData[[history$historyPlace]]$explore)
  setBrawRes("metaSingle",history$historyData[[history$historyPlace]]$metaSingle)
  setBrawRes("metaMultiple",history$historyData[[history$historyPlace]]$metaMultiple)
  
  return(list(historyOptions=historyOptions,outputNow=outputNow,history=history))
}