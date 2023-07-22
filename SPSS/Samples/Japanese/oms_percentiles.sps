***oms_percentiles.sps***.
***if c:\temp is not a valid drive\path, replace all instances of c:\temp
   with a valid drive\path.

***Generate percentile values for salary and then
   merge those values back into original data file.
GET
  FILE='c:\Program Files\spss\Employee data.sav'.
PRESERVE.
SET TVARS NAMES TNUMBERS VALUES.

***split file by job category to get group percentiles.
SORT CASES BY êEéÌ.
SPLIT FILE LAYERED BY êEéÌ. 

OMS 
  /SELECT TABLES
  /IF COMMANDS=['Frequencies'] SUBTYPES=['Statistics']
  /DESTINATION FORMAT=SAV
   OUTFILE='c:\temp\temp.sav'
  /COLUMNS SEQUENCE=[L1 R2].

FREQUENCIES
  VARIABLES=ããó^   
  /FORMAT=NOTABLE
  /PERCENTILES= 25 50 75.

OMSEND.

***restore previous  SET settings.
RESTORE.

MATCH FILES FILE=*
  /TABLE='c:\temp\temp.sav'
  /rename (Var1=êEéÌ)
  /BY êEéÌ
 /DROP command_ TO ããó^_åáëπíl.
EXECUTE.

