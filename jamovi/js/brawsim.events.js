const events =  {
    // in here is where the event functions go

    onChange_basics9A: function(ui) {
      let rModerate = ui.doBasics9AModerationEffect.value();
          ui.doBasics9AMain1Effect.setValue(0);
          ui.doBasics9AMain2Effect.setValue(0);
          ui.doBasics9AInteractionEffect.setValue(-rModerate);
    },
    
    onChange_doBasics9B: function(ui) {
      let rModerate = ui.doBasics9BModerationEffect.value();
          ui.doBasics9BMain1Effect.setValue(-rModerate);
          ui.doBasics9BMain2Effect.setValue(0);
          ui.doBasics9BInteractionEffect.setValue(-rModerate);
    },
    
    onChange_doBasics9C: function(ui) {
      let rModerate = ui.doBasics9CModerationEffect.value();
          ui.doBasics9CMain1Effect.setValue(rModerate);
          ui.doBasics9CMain2Effect.setValue(rModerate+sign(rModerate)*(1-abs(rModerate))/2);
          ui.doBasics9CInteractionEffect.setValue(-rModerate);
    },
    
    onChange_doBasics10C: function(ui) {
      let rModerate = ui.doBasics10Cmediation.value();
          ui.doBasics10CMain1Effect.setValue(0.36*(1-rModerate));
          ui.doBasics10CMain2Effect.setValue(0.6*rModerate);
          ui.doBasics10CCovariationEffect.setValue(0.6*rModerate);
    },
    
    onChange_effectSize: function(ui) {
      let rIV = ui.EffectSize1.value();
      let rIV2 = ui.EffectSize2.value();
      let rIVIV2 = ui.EffectSize3.value();
      let rIVIV2DV = ui.EffectSize12.value();
      // check effect sizes 
      let fullES = rIV^2+rIV2^2+2*rIV*rIV2*rIVIV2+rIVIV2DV^2;
      if (fullES>=1) {
        while (fullES>=1) {
          rIV = rIV*0.9;
          rIV2 = rIV2*0.9;
          rIVIV2 = rIVIV2*0.9;
          rIVIV2DV = rIVIV2DV*0.9;
          fullES = rIV^2+rIV2^2+2*rIV*rIV2*rIVIV2+rIVIV2DV^2;
        }
      ui.EffectSize1.setValue(rIV);
      ui.EffectSize2.setValue(rIV2);
      ui.EffectSize3.setValue(rIVIV2);
      ui.EffectSize12.setValue(rIVIV2DV);
      }
    },
    
    onChange_MetaAnalysisType: function(ui) {
      const simpleVals = new Set(["metaRiv", "metaRsd", "metaSmax", "metaBias"]);
      let ma_type = ui.MetaAnalysisType.value();
      let ma_bias = ui.MetaAnalysisBias.value();
      let var1 = ui.metaVar1.value();
      let var2 = ui.metaVar2.value();
      switch(ma_type) {
        case "fixed":
          if (!simpleVals.has(var1)) {
            ui.metaVar1.setValue("metaRiv");
          };
          if (!simpleVals.has(var2)) {
            if (ma_bias) {
              ui.metaVar2.setValue("metaBias");
            } else {
              ui.metaVar2.setValue("metaSmax");
            }
          };
        break;
        case "random":
          if (!simpleVals.has(var1)) {
            ui.metaVar1.setValue("metaRiv");
          };
          if (!simpleVals.has(var2)) {
            ui.metaVar2.setValue("metaRsd");
          };
        break;
        case "world":
          if (simpleVals.has(var1)) {
            ui.metaVar1.setValue("metaK");
          };
          if (simpleVals.has(var2)) {
            if (ma_bias) {
              ui.metaVar2.setValue("metaBias");
            } else {
              ui.metaVar2.setValue("metaSmax");
            }
          };
        break;
      }
    },
    
    onChange_exploreMode: function(ui) {
      var newRange = {min:0.3,max:0.7,xlog:false,np:8};
      let mode = ui.exploreMode.value();
      let value="n";
      switch(mode) {
        case "hypothesisExplore":
          value = ui.hypothesisExploreList.value();
          var newRange = updateRange(value);
              ui.exploreMinValH.setValue(newRange.min);
              ui.exploreMaxValH.setValue(newRange.max);
              ui.exploreXLogH.setValue(newRange.xlog);
              ui.exploreNPointsH.setValue(newRange.np);
          break;
        case "designExplore":
          value = ui.designExploreList.value();
          var newRange = updateRange(value);
              ui.exploreMinValD.setValue(newRange.min);
              ui.exploreMaxValD.setValue(newRange.max);
              ui.exploreXLogD.setValue(newRange.xlog);
              ui.exploreNPointsD.setValue(newRange.np);
          break;
        case "analysisExplore":
          value = ui.analysisExploreList.value();
          var newRange = updateRange(value);
              ui.exploreMinValA.setValue(newRange.min);
              ui.exploreMaxValA.setValue(newRange.max);
              ui.exploreXLogA.setValue(newRange.xlog);
              ui.exploreNPointsA.setValue(newRange.np);
          break;
        case "moreExplore":
          value = ui.moreExploreList.value();
          var newRange = updateRange(value);
              ui.exploreMinValM.setValue(newRange.min);
              ui.exploreMaxValM.setValue(newRange.max);
              ui.exploreXLogM.setValue(newRange.xlog);
              ui.exploreNPointsM.setValue(newRange.np);
          break;
      };
      return;
  },

    onChange_hypothesisExploreList: function(ui) {
          let value = ui.hypothesisExploreList.value();
          let newRange = updateRange(value)
          ui.exploreMinValH.setValue(newRange.min);
          ui.exploreMaxValH.setValue(newRange.max);
          ui.exploreXLogH.setValue(newRange.xlog);
          ui.exploreNPointsH.setValue(newRange.np);
      return;
  },
    onChange_designExploreList: function(ui) {
          let value = ui.designExploreList.value();
          let newRange = updateRange(value)
          ui.exploreMinValD.setValue(newRange.min);
          ui.exploreMaxValD.setValue(newRange.max);
          ui.exploreXLogD.setValue(newRange.xlog);
          ui.exploreNPointsD.setValue(newRange.np);
      return;
  },
    onChange_analysisExploreList: function(ui) {
          let value = ui.analysisExploreList.value();
          let newRange = updateRange(value)
          ui.exploreMinValA.setValue(newRange.min);
          ui.exploreMaxValA.setValue(newRange.max);
          ui.exploreXLogA.setValue(newRange.xlog);
          ui.exploreNPointsA.setValue(newRange.np);
  },
    onChange_moreExploreList: function(ui) {
          let value = ui.moreExploreList.value();
          let newRange = updateRange(value)
          ui.exploreMinValM.setValue(newRange.min);
          ui.exploreMaxValM.setValue(newRange.max);
          ui.exploreXLogM.setValue(newRange.xlog);
          ui.exploreNPointsM.setValue(newRange.np);
  },

    onChange_presetDV: function(ui) {
      let presetDV = ui.presetDV.value();
      let variable = makeVar(presetDV);
          ui.DVname.setValue(variable.name);
          ui.DVtype.setValue(variable.type);
          ui.DVmu.setValue(variable.mu);
          ui.DVsd.setValue(variable.sd);
          ui.DVskew.setValue(variable.skew);
          ui.DVkurt.setValue(variable.kurt);
          ui.DVnlevs.setValue(variable.nlevs);
          ui.DViqr.setValue(variable.iqr)
          ui.DVncats.setValue(variable.ncats);
          ui.DVcases.setValue(variable.cases)
          ui.DVprops.setValue(variable.props);
    },

    onChange_presetIV: function(ui) {
      let presetIV = ui.presetIV.value();
      let oldmu = ui.IVmu.value();
      let oldsd = ui.IVsd.value();
      let variable = makeVar(presetIV);
          ui.IVname.setValue(variable.name);
          ui.IVtype.setValue(variable.type);
          ui.IVmu.setValue(variable.mu);
          ui.IVsd.setValue(variable.sd);
          ui.IVskew.setValue(variable.skew);
          ui.IVkurt.setValue(variable.kurt);
          ui.IVnlevs.setValue(variable.nlevs);
          ui.IViqr.setValue(variable.iqr);
          ui.IVncats.setValue(variable.ncats);
          ui.IVcases.setValue(variable.cases)
          ui.IVprops.setValue(variable.props);
    },

    onChange_presetIV2: function(ui) {
      let presetIV2 = ui.presetIV2.value();
      if (presetIV2!="none") {
      let variable = makeVar(presetIV2);
          ui.IV2name.setValue(variable.name);
          ui.IV2type.setValue(variable.type);
          ui.IV2mu.setValue(variable.mu);
          ui.IV2sd.setValue(variable.sd);
          ui.IV2skew.setValue(variable.skew);
          ui.IV2kurt.setValue(variable.kurt);
          ui.IV2nlevs.setValue(variable.nlevs);
          ui.IV2iqr.setValue(variable.iqr)
          ui.IV2ncats.setValue(variable.ncats);
          ui.IV2cases.setValue(variable.cases)
          ui.IV2props.setValue(variable.props);
      }
    },

    onChange_presetWorld: function(ui) {
      let presetH = ui.presetWorld.value();
      switch(presetH) {
        case "Psych50":
          ui.WorldOn.setValue(true);
          ui.WorldPDF.setValue("Exp");
          ui.WorldRZ.setValue("z");
          ui.worldMeanRplus.setValue(0.3);
          ui.worldPRnull.setValue(0.5);
          ui.WorldSample.setValue("none");
          break;
        case "Uniform":
          ui.WorldOn.setValue(true);
          ui.WorldPDF.setValue("Uniform");
          ui.WorldRZ.setValue("r");
          ui.worldMeanRplus.setValue(0.3);
          ui.worldPRnull.setValue(0.0);
          ui.WorldSample.setValue("none");
          break;
        case "Binary":
          ui.WorldOn.setValue(true);
          ui.WorldPDF.setValue("Single");
          ui.WorldRZ.setValue("r");
          ui.worldMeanRplus.setValue(0.3);
          ui.worldPRnull.setValue(0.5);
          ui.WorldSample.setValue("none");
          break;
        case "Plain":
          ui.WorldOn.setValue(true);
          ui.WorldPDF.setValue("Single");
          ui.WorldRZ.setValue("r");
          ui.worldMeanRplus.setValue(0.3);
          ui.worldPRnull.setValue(0);
          ui.WorldSample.setValue("none");
          break;
      }
    },
    
    onChange_Single: function(ui) {
      ui.whichGraph.setValue("Single")
    },
    
    onChange_metaDefaultN: function(ui) {
      let variable1 = ui.metaDefaultN.value()
      variable1 = Number(variable1)
      ui.meta2SampleSize.setValue(variable1*2)
      ui.meta2SampleBudget.setValue(variable1*2)
      ui.meta4SampleSize.setValue(variable1)
    },
    
    onChange_metaDefaultpRplus: function(ui) {
      let variable1 = ui.metaDefaultpRplus.value()
      variable1 = Number(variable1)
      ui.meta1pRplus.setValue(variable1)
      ui.meta2pRplus.setValue(variable1)
      ui.meta3pRplus.setValue(variable1)
      ui.meta4pRplus.setValue(variable1)
    },
    
    onChange_metaDefaultRp: function(ui) {
      let variable1 = ui.metaDefaultRp.value()
      variable1 = Number(variable1)
      ui.meta1rp.setValue(variable1)
      ui.meta2rp.setValue(variable1)
      ui.meta3rp.setValue(variable1)
      ui.meta4rp.setValue(variable1)
    },
    
}

