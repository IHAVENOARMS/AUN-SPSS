***oms_percentiles.sps***.
***falls c:\temp kein g�ltiger Pfad ist, bitte mit einem g�ltigen Pfad ersetzen***.
   
*** Erstellen der Perzentilwerte f�r gehalt und zusammenf�hren dieser Werte mit der Original Datendatei***.

GET
  FILE='c:\Program Files\spss\Bankangestellte.sav'.
PRESERVE.
SET TVARS NAMES TNUMBERS VALUES.

*** Datei aufteilen nach t�tig um Gruppenperzentile zu erhalten***.
SORT CASES BY t�tig.
SPLIT FILE LAYERED BY t�tig. 

OMS 
  /SELECT TABLES
  /IF COMMANDS=['Frequencies'] SUBTYPES=['Statistics']
  /DESTINATION FORMAT=SAV
   OUTFILE='c:\temp\temp.sav'
  /COLUMNS SEQUENCE=[L1 R2].

FREQUENCIES
  VARIABLES=gehalt   
  /FORMAT=NOTABLE
  /PERCENTILES= 25 50 75.

OMSEND.

***Wiederherstellung der urspr�nglichen SET Einstellungen.
RESTORE.

MATCH FILES FILE=*
  /TABLE='c:\temp\temp.sav'
  /rename (Var1=t�tig)
  /BY t�tig
 /DROP command_ TO gehalt_Missing.
EXECUTE.

