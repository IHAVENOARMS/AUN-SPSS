GET FILE='C:\Program Files\SPSS\Tutorial\sample_files\bankloan.sav'.


* 
* First set the random seed and select about
* 70% of the cases for model building
*.
SET SEED 9191972.

IF ($casenum < 701) training = rv.bernoulli(.7) .
EXECUTE .


* use subset
*.
NAIVEBAYES default
  /EXCEPT VARIABLES=•s—šs—\‘ª1 •s—šs—\‘ª2 •s—šs—\‘ª3 training
  /TRAININGSAMPLE VARIABLE=training
  /SAVE PREDVAL PREDPROB.


* produce a means table and crosstabulation to look at the 
* distributions of predictors by PredictedValue
*.
MEANS
  TABLES=ŒÙ—p Z‹”N” •‰Â”ä ¸Ú¼Þ¯Ä•‰Â  BY PredictedValue
  /CELLS MEAN COUNT STDDEV  .

CROSSTABS
  /TABLES=‹³ˆç  BY PredictedValue
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT ROW
  /COUNT ROUND CELL .
