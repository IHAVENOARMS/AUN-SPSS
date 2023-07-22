GET FILE='C:\Archivos de programa\SPSS\Tutorial\sample_files\breakfast_overall.sav'.

* A degenerate solution.  
*.
PREFSCAL 
   VARIABLES      = ts TO bm
  /INITIAL        = CLASSICAL(SPEARMAN)
  /PENALTY        = LAMBDA(1.0) OMEGA(0.0)
  /PLOT           = COMMON.

*
* A non-degenerate solution
*.
PREFSCAL 
   VARIABLES      = ts TO bm
  /INITIAL        = CLASSICAL(SPEARMAN)
  /PENALTY        = LAMBDA(0.5) OMEGA(1.0)
  /PLOT           = COMMON.

