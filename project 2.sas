libname myfiles1  'D:\courses\BSTcourse\survival\slides and homework\project\project 2';
run;
data project;
set myfiles1.whas500;
label id='identification code'
      age='age at hospital admission'
	  hr='initial heart rate'
	  sysbp='initial systolic blood pressure'
	  diasbp='Initial Diastolic Blood Pressure'
	  bmi='Body Mass Index'                 	
      cvd='History of Cardiovascular Disease'       	                   	
      afb='Atrial Fibrillation' 
      sho='Cardiogenic Shock'               	
      chf='Congestive Heart Complications'	                    
      av3='Complete Heart Block'            	
      miord='MI Order'                        		
      mitype='MI Type'                        		
      year='Cohort Year'                     		
      los='Length of Hospital Stay' /*Days between Hospital Admission & Hospital Discharge*/        
      dstat='Discharge Status from Hospital'                     
      lenfol='Total Length of Follow-up ' /*Days between Hospital Admission & Hospital Discharge*/      	
      fstat='Vital Status at Last Follow-up';
	  /*gender 0 = Male, 1 = Female8*/ 
	run;

*1.	Two dependent variables are the time to hospital discharge and time to mortality after discharge.
The independent variables include age, BMI, cohort year, sysbp, sho and chf. All six independent variables should be included in every Cox regression model unless a special model is instructed. 
Both outcomes must be examined in following tests. All test results are assumed to be obtained from Proc PHREG.
2.	Describe the classical and extended Cox models to be used (3 points) and methods to evaluate the proportional assumption (2 points).;

proc phreg data=project;
model los*dstat(0)=gender age bmi sysbp sho year chf /ties=efron;
title 'classical Cox model during lenght of hospital stay';
run;
*For epidemiology, gender effect is always effect the results no matter weather is was significant difference. ;


proc phreg data=project;
model lenfol*fstat(0)=age bmi gender year sysbp sho chf/ties=efron;
title 'classical Cox model  during follow-up';
run;


*only sho not hold for the PH assumption;

*3.	Evaluate the proportional hazards assumption using the following methods: 
i.	Use a graphical approach by producing log-negative-log (LLS) plots against log-transformed survival time to evaluate 
the proportional hazards assumption for chf and sho, respectively (4 points). Interpret the plot results (4 points).;

proc lifetest data=project plots=(lls s ls) notable;
time los*dstat(0);
strata chf;
title 'checking PH assumption for chf during hospital stay using graphical approach ';
run;

proc lifetest data=project plots=(lls s ls) notable;
time los*dstat(0);
strata sho;
title 'checking PH assumption for sho during hospital stay using graphical approach';
run;

proc lifetest data=project plots=(lls s ls) notable;
time lenfol*fstat(0);
strata chf;
title 'checking PH assumption for chf in  follow-up using graphical approach ';
run;

proc lifetest data=project plots=(lls s ls) notable;
time lenfol*fstat(0);
strata sho;
title 'checking PH assumption for sho in follow-up using graphical approach';
run;


*ii Use Schoenfeld residuals to evaluate the proportional hazards assumption for age and sho in a Cox model that includes age, BMI, 
cohort year, sysbp, sho and chf (2 points), assuming that all variables but age and sho are known to satisfy the proportional assumption.
Both Pearson’s correlation coefficient test and graphical approach (i.e a Loess curve using Proc SGPlot) are required to show whether the
Schoenfeld residuals are independent of ranked log-transformed failure time variables (10 points). Develop a null hypothesis for each variable 
(4 points).  Interpret plots results and the statistical results and draw your conclusion if age and sho meet the proportional hazards assumption
for both outcomes (8 points).;


proc phreg data=project;
model los*dstat(0)=age bmi year sysbp sho chf/ties=efron;
output out=schhos ressch=schage schbmi schyear schsysbp schsho schchf;
title 'checking the PH assumption using the Schoenfeld residuals during hospital stay';
run;

*Pearson’s correlation coefficient test;
data schhosp;
set schhos;
ldays=log(los);
run;
proc rank data=schhosp out=sch_hospital;
var ldays;
ranks logtime;
run;
proc corr data=sch_hospital;
var logtime; with schage schsho;
run;

