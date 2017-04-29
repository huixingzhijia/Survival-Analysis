libname myfiles  'D:\courses\BSTcourse\survival\slides and homework\project\project 1';
run;
data project;
set myfiles.whas500;
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
proc print data=project;
run;


/*data summary for introduction */
proc freq data=project;
table gender fstat dstat;
run;
proc means data=project;
var age;
run;

/* Summarize the descriptive statistics for two dependent variables, cohort year, chf, and sho
stratified by gender in a table or figure (Hints: PROC MEANS for continuous variables and PROC FREQ for categorical variables). (6 points)*/
proc sort data=project;
	by gender;
run; 
proc means data=project;
	var los lenfol ;
	by gender;
run; 

proc freq data=project;
	tables year chf sho ;
	by gender;
run; 

/*Use Kaplan-Meier method (shown in figures) to estimate the survival curves for each outcome variable 
(2 points) and interpret the results. (2 points) */
proc lifetest plots=survival(atrisk) data=project ;
	time los*dstat(0);
	title 'K-M method for length of hospital stay';
run;
proc lifetest plots=survival(atrisk) data=project ;
	time lenfol*fstat(0);
	title 'K-M method after hospital discharge';
run;
/*Graphically display the Kaplan-Meier survivor curves for each outcome variable stratified by gender, 
cohort year, chf, and sho, respectively. (8 points) Compare and interpret the median differences in the survivor curves. (8 points) */

proc lifetest plots=survival(atrisk) data=project ;
	time los*dstat(0); 
	strata gender;
	title 'K-M method for length of hospital stay by gender';
run;

proc lifetest plots=survival(atrisk) data=project ;
	time los*dstat(0); 
	strata year;
	title 'K-M method for length of hospital stay by cohort year';
run;

proc lifetest plots=survival(atrisk) data=project;
	time los*dstat(0); 
	strata chf;
	title 'K-M method for length of hospital stay by congestive heart complications';
run;

proc lifetest plots=survival(atrisk) data=project;
	time los*dstat(0); 
	strata sho;*/test=wilcoxon;
	title 'K-M method for length of hospital stay by cardiogenic shock';
run;

proc lifetest plots=survival(atrisk) data=project ;
	time lenfol*fstat(0);
	strata gender;
	title 'K-M method after hospital discharge by gender';
run;

proc lifetest plots=survival(atrisk) data=project ;
	time lenfol*fstat(0);
	strata year;
	title 'K-M method after hospital discharge by cohort year';
run;

proc lifetest plots=survival(atrisk) data=project ;
	time lenfol*fstat(0);
	strata chf;
	title 'K-M method after hospital discharge by congestive heart complications';
run;

proc lifetest plots=survival(atrisk) data=project ;
	time lenfol*fstat(0);
	strata sho;
	title 'K-M method after hospital discharge by cardiogenic shock';
run;

/*Use Log-rank (but not Wilcoxon) and Tukey’s test to examine the cohort year effects on the survival probability for two outcome variable.
Write the null hypothesis for the Tukey’s test. (6 points) Select the appropriate 
statistical results from the SAS outputs and interpret the results. (10 points) Show the risk set and Log-rank test on the plot (4 points).*/
proc lifetest plots=survival(atrisk test) data=project notable;
	time los*dstat(0); 
	strata year/adjust=tukey;
	title 'K-M method and tukey test for length of hospital stay by cohort year';
run;

proc lifetest plots=survival(test atrisk) data=project notable;
	time lenfol*fstat(0);
	strata year/adjust=tukey;
	title 'K-M method and the Tukey test after hospital discharge by cohort year';
run;
/*Use Wilcoxon test to examine whether gender, cohort year, chf, and sho are associated with survival time simultaneously.
Write a general hypothesis for the test (2 points). 
Interpret statistical results for each covariate (4 points). Draw your conclusion based on the statistical results (2 points).*/

proc lifetest plots=survival(atrisk test) data=project notable;
	time los*dstat(0); 
	test year chf sho gender;
	title 'Association between length of hospital stay and other variables';
run;

proc lifetest plots=survival(test atrisk) data=project notable;
	time lenfol*fstat(0);
	test year chf sho gender;
	title 'Association between after hospital discharge and other variables';
run;


