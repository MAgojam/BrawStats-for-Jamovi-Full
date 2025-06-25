
# This file is a generated template, your changes will not be overwritten

BrawAnClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "BrawAnClass",
  inherit = BrawAnBase,
  private = list(
    .init = function() {
      # initialization code 
      setBrawOpts(reducedOutput=TRUE,reportHTML=TRUE,
                  fontScale=1.5,fullGraphSize=0.5,
                  autoPrint=FALSE
      )
    },
    .run = function() {
      
      # debug information
      # self$results$debug$setVisible(TRUE)
      # self$results$debug$setContent(braw.env$graphicsSize)
      
      if (is.null(self$options$IV) || is.null(self$options$DV)) {
        self$results$reportPlot$setState(NULL)
        return()
      }
      
      evidence<-braw.def$evidence
      evidence$rInteractionOn<-self$options$doInteraction
      
      sample<-readSample(self$data,DV=self$options$DV,IV=self$options$IV)
      result<-doAnalysis(sample,evidence=evidence)
      braw.res$result<<-result
      
      switch(self$options$show,
             "Sample"=   outputReport<-reportSample(),
             "Describe"= outputReport<-reportDescription(),
             "Infer"=    outputReport<-reportInference()
      )
      self$results$reportPlot$setContent(outputReport)
      self$results$graphPlot$setState(c(self$options$show,self$options$inferWhich))
    },
    
    .plotGraph=function(image, ...) {
      
      outputGraph <- image$state[1]
      if (!is.null(outputGraph)) {
        switch(self$options$show,
               "Sample"=   outputGraph<-showSample(),
               "Describe"= outputGraph<-showDescription(),
               "Infer"=    outputGraph<-showInference(showType=image$state[2])
        )
        print(outputGraph)
        return(TRUE)
      } else return(FALSE)
    }
  )
)
  