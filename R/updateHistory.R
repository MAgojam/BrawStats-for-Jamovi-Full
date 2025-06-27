updateHistory<-function(history,historyOptions,outputNow,addHistory) {
  nHistory<-15
  
  if (is.null(history$history)) {
    nD<-1
  } else {
    if (addHistory) nD<-length(history$history)+1
    else            nD<-length(history$history)
  }
  history$history[nD]<-outputNow
  
  history$historyData[[nD]]<-list(result=braw.res$result,
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