let defaultSetUp = function(ui) {
      ui.DVtype.setValue("Interval")
        ui.presetIV2.setValue("none")
        ui.IVtype.setValue("Interval")
      ui.EffectSize1.setValue(0.3)
        ui.EffectSize2.setValue(0)
        ui.EffectSize3.setValue(0)
        ui.EffectSize12.setValue(0)
        ui.WorldOn.setValue(false)
      ui.EffectConfig.setValue("normal")
      ui.SampleSpreadOn.setValue(false)
      ui.SampleSize.setValue(42)
        ui.SampleMethod.setValue("Random")
      ui.useAIC.setValue("none")
      ui.inferVar1.setValue("rs")
      ui.inferVar2.setValue("p")
      ui.showInferDimension.setValue("1D")
        ui.showMultipleParam.setValue("Basic")
        ui.showMultipleDimension.setValue("1D")
}


let makeVar = function(name) {
  switch (name) {
    case "DV":
      var variable={name:"DV",type:"Interval",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "IV":
      var variable={name:"IV",type:"Interval",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "IV2":
      var variable={name:"IV2",type:"Interval",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "IQ":
      var variable={name:"IQ",type:"Interval",mu:100,sd:15,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "Diligence":
      var variable={name:"Diligence",type:"Interval",mu:0,sd:2,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "Perfectionism":
      var variable={name:"Perfectionism",type:"Interval",mu:0,sd:2,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "Anxiety":
      var variable={name:"Anxiety",type:"Interval",mu:5,sd:2,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "Happiness":
      var variable={name:"Happiness",type:"Interval",mu:50,sd:12,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "SelfConfidence":
      var variable={name:"SelfConfidence",type:"Interval",mu:50,sd:12,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "HoursSleep":
      var variable={name:"HoursSleep",type:"Interval",mu:7,sd:1,skew:-0.7,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "ExamGrade":
      var variable={name:"ExamGrade",type:"Interval",mu:55,sd:10,skew:-0.6,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "ExamPass":
      var variable={name:"ExamPass?",type:"Categorical",mu:55,sd:10,skew:-0.6,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"no,yes",props:"1,3"};
      break;
    case "RiskTaking":
      var variable={name:"RiskTaking",type:"Interval",mu:30,sd:6,skew:0.5,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "Interesting":
      var variable={name:"Interesting",type:"Interval",mu:10,sd:2,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"C1,C2",props:"1,1"};
      break;
    case "Musician":
      var variable={name:"Musician?",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"no,yes",props:"1,1"};
      break;
    case "RiskTaker":
      var variable={name:"RiskTaker?",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"no,yes",props:"1,1"};
      break;
    case "Smoker":
      var variable={name:"Smoker?",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"no,yes",props:"2,1"};
      break;
    case "Outcome":
      var variable={name:"Outcome",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"-ve,+ve",props:"1.2,1"};
      break;
    case "Sessions":
      var variable={name:"Sessions",type:"Ordinal",mu:0,sd:1,skew:0,kurt:0,
      nlevs:6,iqr:3,
      ncats:2,cases:"+ve,-ve",props:"0.1,0.2,0.4,0.4,0.6,0.8"};
      break;
    case "StudySubject":
      var variable={name:"StudySubject",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:3,cases:"psych,phil,sports",props:"1.5,1,2"};
      break;
    case "BirthOrder":
      var variable={name:"BirthOrder",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:4,cases:"first,middle,last,only",props:"1,0.4,0.6,0.2"};
      break;
    case "Treatment":
      var variable={name:"Treatment?",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"no,yes",props:"1,1"};
      break;
    case "Phase":
      var variable={name:"Phase",type:"Categorical",mu:0,sd:1,skew:0,kurt:0,
      nlevs:7,iqr:3,
      ncats:2,cases:"before,after",props:"1,1"};
      break;
  }
  return variable;
}

let makeRange = function(min,max,xlog,np) {
  this.min=min;
  this.max=max;
  this.xlog=xlog;
  this.np=np;
}

  let  updateRange = function(value) {
      switch (value) {
        case "n":
           var range={min:10,max:250,xlog:true,np:11};
          break;
        case "rIV":
           var range={min:0,max:0.75,xlog:false,np:11};
          break;
        case "rIV2":
        case "rIVIV2":
        case "rIVIV2DV":
           var range={min:-0.75,max:0.75,xlog:false,np:11};
          break;
        case "rSD":
           var range={min:0,max:0.4,xlog:false,np:11};
          break;
        case "IVskew":
        case "DVskew":
        case "Heteroscedasticity":
        case "Dependence":
        case "Outliers":
        case "IVRange":
        case "DVRange":
             var range={min:0,max:1,xlog:false,np:11};
          break;
        case "IVkurtosis":
        case "DVkurtosis":
           var range={min:1.5,max:100000,xlog:true,np:11};
          break;
        case "IVprop":
        case "DVprop":
             var range={min:0.2,max:0.8,xlog:false,np:11};
          break;
        case "IVcats":
        case "DVcats":
             var range={min:2,max:6,xlog:false,np:5};
          break;
        case "IVlevels":
        case "DVlevels":
             var range={min:3,max:10,xlog:false,np:8};
          break;
        case "WithinCorr":
             var range={min:0,max:1,xlog:false,np:11};
          break;
        case "Alpha":
             var range={min:0.001,max:0.5,xlog:true,np:11};
          break;
        case "minRp":
             var range={min:0,max:0.5,xlog:false,np:11};
          break;
        case "Power":
             var range={min:0.1,max:0.9,xlog:false,np:11};
          break;
        case "Repeats":
             var range={min:0,max:8,xlog:false,np:9};
          break;
        case "pNull":
             var range={min:0,max:1,xlog:false,np:11};
          break;
        case "lambda":
             var range={min:0.1,max:1,xlog:false,np:11};
          break;
        case "PoorSamplingAmount":
             var range={min:0,max:0.2,xlog:false,np:11};
          break;
        case "CheatingAmount":
             var range={min:0,max:0.8,xlog:false,np:11};
          break;
        case "ClusterRad":
             var range={min:0,max:1,xlog:false,np:11};
          break;
        case "SampleSD":
             var range={min:1,max:100,xlog:true,np:11};
          break;
        case "IVType":
             var range={min:"",max:"",xlog:false,np:5};
          break;
        case "DVType":
             var range={min:"",max:"",xlog:false,np:5};
          break;
        case "PDF":
             var range={min:"",max:"",xlog:false,np:7};
          break;
        case "Method":
             var range={min:"",max:"",xlog:false,np:5};
          break;
        case "Usage":
             var range={min:"",max:"",xlog:false,np:2};
          break;
        case "NoSplits":
             var range={min:1,max:32,xlog:true,np:6};
          break;
        case "IVRangeC":
             var range={min:0.1,max:3,xlog:false,np:11};
          break;
        case "IVRangeE":
             var range={min:-3,max:3,xlog:false,np:11};
          break;
        case "Cheating":
             var range={min:"",max:"",xlog:false,np:6};
          break;
        case "Transform":
             var range={min:"",max:"",xlog:false,np:3};
          break;
        case "Welch":
             var range={min:"",max:"",xlog:false,np:2};
          break;
        case "Keep":
             var range={min:"",max:"",xlog:false,np:5};
          break;
        case "NoStudies":
             var range={min:2,max:100,xlog:true,np:11};
          break;
        case "MetaType":
             var range={min:"",max:"",xlog:false,np:4};
          break;
        default: 
             var range={min:0,max:1,xlog:false,np:11};
          break;
      }
      return range;
    };

module.exports = events;
