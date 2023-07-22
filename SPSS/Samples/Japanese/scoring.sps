***scoring.sps***.

/**** Get data to be scored ****.

GET FILE='file specification'.


/**** Data Transformations ****.

* Recode Age into a categorical variable.
RECODE Age
     ( MISSING = COPY )
     ( LO THRU 37 =1 )
     ( LO THRU 43 =2 )
     ( LO THRU 49 =3 )
     ( LO THRU HI = 4 ) INTO Age_Group.

IF MISSING(Age) Age_Group = -9.

* The Amount distribution is skewed, so take the log of it.
COMPUTE Log_Amount = ln(Amount).


/**** Read in the XML model files ****.

MODEL HANDLE NAME=mregression FILE='file specification'.
MODEL HANDLE NAME=tree FILE='file specification'.


/**** Apply the models to the data set ****.

COMPUTE PredCatReg = ApplyModel(mregression,'predict').
COMPUTE PredCatTree = ApplyModel(tree,'predict').


* Compute comparison variable.
COMPUTE ModelsAgree = PredCatReg=PredCatTree.


/**** Save sample results ****.

SAVE OUTFILE='file specification'.
