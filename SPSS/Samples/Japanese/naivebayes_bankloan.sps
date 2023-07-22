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
  /EXCEPT VARIABLES=�s���s�\��1 �s���s�\��2 �s���s�\��3 training
  /TRAININGSAMPLE VARIABLE=training
  /SAVE PREDVAL PREDPROB.


* produce a means table and crosstabulation to look at the 
* distributions of predictors by PredictedValue
*.
MEANS
  TABLES=�ٗp �Z���N�� ���� �ڼޯĕ���  BY PredictedValue
  /CELLS MEAN COUNT STDDEV  .

CROSSTABS
  /TABLES=����  BY PredictedValue
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT ROW
  /COUNT ROUND CELL .
