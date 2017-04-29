/***********************************************************************************
the Worcester Heart Attack Study (WHAS).
Description of the variables in the WHAS100 dataset shown in Table 1.1
of Hosmer, D.W. and Lemeshow, S. and May, S. (2008) Applied Survival Analysis:
Regression Modeling of Time to Event Data: Second Edition,
John Wiley and Sons Inc., New York, NY

Data are in file whas100.dat
n = 100

Variable      Description                 Codes / Units
id            ID Code                     1 - 100
addate        Admission Date              mm/dd/yyyy.10
foldate       Follow Up Date              mm/dd/yyyy.10
los           Length of Hospital Stay     Days
lenfol        Follow Up Time              Days
folstatus     Vital Satus at last followup  1 = Dead,
                                          0 = Alive
age           Age at Admission            years
gender        Gender                      0 = Male
                                          1= Female
bmi           Body Mass Index             kg/m^2
***********************************************************************************/
*Libname in "E:\bst520 Survival\2012 Fall\SAS files";
Data whas100;
   Input ID admitdate: mmddyy10. foldate: mmddyy10. los lenfol folstatus age gender bmi;
Datalines;
    1  03/13/1995  03/19/1995     4      6     1    65     0   31.38134  
    2  01/14/1995  01/23/1996     5    374     1    88     1    22.6579  
    3  02/17/1995  10/04/2001     5   2421     1    77     0   27.87892  
    4  04/07/1995  07/14/1995     9     98     1    81     1   21.47878  
    5  02/09/1995  05/29/1998     4   1205     1    78     0   30.70601  
    6  01/16/1995  09/11/2000     7   2065     1    82     1   26.45294  
    7  01/17/1995  10/15/1997     3   1002     1    66     1   35.71147  
    8  11/15/1994  11/24/2000    56   2201     1    81     1   28.27676  
    9  08/18/1995  02/23/1996     5    189     1    76     0   27.12082  
   10  07/22/1995  12/31/2002     9   2719     0    40     0   21.78971  
   11  10/11/1995  12/31/2002     6   2638     0    73     1   28.43344  
   12  05/26/1995  09/29/1996    11    492     1    83     0   24.66175  
   13  05/21/1995  03/18/1996     6    302     1    64     1   27.46412  
   14  12/14/1995  12/31/2002    10   2574     0    58     0   29.83756  
   15  11/08/1995  12/31/2002     7   2610     0    43     0   22.95776  
   16  10/08/1995  12/31/2002     5   2641     0    39     0   30.10881  
   17  10/17/1995  05/12/2000     6   1669     1    66     0   31.99738  
   18  10/30/1995  01/05/2003     9   2624     1    61     0    30.7142  
   19  12/10/1995  12/31/2002     6   2578     0    49     0   25.69548  
   20  11/23/1995  12/31/2002     5   2595     0    53     1   30.12017  
   21  10/05/1995  02/05/1996     6    123     1    85     0   18.41038  
   22  11/05/1995  12/31/2002     8   2613     0    69     1   37.60097  
   23  09/09/1995  10/22/1997     4    774     1    54     0   28.97529  
   24  09/09/1995  03/13/2001    14   2012     1    82     0   19.90095  
   25  12/15/1995  12/31/2002     4   2573     0    67     1   28.32237  
   26  12/03/1995  01/19/2001    11   1874     1    89     1   23.43605  
   27  10/18/1995  12/31/2002     2   2631     0    68     0   26.44693  
   28  03/16/1995  06/04/2000     7   1907     1    78     0   28.20595  
   29  10/25/1995  04/15/1997     5    538     1    56     0   24.11997  
   30  10/06/1995  01/18/1996     4    104     1    85     1   36.71647  
   31  09/03/1995  09/09/1995     4      6     1    72     0   27.97907  
   32  06/30/1995  05/01/1999     5   1401     1    50     0     20.363  
   33  07/22/1995  12/22/2002     8   2710     1    81     1   28.64898  
   34  09/17/1995  01/05/1998     4    841     1    85     1   20.17772  
   35  03/21/1997  08/16/1997     6    148     1    84     1    23.6187  
   36  02/23/1997  12/31/2002    12   2137     0    75     0   23.67519  
   37  01/01/1997  12/31/2002    16   2190     0    61     0    23.4314  
   38  01/18/1997  12/31/2002     5   2173     0    48     0    33.4511  
   39  01/19/1997  04/25/1998     8    461     1    83     1   19.57068  
   40  03/18/1997  12/31/2002    10   2114     0    82     0   25.82748  
   41  02/03/1997  12/31/2002     4   2157     0    62     0   30.86625  
   42  05/17/1997  12/31/2002     5   2054     0    39     0   24.21079  
   43  03/08/1997  12/31/2002     5   2124     0    45     0   31.66439  
   44  02/23/1997  12/31/2002     4   2137     0    65     0   26.22085  
   45  06/14/1997  01/05/2003    18   2031     1    76     1   32.41986  
   46  07/07/1997  12/31/2002     9   2003     0    77     1   24.56345  
   47  04/27/1997  12/31/2002     9   2074     0    68     0    21.3055  
   48  05/15/1997  02/13/1998     7    274     1    73     0   26.45678  
   49  07/26/1997  12/31/2002     4   1984     0    64     0   27.97977  
   50  07/17/1997  12/31/2002     6   1993     0    80     0   36.02333  
   51  09/09/1997  12/31/2002     7   1939     0    84     1   22.31424  
   52  06/19/1997  09/03/2000     4   1172     1    43     1   25.33148  
   53  08/20/1997  11/17/1997     3     89     1    87     1   18.77718  
   54  08/28/1997  01/03/1998     7    128     1    70     1   18.60004  
   55  09/09/1997  12/31/2002    17   1939     0    80     0   25.50204  
   56  09/01/1997  09/15/1997    11     14     1    64     1   24.41255  
   57  09/03/1997  06/10/2000     5   1011     1    59     1   29.85998  
   58  09/24/1997  10/30/2001     6   1497     1    92     0    24.3664  
   59  09/19/1997  12/31/2002     3   1929     0    51     0   34.77034  
   60  04/17/1997  12/31/2002     1   2084     0    41     0   27.26234  
   61  10/21/1997  02/05/1998     6    107     1    90     0   24.78423  
   62  10/02/1997  12/27/1998     4    451     1    83     0   21.80987  
   63  01/08/1997  12/31/2002     3   2183     0    61     0   27.36909  
   64  11/11/1997  12/31/2002     7   1876     0    64     0   26.22085  
   65  11/07/1997  05/31/2000     3    936     1    82     0   26.88683  
   66  04/20/1997  04/18/1998     5    363     1    91     1   27.61844  
   67  06/18/1997  05/01/2000     5   1048     1    48     0   31.58373  
   68  10/29/1997  12/31/2002    12   1889     0    63     0   23.33267  
   69  04/29/1997  12/31/2002     5   2072     0    81     0   28.35006  
   70  11/08/1997  12/31/2002     7   1879     0    52     0   32.63621  
   71  11/17/1997  12/31/2002     4   1870     0    65     0   31.95113  
   72  11/28/1997  12/31/2002     5   1859     0    74     0   25.01782  
   73  05/19/1997  12/31/2002     5   2052     0    62     0   30.22827  
   74  12/11/1997  12/31/2002     4   1846     0    60     1   29.28812  
   75  05/10/1997  12/31/2002     7   2061     0    71     0   32.32407  
   76  10/06/1997  12/31/2002     3   1912     0    73     0   31.47445  
   77  12/21/1997  12/31/2002     5   1836     0    43     0   28.59188  
   78  11/22/1997  03/16/1998     7    114     1    80     0   33.36074  
   79  10/31/1997  02/04/2002     7   1557     1    72     0   21.80987  
   80  06/28/1997  12/27/2000     5   1278     1    57     0   23.57087  
   81  12/21/1997  12/31/2002     3   1836     0    80     1   28.35006  
   82  10/02/1997  12/31/2002     6   1916     0    76     0   28.03555  
   83  09/14/1997  12/31/2002     3   1934     0    53     0   24.21079  
   84  09/25/1997  12/31/2002    10   1923     0    44     0   32.60387  
   85  12/02/1997  01/15/1998     3     44     1    71     0    23.0563  
   86  09/26/1997  12/31/2002     6   1922     0    64     0   31.75016  
   87  10/24/1997  07/25/1998     5    274     1    86     0   21.10959  
   88  11/27/1997  12/31/2002     7   1860     0    72     1   25.23266  
   89  04/12/1997  03/23/2002     4   1806     1    73     1   22.86698  
   90  02/15/1997  12/31/2002     6   2145     0    85     1   26.05501  
   91  10/22/1997  04/22/1998     5    182     1    60     0   23.18023  
   92  06/27/1997  12/31/2002     4   2013     0    63     0   35.48949  
   93  01/17/1997  12/31/2002     5   2174     0    80     1   20.59809  
   94  12/12/1997  05/24/2002     4   1624     1    74     0   30.13206  
   95  11/04/1997  05/10/1998    10    187     1    79     1   16.78615  
   96  11/04/1997  12/31/2002     4   1883     0    48     1   32.11709  
   97  12/24/1997  04/19/2002     3   1577     1    32     1   39.93835  
   98  11/26/1997  01/27/1998     8     62     1    86     1   14.91878  
   99  08/10/1997  12/31/2002    16   1969     0    56     0   29.05295  
  100  03/26/1997  02/13/2000     7   1054     1    74     0   32.89087 
  ;
