
sendData2Jamovi<-function(outputNow,whichSource,self,private) {
  
  alwaysDoLong<-self$options$alwaysDoLong
  
    # single result first
    if (self$options$sendSample && !is.null(braw.res$result)) {
      newVariables2<-newVariables<-c()
      if (is.null(braw.res$result$hypothesis$IV2)) {
        useOrder<-order(braw.res$result$participant)
        newVariables<-data.frame(braw.res$result$participant[useOrder],
                                 braw.res$result$dv[useOrder],braw.res$result$iv
                                 [useOrder],braw.res$result$dv+NA)
          names(newVariables)<-c("ID",braw.res$result$hypothesis$DV$name,braw.res$result$hypothesis$IV$name,"-")
          if (braw.res$result$design$sIV1Use=="Within") {
            newVariables2<-c()
            m<-levels(braw.res$result$iv)
            for (i in 1:length(m)) {
              use<-braw.res$result$iv==m[i]
              newVariables2<-cbind(newVariables2,braw.res$result$dv[use])
            }
            if (braw.env$fullWithinNames)
              newNames2<-paste0(braw.res$result$hypothesis$DV$name,"|",braw.res$result$hypothesis$IV$name,"=",braw.res$result$hypothesis$IV$cases)
            else
              newNames2<-paste0(braw.res$result$hypothesis$IV$cases)
            newVariables2<-cbind(braw.res$result$participant[1:sum(use)],newVariables2)
            newNames2<-c("IDwide",newNames2)
            
            newVariables2<-newVariables2[order(newVariables2[,1]),]
            newVariables2<-data.frame(newVariables2)
          names(newVariables2)<-newNames2
        }
      } else {
        newVariables<-data.frame(braw.res$result$participant,braw.res$result$dv,braw.res$result$iv,braw.res$result$iv2)
        newVariables<-newVariables[order(newVariables[,1]),]
        names(newVariables)<-c("ID",braw.res$result$hypothesis$DV$name,braw.res$result$hypothesis$IV$name,braw.res$result$hypothesis$IV2$name)

        if (braw.res$result$design$sIV1Use=="Within" && braw.res$result$design$sIV2Use=="Between") {
          newVariables2<-c()
          m1<-levels(braw.res$result$iv)
          for (i1 in 1:length(m1)) {
            use<-braw.res$result$iv==m1[i1]
            newVariables2<-cbind(newVariables2,braw.res$result$dv[use])
          }
          newVariables2<-data.frame(newVariables2)
          if (braw.env$fullWithinNames)
            newNames2<-paste0(braw.res$result$hypothesis$DV$name,"|",braw.res$result$hypothesis$IV$name,"=",braw.res$result$hypothesis$IV$cases)
          else
            newNames2<-paste0(braw.res$result$hypothesis$IV$cases)
          newVariables2<-cbind(braw.res$result$participant[1:sum(use)],newVariables2,braw.res$result$iv2[1:sum(use)])
          names(newVariables2)<-c("IDwide",newNames2,paste0(braw.res$result$hypothesis$IV2$name,"w"))
        } 
        if (braw.res$result$design$sIV1Use=="Between" && braw.res$result$design$sIV2Use=="Within") {
          m2<-levels(braw.res$result$iv2)
          for (i2 in 1:length(m2)) {
            use<-braw.res$result$iv2==m2[i2]
            newVariables2<-cbind(newVariables2,braw.res$result$dv[use])
          }
          newVariables2<-newVariables2[order(newVariables2[,1]),]
          newVariables2<-data.frame(newVariables2)
          if (braw.env$fullWithinNames)
            newNames2<-paste0(braw.res$result$hypothesis$DV$name,"|",braw.res$result$hypothesis$IV2$name,"=",braw.res$result$hypothesis$IV2$cases)
          else
            newNames2<-paste0(braw.res$result$hypothesis$IV2$cases)
          newVariables2<-cbind(braw.res$result$participant[1:sum(use)],newVariables2,braw.res$result$iv[1:sum(use)])
          names(newVariables2)<-c("IDwide",newNames2,paste0(braw.res$result$hypothesis$IV$name,"w"))
        } 
        if (braw.res$result$design$sIV1Use=="Within" && braw.res$result$design$sIV2Use=="Within") {
          newNames2<-c()
          m1<-levels(braw.res$result$iv)
          m2<-levels(braw.res$result$iv2)
          for (i1 in 1:length(m1)) 
            for (i2 in 1:length(m2)) {
              use<-braw.res$result$iv==m1[i1] & braw.res$result$iv2==m2[i2]
              newVariables2<-cbind(newVariables2,braw.res$result$dv[use])
              if (braw.env$fullWithinNames)
                newNames2<-c(newNames2,paste0(braw.res$result$hypothesis$DV$name,"|",braw.res$result$hypothesis$IV$name,"=",braw.res$result$hypothesis$IV$cases[i1],
                                          "|",braw.res$result$hypothesis$IV2$name,"=",braw.res$result$hypothesis$IV2$cases[i2]))
              else
                newNames2<-c(newNames2,paste0(braw.res$result$hypothesis$IV$cases[i1],"&",braw.res$result$hypothesis$IV2$cases[i2]))
            }
          newVariables2<-newVariables2[order(newVariables2[,1]),]
          newVariables2<-data.frame(newVariables2)
          newVariables2<-cbind(braw.res$result$participant[1:sum(use)],newVariables2)
          names(newVariables2)<-c("ID",newNames2)
        }
      }
      
      if (!is.null(newVariables) && (alwaysDoLong || is.null(newVariables2))) {
        keys<-1:length(newVariables)
        measureTypes<-sapply(newVariables,function(x) { if (is.character(x) || is.factor(x)) "Nominal" else "Continuous"})
        self$results$sendSample$set(keys=keys,titles=names(newVariables),
                                    descriptions=rep("simulated",length(newVariables)),
                                    measureTypes=measureTypes
        )
        
        self$results$sendSample$setValues(newVariables)
      }
      
      if (!is.null(newVariables2)) {
        keys<-1:length(newVariables2)
        measureTypes<-sapply(newVariables2,function(x) { if (is.character(x) || is.factor(x)) "Nominal" else "Continuous"})
        
        self$results$sendSamplewide$set(keys=keys,titles=names(newVariables2),
                                        descriptions=rep("simulated",length(newVariables2)),
                                        measureTypes=measureTypes
        )
        self$results$sendSamplewide$setValues(newVariables2)
      }
    }
  if (whichSource=="Basics") return()
  
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
        newMultiple<-data.frame(q$rpIV,q$rIV,q$nval+0.0,q$pIV)
        newMultiple<-newMultiple[!is.na(q$rIV),]
        names(newMultiple)<-c("rp","rs","n","p")
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