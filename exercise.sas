libname in "D:\courses\BSTcourse\survival\slides and homework\week 8";
data cocaine;
  set in.firstcocaine;
run;
proc contents data=cocaine;
run;
proc means data=cocaine;
var birthyr ;
run;
proc freq data=cocaine;
table mjyes sellmjyes odyes sdyes earlymj;
run;

*Fit a general stratified PH model based on the SAS scripts from the previous slide. Check whether earlymj, mjyes, sellmjyes, odyes and
sdyes  are time-dependent;
proc phreg data=cocaine;;
  model cokeage*censor(1)= birthyr earlymj mjyes  sellmjyes odyes  sdyes earlymjtime mjyestime sellmjyestime odyestime sdyestime/ties = efron;
earlymjtime=earlymj*cokeage; 
mjyestime=mjyes*cokeage ;
sellmjyestime=sellmjyes*cokeage;
odyestime=odyes*cokeage ;
sdyestime=sdyes*cokeage;
title ' check the PH assumption cox regression model with time-independent variables';
run;
*the variable earlymj and mjyes are time dependent variables.;

*Fit a PH model with and without the stratum variable that violates the PH assumption, respectively. Compare  the HRs 
derived from the models with and without stratification.stratify and time dependent variable;
proc phreg data=cocaine;
  model cokeage*censor(1)= birthyr  earlymj mjyes  sellmjyes odyes sdyes /ties = efron;
  title' cox regression model without stratification';
run;

proc phreg data=cocaine;
  model cokeage*censor(1)= birthyr  sellmjyes odyes  sdyes /ties = efron;
strata mjyes earlymj;
title 'cox regression model with stratification ';
run;

*Since the age at onset of mjyes  sellmjyes odyes  sdyes may precede or follow cocaine use, you want to treat anyone whose age at onset of 
mjyes  sellmjyes odyes  sdyes is equal to or after the age at onset of cocaine initiation as censored a case by creating new corresponding 
variables (i.e. usedmj soldmj, used od, and moreod); 

*This is another way to check if I use the mj or sellmj or od or sdy before use cocaine has any effect on addict to cocaine, so people who use 
the mj, sellmj, od, sd before use cocaine are investigated and coded with a new variable. ;
proc phreg data=cocaine;
model cokeage*censor(1)=birthyr rural usedmj soldmj usedod usedsd/ties=efron;
if mjyes=1 and mjage < cokeage then usedmj=1;
else usedmj=0;
if sellmjyes=1 and sellmjage < cokeage then soldmj=1;
else soldmj=0;
if odyes=1 and odage < cokeage then usedod=1;
else usedod=0;
if sdyes=1 and sdage< cokeage then usedsd=1;
else usedsd=0;
run;


*Fit the new stratified PH model to the data and interpret the HRs.
Fit the new PH model to the data stratified by rural variable and interpret the HRs.;
Data adjust;
  input birthyr mjyes sellmjyes odyes sdyes label$;
  length label $20;
  datalines;
  6 1 1 1 0 M_Y_S_Y_O_Y_S_N
  2 0 0 0 1 M_N_S_N_O_N_S_Y
;
RUN;



*a K-M plot with and without strata RURAL and earlymj.you can stratify together just different meaning;
proc lifetest data=cocaine plots=s notable;
time cokeage*censor(1);
strata rural ;
title 'K-M plot with and without strata RURAL';
run;

proc lifetest data=cocaine plots=s notable;
time cokeage*censor(1);
strata earlymj;
title 'K-M plot with and without strata earlymj';
run;

*an adjusted survival curve from the Cox model without stratification. adjusted the mean of indepedent variable, otherwise we can
define a new covariates models;
proc phreg data=cocaine plots=survival;
model  cokeage*censor(1)= birthyr earlymj mjyes sellmjyes odyes  sdyes /ties = efron;
title 'an adjusted survival curve from the Cox model without stratification.';
run;


*an adjusted survival curves from the stratified Cox model stratified by rural and earlymj. Use Proc SGPlot to overlay multiple 
curves on  the one plot.   Compare four plots;
proc phreg data=cocaine plots(overlay=byrow)=s;
model cokeage*censor(1)=birthyr mjyes sellmjyes odyes sdyes/ties=efron;
strata earlymj;
baseline covariates=adjust out=earlymjsur survival=sur lower=cl upper=ucl;
title ' an adjusted survival curves from the stratified Cox model stratified by earlymj';
title2 'checking the PH assumption for earlymj';
run;
proc sgplot data=earlymjsur ;
series y=sur x=cokeage/group=earlymj;
yaxis label='adjusted survival probability';
xaxis label='cocaine time';
run;


