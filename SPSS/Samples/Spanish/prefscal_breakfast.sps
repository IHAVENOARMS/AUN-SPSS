GET FILE='C:\Archivos de programa\SPSS\Tutorial\sample_files\breakfast.sav'.

*
* A 3-way unfolding
*.
PREFSCAL 
   VARIABLES      = ts TO bm
  /INPUT          = SOURCES(idesc)
  /INITIAL        = CLASSICAL(SPEARMAN)
  /MODEL          = WEIGHTED
  /PLOT           = COMMON INDIVIDUAL WEIGHTS .


*
* Use a different initial configuration
*.
PREFSCAL 
   VARIABLES      = ts TO bm
  /INPUT          = SOURCES(idesc)
  /INITIAL        = CORRESPONDENCE
  /MODEL          = WEIGHTED
  /PLOT           = COMMON INDIVIDUAL WEIGHTS.
