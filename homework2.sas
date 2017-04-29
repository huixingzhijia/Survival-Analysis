libname survival 'D:\courses\BSTcourse\survival\slides and homework\week 2';
run;
data survival.homework2;
input group yrtime status @@;
* group 1 CHR=0, group 2 CHR=1 status : censored=0 death =1;
datalines;
1 12.3 0 1 5.4 1 1 8.2 1 1 12.2 0 1 11.7 1 1 10.0 1 1 5.7 1 1 9.8 1 1 2.6 1 1 11.0 1 1 9.2 1 1 12.1 0 1 6.6 1 1 2.2 1 1 1.8 1 1 10.2 1 1 10.7 1
1 11.1 1 1 5.3 1 1 3.5 1 1 9.2 1 1 2.5 1 1 8.7 1 1 3.8 1 1 3.0 1
2 5.8 1 2 2.9 1 2 8.4 1 2 8.3 1 2 9.1 1 2 4.2 1 2 4.1 1 2 1.8 1 2 3.1 1 2 11.4 1 2 2.4 1 2 1.4 1 2 5.9 1 2  1.6 1 2 2.8 1 2 4.9 1 2 3.5 1 2 6.5 1
2 9.9 1 2 3.6 1 2 5.2 1  