proc phreg data=cocaine plots(overlay=byrow)=s;
model cokeage*censor(1)=birthyr  mjyes sellmjyes odyes sdyes/ties=efron;
strata rural;
baseline covariates=adjust out=ruralsur survival=s lower=cl upper=ucl;
title ' an adjusted survival curves from the stratified Cox model stratified by rural';
title1' checking the PH assumption for rural';
run;

proc sgplot data=ruralsur ;
series y=s x=cokeage/group=rural;
yaxis label='adjusted survival probability';
xaxis label='cocaine time';
run; 



*Evaluate if the interactions between rural and sellmjyes and between rural and odyes are statistically significant using LR chisquare test.
Draw your conclusion based on the LR chisquare test results.
;
proc phreg data=cocaine ;
model cokeage*censor(1)=birthyr mjyes sellmjyes odyes sdyes /ties=efron ;
strata rural;
title' likelihood ratio chisquare test for interaction ';
title2'model 1 main effects';
run;

proc phreg data=cocaine;
model cokeage*censor(1)=birthyr mjyes sellmjyes odyes sdyes rural*sellmjyes rural*odyes/ties=efron;
strata rural;
title ' likelihood ratio chisquare test for interaction';
title2 'model 2 with interaction';
run; 

* p-value is 0.97 the null hypothesis is not rejected. The impact pf sellmy and od on the age of cocaine is not dependening on the rural level;
 

ods output globaltests(match_all persist=proc)=lrtest;
proc phreg data=cocaine;
model cokeage*censor(1)=birthyr mjyes sellmjyes odyes sdyes /ties=efron ;
strata rural;
title' likelihood ratio chisquare test for interaction ';
title2'model 1 main effects';
run;

proc phreg data=cocaine;
model cokeage*censor(1)=birthyr mjyes sellmjyes odyes sdyes rural*sellmjyes rural*odyes/ties=efron;
strata rural;
title ' likelihood ratio chisquare test for interaction';
title2 'model 2 with interaction';
run; 
ods output close;

data report;
merge lrtest(rename=(chisq=chisq1 df=df1))
      lrtest1(rename=(chisq=chisq2 df=df2));
	  if test='Likelihood Ratio';
	  chisq=chisq2-chisq1;
	  df=df2-df1;
	  pvalue=1-probchi(chisq,df);
	  title 'likelihood ratio chisquare test for strata*covariate';
	  run;
proc print data=report split='*' noobs;
var chisq df pvalue;
label chisq='likelihood ratio*Test statistics*Comparing*Model2 and Model1'
df='degree of freedom'
pvalue='P-value';
title 'LR test for interaction of strata*covariate';
run;
*
Interpret HR and 95% CI for usedmj derived from a stratified PH model that includes birthyr, usedmj, soldmj, usedod, moreod, and usedmj*rural 
and is stratified by rural variable;
proc phreg data=cocaine;
model cokeage*censor(1)=birthyr usedmj soldmj usedod usedsd usedmj*rural/ties=efron;
if mjyes=1 and mjage < cokeage then usedmj=1;
else usedmj=0;
if sellmjyes=1 and sellmjage < cokeage then soldmj=1;
else soldmj=0;
if odyes=1 and odage < cokeage then usedod=1;
else usedod=0;
if sdyes=1 and sdage< cokeage then usedsd=1;
else usedsd=0;
strata rural;
hazardratio usedmj/at(rural=0 1);
run;
*In the urban and subunban area, the people who use mj has 10 times hazard of taking  cocaine than person do not use mj.  The 95% confidence
interval is (6.123 20.859 )
In the rural area, the people who use mj has 12 times higher to use cocaine than person do not use mj.The 95% confidence 
interval is (4.020 43.663 ) very wide not accurate. ;

 
*Interpret HR and 95% CI for rural derived from a stratified PH model that includes birthyr, rural, mjyes, odyes, sdyes,
sellmjyes , and rural*earlymj and is stratified by earlymj variable.;
proc phreg data=cocaine;
  model cokeage*censor(1)= birthyr rural  mjyes  sellmjyes odyes  sdyes rural*earlymj/ties = efron;
  strata earlymj;
  hazardratio rural /at(earlymj=0 1);
  title' cox regression model without stratification';
  run;
* For people who do not has earlymj and  living rural area, the relative risk of taking cocaine is reduce by 21 percent than people living in the  urban and 
  suburban area.The 95% confidence interval is (0.576 1.105)
  For people who has earlymj and living in rural area, the relative risk of taking cocaine is reduce 0.6 percent than people living in the 
  urban and suburban area. The confidence interval is (0.526 1.878 );
 
