DATA AIDSCENR;
    INPUT agegrp id month death @@;
DATALINES;
1  1  2  1 1  2  3 0 1 3  6  1 1 4 6 1 1 5  7  1
1 6 10 0 1 7 15 1 1 8 15 1 1 9 16 1 1 10 27 1 1 11 30 1 1 12  32  1  2 21 1 1 2 22 1 1   2 23 1 1  2 24 1 1  2 25 2 1  2 26 3 1  2  27  3 1  2 28 9 1  2 29  22 1
;
PROC LIFETEST PLOTS=s (atrisk CL);
     TIME month*death(0);  where agegrp=1;
     TITLE 'K M method for 12 patients who were at most 40 years old censored observations';
RUN;
PROC LIFETEST PLOTS=s (atrisk CL) notable;
     TIME month*death(0); by agegrp;  
     TITLE 'K M method for 21 patients stratified by age group';
RUN;
PROC LIFETEST method=life PLOTS=(s,h) intervals=0 to 33 by 1; 
     TIME month*death(0);  where agegrp=1;
     TITLE 'Life table method for all patients';
	run;
PROC LIFETEST PLOTS=s (atrisk Cb=ep);
     TIME month*death(0);  
     TITLE 'K M method for 12 patients who were at most 40 years old censored observations';
RUN;
