GET FILE='C:\Program Files\SPSS\Tutorial\sample_files\customer_dbase.sav'.


* Should use SELECTPRED outputs as inputs
*.
NAIVEBAYES ����_01 
  BY �Z���N���J�e�S�� �R�[���J�[�h �R�[��ID �L���b�`�z�� �J�[�h �J�[�h2 ��� 
      �ʋ΃J�[�v�[�� �X���[�z�� �d�q���� ����J�e�S�� ���u �]�� �C���^�[�l�b�g 
      ������� �Q�[�� ipod PC �z��ҋ���J�e�S�� �ʘb���� �{�C�X
  WITH �J�[�h�O�� ���� ���u�O�� ln�J�[�h�O�� ln�����O�� 
      �y�b�g_�W���� �z��ҋ��� �����O�� ��������
  /SUBSET NOSELECTION
  /SAVE PREDPROB.


* Compute predicted response using probability > 30% and crosstabulate
*.
COMPUTE predresponse = PredictedProbability_2 > 0.30 .
EXECUTE .

CROSSTABS
  /TABLES=����_01  BY predresponse
  /FORMAT= AVALUE TABLES
  /CELLS= COUNT
  /COUNT ROUND CELL .



