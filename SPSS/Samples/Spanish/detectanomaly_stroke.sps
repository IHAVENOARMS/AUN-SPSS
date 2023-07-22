GET FILE='C:\Archivos de programa\SPSS\Tutorial\sample_files\stroke_valid.sav'.


*Identificar casos poco habituales.
DETECTANOMALY /VARIABLES
  CATEGORICAL= edad edadcat sexo activo obesidad diabetes ps fa fuma colest
  angina im nitro anticoag ait tiempo ic rango0 exptac tromboli exhosp result 
  cirugia rehab rango1 rango2 rango3 barthel1 barthel2 barthel3 recbart1
  recbart2 recbart3 infart1 infart2 infart3
  SCALE=dura_rehab coste 
  ID= idpac
 /PRINT ANOMALYLIST NORMS ANOMALYSUMMARY REASONSUMMARY CPS
 /SAVE ANOMALY(AnomalyIndex) PEERID(PeerId) PEERSIZE(PeerSize)
  PEERPCTSIZE(PeerPctSize) REASONVAR(ReasonVar) REASONMEASURE(ReasonMeasure)
  REASONVALUE(ReasonValue) REASONNORM(ReasonNorm)
 /HANDLEMISSING APPLY=YES CREATEMISPROPVAR=YES
 /CRITERIA PCTANOMALOUSCASES=2 ANOMALYCUTPOINT=NONE MINNUMPEERS=1
  MAXNUMPEERS=15 NUMREASONS=3.


*
* Un dibujo que ofrece una reprentación intersante de los resultados
*.
GRAPH
  /SCATTERPLOT(BIVAR)=ReasonMeasure_1 WITH AnomalyIndex BY PeerId
  /MISSING=LISTWISE .
