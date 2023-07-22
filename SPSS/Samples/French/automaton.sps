GET
  FILE='C:\Program Files\SPSS\tutorial\sample files\demo.sav'.
FREQUENCIES
  VARIABLES=educ
  /ORDER=  ANALYSIS .
CROSSTABS
  /TABLES=pda  BY genre  BY internet
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT EXPECTED ROW .
FREQUENCIES
  VARIABLES=situatio
  /ORDER=  ANALYSIS .
