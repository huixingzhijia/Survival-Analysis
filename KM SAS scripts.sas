Data acute_leukemia;
 input group $ wktime status @@;
 datalines;
 T 6 1 T 6 1 T 6 1 T 7 1 T 10 1 T 13 1 T 16 1 T 22 1 T 23 1 T 6 0 T 9 0 T 10 0 T 11 0 T 17 0 
 T 19 0 T 20 0 T 32 0 T 32 0 T 32 0 T 34 0 T 35 0
 P 1 1 P 1 1 P 2 1 P 2 1 P 3 1 P 4 1 P 4 1 P 5 1 P 5 1 P 8 1 P 8 1 P 8 1 P 8 1 P 11 1 P 11 1 
 P 12 1 P 12 1 P 15 1 P 17 1 P 22 1 P 23 1
 ;
Proc Freq; tables group*status;
Proc sort; by group;
PROC LIFETEST PLOTS=s;
     TIME wktime*status(0);  
     By group;
     TITLE 'K M method for patients';
Run;
PROC LIFETEST PLOTS=s(atrisk cl);
     TIME wktime*status(0);  
     By group;
     TITLE "K M method with 95% CI for patients";
Run;
PROC LIFETEST PLOTS=s(atrisk cb=hw) notable;
     TIME wktime*status(0);  
     By group;
     TITLE "K M method with 95% CI for patients";
Run;
PROC LIFETEST Method=life PLOTS=s;
     TIME wktime*status(0);  
     By group;
     TITLE 'Lifetable method for patients';
Run;
PROC LIFETEST PLOTS=s;
     TIME wktime*status(0);  where group="T";
     TITLE 'K M method for patients who received the treatment';
PROC LIFETEST PLOTS=s;
     TIME wktime*status(0);  where group="P";
     TITLE 'K M method for patients who were in the placebo group';
run;
