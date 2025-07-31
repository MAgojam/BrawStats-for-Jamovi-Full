sendData2Jamovi<-function(outputNow,self) {
  
    # single result first
    if (self$options$sendSample && !is.null(braw.res$result)) {
      if (is.null(braw.def$hypothesis$IV2)) {
        newVariables<-data.frame(braw.res$result$participant,braw.res$result$dv,braw.res$result$iv,braw.res$result$dv+NA)
        names(newVariables)<-c("ID",braw.def$hypothesis$DV$name,braw.def$hypothesis$IV$name,"-")
      } else {
        newVariables<-data.frame(braw.res$result$participant,braw.res$result$dv,braw.res$result$iv,braw.res$result$iv2)
        names(newVariables)<-c("ID",braw.def$hypothesis$DV$name,braw.def$hypothesis$IV$name,braw.def$hypothesis$IV2$name)
      }
      
      keys<-1:length(newVariables)
      measureTypes<-sapply(newVariables,function(x) { if (is.character(x)) "Nominal" else "Continuous"})
      
      self$results$sendSample$set(keys=keys,titles=names(newVariables),
                                  descriptions=rep("simulated",length(newVariables)),
                                  measureTypes=measureTypes
      )
      self$results$sendSample$setValues(newVariables)
    }
    # then the multiple result
    if (self$options$sendMultiple) {
      q<-NULL
      if (!is.null(outputNow) && outputNow=="MetaSingle") {
        q<-braw.res$metaSingle$result
      } 
      if (!is.null(outputNow) && outputNow=="Multiple") {
        q<-mergeMultiple(braw.res$multiple$result,braw.res$multiple$nullresult)
      }
      if (!is.null(q)) {
        newMultiple<-data.frame(q$rIV,q$nval+0.0,q$pIV)
        newMultiple<-newMultiple[!is.na(q$rIV),]
        names(newMultiple)<-c("rs","n","p")
        nvars<-ncol(newMultiple)
        
        keys<-1:nvars
        self$results$sendMultiple$set(keys=keys,titles=names(newMultiple),
                                      descriptions=rep("simulated",nvars),
                                      measureTypes=rep("Continuous",nvars)
        )
        self$results$sendMultiple$setValues(newMultiple)
      }
    }
    # then the explore result
    if (self$options$sendExplore && !is.null(outputNow) && outputNow=="Explore") {
      showExploreParam<-self$options$showExploreParam
      if (is.element(showExploreParam,c("Single"))) {
        showExploreParam<-self$options$inferVar1
      } 
      if (is.element(showExploreParam,c("Basic","Custom"))) {
        showExploreParam<-paste0(self$options$inferVar1,";",self$options$inferVar2)
      } 
      newExplore<-reportExplore(returnDataFrame=TRUE,showType=showExploreParam,reportStats=self$options$reportInferStats)
      nvars<-ncol(newExplore)
      
      titles<-gsub("\\(([a-zA-Z0-9_]*)\\)","_\\1",names(newExplore))
      keys<-1:nvars
      self$results$sendExplore$set(keys=keys,titles=titles,
                                   descriptions=rep("simulated",nvars),
                                   measureTypes=rep("Continuous",nvars)
      )
      self$results$sendExplore$setValues(newExplore)
    }

}