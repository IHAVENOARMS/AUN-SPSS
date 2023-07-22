***oms_percentiles.sps***.
***if c:\temp is not a valid drive\path, replace all instances of c:\temp
   with a valid drive\path.

***Generate percentile values for salary and then
   merge those values back into original data file.
GET
  FILE='c:\Archivos de programa\spss13ES\Datos de empleados.sav'.
PRESERVE.
SET TVARS NAMES TNUMBERS VALUES.

***split file by job category to get group percentiles.
SORT CASES BY catlab.
SPLIT FILE LAYERED BY catlab. 

OMS 
  /SELECT TABLES
  /IF COMMANDS=['Frequencias'] SUBTYPES=['Estadídticos']
  /DESTINATION FORMAT=SAV
   OUTFILE='c:\temp\temp.sav'
  /COLUMNS SEQUENCE=[L1 R2].

FREQUENCIES
  VARIABLES=salario   
  /FORMAT=NOTABLE
  /PERCENTILES= 25 50 75.

OMSEND.

***restore previous  SET settings.
RESTORE.

MATCH FILES FILE=*
  /TABLE='c:\temp\temp.sav'
  /rename (Var1=catlab)
  /BY catlab
 /DROP command_ TO salary_Missing.
EXECUTE.

