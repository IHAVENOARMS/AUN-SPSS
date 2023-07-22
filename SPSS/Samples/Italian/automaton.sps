GET
  FILE='c:\programmi\spss\tutorial\esempi\demo.sav'.
FREQUENCIES
  VARIABLES=statociv
  /ORDER=  ANALYSIS .
FREQUENCIES
  VARIABLES=istruz
  /ORDER=  ANALYSIS .
CROSSTABS
  /TABLES=pda  BY sesso  BY internet
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT EXPECTED ROW .
