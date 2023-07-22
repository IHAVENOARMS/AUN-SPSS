GET FILE='C:\Program Files\SPSS\Tutorial\sample_files\breakfast.sav'.

*
* A 3-way unfolding
*.
PREFSCAL 
   VARIABLES      = tp TO cmb
  /INPUT          = SOURCES(srcid)
  /INITIAL        = CLASSICAL(SPEARMAN)
  /MODEL          = WEIGHTED
  /PLOT           = COMMON INDIVIDUAL WEIGHTS .


*
* Use a different initial configuration
*.
PREFSCAL 
   VARIABLES      = tp TO cmb
  /INPUT          = SOURCES(srcid)
  /INITIAL        = CORRESPONDENCE
  /MODEL          = WEIGHTED
  /PLOT           = COMMON INDIVIDUAL WEIGHTS.