Run;
data whas101;
	set whas100;
foldays=foldate-admitdate;
folyr = foldate / 365.25;  *recalculate in years;
loglenfol = log(lenfol);
run;
/*
proc print; var admitdate foldate foldays lenfol;
run;
*/
proc lifereg data = whas101;
model lenfol*folstatus(0) = gender age bmi/ distribution = exponential;
probplot  npintervals=simul ppout;
*specifies that a table of the cumulative probabilities plotted on the probability plot be displayed.;
inset / cfill=white ;
	title "Exponential Model";
run;
proc lifetest data=whas101 plots=(lls ls) notable;
  time lenfol*folstatus(0);
  Title "Evaluating exponential and Weibull distribution assumption: a straight line";
 run;
proc lifereg data = whas101;
model lenfol*folstatus(0) = gender age  bmi;
probplot npintervals=simul ppout; 
inset / cfill=white ;
output out=weibull quantiles=.1 .5 .9  predicted=predtime; *Optional;
*calc predicted lenfol for each person at .1, .5, and .9;
	title "Weibull model";
run;
proc print data=weibull;
run;
Proc phreg data=whas101;
  model lenfol*folstatus(0) = gender age  bmi/rl;
  title "Verifying HRs calculated from the Weibull AFT model by the PH model";
Run;
proc lifereg data = whas101;
model lenfol*folstatus(0) = gender age  bmi/ distribution = llogistic;
probplot npintervals=simul ;
inset / cfill=white ;
	title "Log-logistic Model";
