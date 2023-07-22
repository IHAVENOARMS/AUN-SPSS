GET FILE='C:\Archivos de programa\SPSS\Tutorial\sample_files\behavior.sav'.


* An initial solution with a linear transformation of the proximities
*.
PREFSCAL 
   VARIABLES      = correr TO gritar
  /INPUT          = ROWS(idfila)
  /INITIAL        = ('C:\Archivos de programa\SPSS\Tutorial\sample_files\behavior_ini.sav')
  /CONDITION      = UNCONDITIONAL
  /TRANSFORMATION = LINEAR(INTERCEPT)
  /PLOT           = COMMON TRANSFORM.


* A solution with an ordinal transformation
*.
PREFSCAL 
   VARIABLES      = correr TO gritar
  /INPUT          = ROWS(idfila)
  /INITIAL        = ('C:\Archivos de programa\SPSS\Tutorial\sample_files\behavior_ini.sav')
  /CONDITION      = UNCONDITIONAL
  /TRANSFORMATION = ORDINAL(KEEPTIES)
  /PLOT           = COMMON TRANSFORM.

