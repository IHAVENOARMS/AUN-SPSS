GET FILE='C:\Program Files\SPSS\Tutorial\sample_files\customer_dbase.sav'.


* Should use SELECTPRED outputs as inputs
*.
NAIVEBAYES 反応_01 
  BY 住居年数カテゴリ コールカード コールID キャッチホン カード カード2 解約 
      通勤カープール スリーホン 電子請求 教育カテゴリ 装置 転送 インターネット 
      複数回線 ゲーム ipod PC 配偶者教育カテゴリ 通話無料 ボイス
  WITH カード前月 教育 装置前月 lnカード前月 ln無料前月 
      ペット_淡水魚 配偶者教育 無料前月 無料期間
  /SUBSET NOSELECTION
  /SAVE PREDPROB.


* Compute predicted response using probability > 30% and crosstabulate
*.
COMPUTE predresponse = PredictedProbability_2 > 0.30 .
EXECUTE .

CROSSTABS
  /TABLES=反応_01  BY predresponse
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT
  /COUNT ROUND CELL .



