setBraw<-function(self) {
  
  
  # the hypothesis has IV, DV and effect
  #
  DV<-makeVariable(self$options$DVname,self$options$DVtype,
                   mu=self$options$DVmu,sd=self$options$DVsd,skew=self$options$DVskew,kurtosis=self$options$DVkurt,
                   ncats=self$options$DVncats,cases=self$options$DVcases,proportions=self$options$DVprops,
                   nlevs=self$options$DVnlevs,iqr=self$options$DViqr)
  IV<-makeVariable(self$options$IVname,self$options$IVtype,
                   mu=self$options$IVmu,sd=self$options$IVsd,skew=self$options$IVskew,kurtosis=self$options$IVkurt,
                   ncats=self$options$IVncats,cases=self$options$IVcases,proportions=self$options$IVprops,
                   nlevs=self$options$IVnlevs,iqr=self$options$IViqr)
  if (self$options$presetIV2!="none") {
    IV2<-makeVariable(self$options$IV2name,self$options$IV2type,
                      mu=self$options$IV2mu,sd=self$options$IV2sd,skew=self$options$IV2skew,kurtosis=self$options$IV2kurt,
                      ncats=self$options$IV2ncats,cases=self$options$IV2cases,proportions=self$options$IV2props,
                      nlevs=self$options$IV2nlevs,iqr=self$options$IV2iqr)
  } else {
    IV2<-NULL
  }
  
  effect<-makeEffect(rIV=self$options$EffectSize1,
                     rIV2=self$options$EffectSize2,
                     rIVIV2=self$options$EffectSize3,
                     rIVIV2DV=self$options$EffectSize12,
                     rSD=self$options$rSD,
                     Heteroscedasticity=self$options$Heteroscedasticity,
                     ResidDistr=self$options$Residuals,
                     world=makeWorld(worldOn=self$options$WorldOn,
                                     populationPDF=self$options$WorldPDF,
                                     populationRZ = self$options$WorldRZ,
                                     populationPDFk = self$options$WorldLambda,
                                     populationNullp = self$options$WorldNullP,
                                     populationPDFsample = self$options$WorldSample!="none",
                                     populationSamplemn = self$options$WorldMn,
                                     populationSamplesd = self$options$WorldSd,
                                     populationSamplebias = self$options$WorldSample=="bias"
                     )
  )
  
  
  hypothesis<-makeHypothesis(IV,IV2,DV,effect,layout=self$options$EffectConfig)
  setBrawDef("hypothesis",hypothesis)
  
  # set up the design variable
  #
  design<-makeDesign(sN=self$options$SampleSize,
                     sNRand=self$options$SampleSpreadOn,sNRandSD=self$options$SampleSD,
                     sNRandDist=self$options$SampleSizeDist,
                     sMethod=makeSampling(self$options$SampleMethod),
                     sMethodSeverity=self$options$PoorSamplingAmount,
                     sIV1Use=self$options$SampleUsage1,
                     sIV2Use=self$options$SampleUsage2,
                     sDependence=self$options$Dependence,
                     sOutliers=self$options$Outliers,
                     sNonResponse=self$options$NonResponse,
                     sIVRangeOn=self$options$LimitRangeIV=="yes", 
                     sIVRange=(c(self$options$RangeMinIV,self$options$RangeMaxIV)-braw.def$hypothesis$IV$mu)/braw.def$hypothesis$IV$sd, 
                     sIV2RangeOn=self$options$LimitRangeIV2=="yes", 
                     sIV2Range=(c(self$options$RangeMinIV2,self$options$RangeMaxIV2)-braw.def$hypothesis$IV$mu)/braw.def$hypothesis$IV$sd, 
                     sCheating=self$options$Cheating,sCheatingLimit="Budget",sCheatingBudget=self$options$CheatingBudget,
                     Replication=makeReplication(On=self$options$ReplicationOn,
                                                 Power=self$options$ReplicationPower,
                                                 Repeats=self$options$ReplicationAttempts,
                                                 Keep=self$options$ReplicationDecision,
                                                 forceSigOriginal=self$options$ReplicationSigOriginal=="yes",forceSign=(self$options$ReplicationSign=="yes"),
                                                 maxN=self$options$RepMaxN,
                                                 RepAlpha=self$options$ReplicationAlpha,
                                                 PowerPrior=self$options$ReplicationPrior
                     )
  )
  if (design$sNRand) design$sN<-self$options$SampleSizeM
  setBrawDef("design",design)
  
  # set up the evidence variable
  #
  switch(self$options$likelihoodUsePrior,
         "none"={
           prior<-makeWorld(worldOn=TRUE,
                            populationPDF="Uniform",
                            populationRZ="r",
                            populationNullp=0.5)
         },
         "world"={
           prior<-braw.def$hypothesis$effect$world
           prior$worldOn<-TRUE
         },
         "prior"={
           prior<-makeWorld(worldOn=TRUE,
                            populationPDF=self$options$priorPDF,
                            populationRZ=self$options$priorRZ,
                            populationPDFk=self$options$priorLambda,
                            populationNullp=self$options$priorNullP)
         })
  evidence<-makeEvidence(AnalysisTerms=1+(self$options$main2=="yes")+(self$options$interaction=="yes"),
                         ssqType=self$options$ssq,sigOnly=FALSE,
                         Welch=self$options$equalVar=="no",
                         Transform=self$options$Transform,
                         minRp=self$options$minRp,
                         shortHand=self$options$shorthandCalculations,
                         prior=prior,
                         doSEM=self$options$doSEM,useAIC=self$options$useAIC
  )
  setBrawDef("evidence",evidence)
  
  # set up the explore variable
  #
  switch(self$options$exploreMode,
         "hypothesisExplore"={
           typeExplore<-self$options$hypothesisExploreList
           minV<-as.numeric(self$options$exploreMinValH)
           maxV<-as.numeric(self$options$exploreMaxValH)
           xlog<-self$options$exploreXLogH
           exploreNPoints<-as.numeric(self$options$exploreNPointsH)
         },
         "designExplore"={
           typeExplore<-self$options$designExploreList
           minV<-as.numeric(self$options$exploreMinValD)
           maxV<-as.numeric(self$options$exploreMaxValD)
           xlog<-self$options$exploreXLogD
           exploreNPoints<-as.numeric(self$options$exploreNPointsD)
         },
         "analysisExplore"={
           typeExplore<-self$options$analysisExploreList
           minV<-as.numeric(self$options$exploreMinValA)
           maxV<-as.numeric(self$options$exploreMaxValA)
           xlog<-self$options$exploreXLogA
           exploreNPoints<-as.numeric(self$options$exploreNPointsA)
         },
         "moreExplore"={
           typeExplore<-self$options$moreExploreList
           minV<-as.numeric(self$options$exploreMinValM)
           maxV<-as.numeric(self$options$exploreMaxValM)
           xlog<-self$options$exploreXLogM
           exploreNPoints<-as.numeric(self$options$exploreNPointsM)
         }
  )
  explore<-makeExplore(exploreType=typeExplore,
                       exploreNPoints=exploreNPoints,
                       minVal=minV,maxVal=maxV,
                       xlog=xlog)
  setBrawDef("explore",explore)
  
  # set up the metaAnalysis variable
  #
  metaAnalysis<-makeMetaAnalysis(nstudies=self$options$MetaAnalysisNStudies,
                                 method=self$options$MetaAnalysisMethod,
                                 analysisType=self$options$MetaAnalysisType,
                                 analysisVar=self$options$MetaAnalysisRandVar,
                                 analysisPrior=self$options$MetaAnalysisPrior,
                                 modelPDF="All",
                                 sourceBias=self$options$MetaAnalysisStudiesSig,
                                 modelNulls=self$options$MetaAnalysisNulls=="yes",
                                 analyseBias=self$options$MetaAnalysisBias=="yes"
  )
  setBrawDef("metaAnalysis",metaAnalysis)
  
  
  setBrawEnv("alphaSig",self$options$alphaSig)
  setBrawEnv("RZ",self$options$dispRZ)
  setBrawEnv("STMethod",self$options$STMethod)
  
}