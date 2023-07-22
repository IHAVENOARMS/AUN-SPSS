GET FILE='C:\Program Files\SPSS\SPSS15J\Tutorial\sample_files\customer_dbase.sav'.


* First run.  Toss in all variables except the other response variables and the customer ID variable.
*.
SELECTPRED ����_01 
  /EXCEPT VARIABLES=�ڋqID ����_02 ����_03
  /MISSING USERMISSING=INCLUDE. 


* Widen search criteria so selected list includes more variables with p-value < 0.05.
* Also show first 10 unselected predictors
*.
SELECTPRED ����_01 
  /EXCEPT VARIABLES=�ڋqID ����_02 ����_03
  /SCREENING PCTMISSING=80
  /CRITERIA SIZE=50 SHOWUNSELECTED=10
  /MISSING USERMISSING=INCLUDE. 