*graphical approach (i.e a Loess curve using Proc SGPlot);

proc sgplot data=sch_hospital;
loess x=logtime y=schage/clm;
title 'usin sgplot to check PH assumption for age during hospital stay';
run;
proc sgplot data=sch_hospital;
loess x=logtime y=schsho/clm;
title 'using sgplot to check PH assumption for sho during hospital stay';
run;

proc phreg data=project;
model lenfol*fstat(0)=age bmi year sysbp sho chf/ties=efron;
output out=schfol ressch=schage schbmi schyear schsysbp schsho schchf;
title 'checking the PH assumption using the Schoenfeld residuals during hospital stay';
run;


*Pearson’s correlation coefficient test;
data schfoll;
set schfol;
ldays=log(lenfol);

proc rank data=schfoll out=sch_followup;
var ldays;
ranks logtime;
run;

proc corr data=sch_followup;
var logtime; with  schage schsho;
run;

proc sgplot data=sch_followup;
loess x=logtime y=schage/clm;
title 'usin sgplot to check PH assumption for age during follow up period';
run;
proc sgplot data=sch_followup;
loess x=logtime y=schsho/clm;
title 'using sgplot to check PH assumption for sho during follow up period';
run;



*iii.Form appropriate time by covariate interaction terms using Proc PHREG and use this method to evaluate whether 
age, BMI, sysbp, sho and chf satisfy the proportion hazards assumption in a Cox model that includes age, BMI, cohort year, 
sysbp, sho and chf for the total length of follow-up time (5 points). The time variable to be used to form the interaction term is a 
logarithm transformation of lenfol (i.e. log(lenfol). 
Interpret the Wald chi-square results based on the p-values and draw your conclusion which covariates meet the proportional
hazards assumption and which covariate does not for the total length of follow-up time (10 points).;

proc phreg data=project;
model lenfol*fstat(0)=age bmi year sysbp sho chf agetime bmitime sysbptime shotime chftime/ties=efron;
agetime=age*lenfol;
bmitime=bmi*lenfol;
sysbptime=sysbp*lenfol;
shotime=sho*lenfol;
chftime=chf*lenfol;
title 'extended Cox model to evaluate the proportional assumption during follow-up';
run;




*4 	Based on the test results of the proportional hazard assumption obtained in #3.iii,  you will 
specify a final Cox model including the dependent variable of the length of follow up (i.e. lenfol) and
independent variables: age, BMI, cohort year, sysbp, chf, sho, and an appropriate time interaction term 
(i.e. involving lenfol variable). (2 point) Show and interpret the adjusted HR and 95%CI for BMI based on every 
5-unit increase. (4 points) Calculate a correct HR for sho at 250, 500, 1000, and 1500 days, respectively.  (4 points) Interpret 
adjusted HRs for sho (4 points). Then draw a conclusion about the time effect on sho. (2 point) ;

proc phreg data=project;
model lenfol*fstat(0)=age bmi year sysbp sho chf shotime /ties=efron;
shotime=sho*lenfol;
hazardratio bmi/units=5;
title 'extended Cox model to evaluate the proportional assumption during follow-up';
run;


*5.	Based on the result of question 4. Estimate adjusted hazards ratio (HR) and 95% confidence interval of BMI, age and chf using a Cox regression model that 
is stratified by sho and includes independent variables:  age, BMI, cohort year , sysbp, and chf. Discuss the
assumption of the stratification (2 points). Show and interpret the adjusted HR for BMI (i.e. every 5 units), age (i.e. every 10 years) 
and chf from the stratified Cox models. (8 points) Only for follow-up time;


proc phreg data=project;
model lenfol*fstat(0)=age bmi year sysbp chf/ties=efron rl;
strata sho;
hazardratio bmi/units=5;
hazardratio age/units=10;
hazardratio chf;
title 'stratified Cox regression model during follow up';
run;

*6.	Are the associations expressed as HRs for sysbp and chf different between 
non-stratified and stratified Cox regression models for the outcome of total length of follow-up? (2 points). ;

proc phreg data=project;
model lenfol*fstat(0)=age bmi year sysbp chf/ties=efron rl;
title ' non-stratified Cox Regression models for the outcome of total length of follow-up';
run;

