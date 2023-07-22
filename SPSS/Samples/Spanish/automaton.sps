GET
  FILE='C:\Archivos de programa\SPSS\tutorial\sample_files\demo.sav'.
FREQUENCIES
  VARIABLES=educ
  /ORDER=  ANALYSIS .
CROSSTABS
  /TABLES=pda  BY genero  BY internet
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT EXPECTED ROW .
FREQUENCIES
  VARIABLES=marital
  /ORDER=  ANALYSIS .