run;
Proc lifetest data=whas101 outsurv=a notable;
Time lenfol*folstatus(0); 
run;
Data b;  
	set a;
	S=survival;  
	logitf=log((1-s)/s); 
	logitsurv=log(s/(1-s)); 
	llenfol=log(lenfol);
Run;
Proc SGPlot data=b;
  series y=logitf  x=llenfol;
  yaxis label="Logit of failure odds vs log-time: log-logistic distribution" grid;
run;
Proc SGPlot data=b;
  series y=logitsurv  x=llenfol;
  yaxis label="Logit of survival odds vs log-time: log-logistic distribution" grid;
run;
Proc lifetest data=whas101 outsurv=c notable;
Time lenfol*folstatus(0); 
  strata gender;
run;
Data d;  
	set c;
	S=survival;  
	logitf=log((1-s)/s); 
	logitsurv=log(s/(1-s)); 
	llenfol=log(lenfol);
Run;
Proc SGPlot data=d;
  series y=logitf  x=llenfol/group=gender;
  yaxis label="Logit of failure odds" grid;
  Title "Evaluating the PO assumption in the log-logistic model";
run;
Proc SGPlot data=d;
  series y=logitsurv  x=llenfol/group=gender;
  yaxis label="Logit of survival odds" grid;
  Title "Evaluating the PO assumption in the log-logistic model";
run;
