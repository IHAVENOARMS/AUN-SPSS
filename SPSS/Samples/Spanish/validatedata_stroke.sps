GET FILE='C:\Archivos de programa\SPSS\Tutorial\sample_files\stroke_invalid.sav'.

* Primero, ejcutar las comprobaciones básicas
*.
* Validar los datos.
* Validate Data.
VALIDATEDATA
  VARIABLES=tamañohos edad edadcat sexo activo obesidad diabetes ps fa fuma
  colest angina im nitro anticoag ait tiempo ic rango0 exptac tromboli exhosp
  result cirugia rehab dura_rehab coste rango1 rango2 rango3 barthel1 barthel2
  barthel3 recbart1 recbart2 recbart3
  ID=idhosp idpac idmed
 /VARCHECKS STATUS=ON PCTMISSING=70 PCTEQUAL=95 PCTUNEQUAL=90 CV=0.001
  STDDEV=0
 /IDCHECKS INCOMPLETE DUPLICATE
 /CASECHECKS REPORTEMPTY=YES SCOPE=ALLVARS
 /CASEREPORT DISPLAY=YES MINVIOLATIONS=1 CASELIMIT=FIRSTN(100).


* Después, aplicar el diccionario de datos de patient_los.sav y ejecutar algunas reglas típicas
*.
APPLY DICTIONARY
  /FROM 'C:\Archivos de programa\SPSS\Tutorial\sample_files\patient_los.sav'
  /SOURCE VARIABLES = edad edadcat sexo diabetes ps fuma colest activo
  obesidad angina im nitro anticoag tiempo ic tromboli result coste
  /FILEINFO ATTRIBUTES = REPLACE
  /VARINFO ATTRIBUTES = REPLACE .


* Ahora validar los datos respecto a estas reglas.
*.
* Eliminar reglas de validación de variable única existentes.
DATAFILE ATTRIBUTE DELETE=$VD.SRule.
* Eliminar vínculos existentes entre variables y reglas.
VARIABLE ATTRIBUTE  VARIABLES=ALL  DELETE=$VD.SRuleRef.
* (Re)definir reglas de validación de variable única.
DATAFILE ATTRIBUTE ATTRIBUTE=
      $VD.SRule[1]("Label='0 a 1 Dicotomía', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '1' ")
      $VD.SRule[2]("Label='0 a 2 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '1' '2' ")
      $VD.SRule[3]("Label='0 a 3 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '1' '2' '3' ")
      $VD.SRule[4]("Label='1 a 4 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='1' '2' '3' '4' ")
      $VD.SRule[5]("Label='Enteros no negativos', Type='Numeric',"+
 " Domain='Range', Minimum='0', Maximum='', FlagUserMissing='No',"+
 " FlagSystemMissing='Yes', FlagBlank='No', FlagNoninteger='Yes',"+
 " FlagUnlabeled='No' ")
      $VD.SRule[6]("Label='Números no negativos', Type='Numeric',"+
 " Domain='Range', Minimum='0', Maximum='', FlagUserMissing='No',"+
 " FlagSystemMissing='Yes', FlagBlank='No', FlagNoninteger='No',"+
 " FlagUnlabeled='No' ").
* (Re)definir vínculos entre variables y reglas.
VARIABLE ATTRIBUTE
    VARIABLES=edadcat  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[4]'"+
 ",OutcomeVar='@1a4Categórica_edadcat_' ")
    /VARIABLES=activo  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_activo_' ")
    /VARIABLES=angina  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_angina_' ")
    /VARIABLES=edad  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[5]'"+
 ",OutcomeVar='Enterosnonegativos_edad_' ")
    /VARIABLES=coste  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[6]'"+
 ",OutcomeVar='Númerosnonegativos_coste_' ")
    /VARIABLES=fuma  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_fuma_' ")
    /VARIABLES=ps  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[2]',OutcomeVar='@0a2Categórica_ps_' ")
    /VARIABLES=im  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_im_' ")
    /VARIABLES=colest  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_colest_' ")
    /VARIABLES=obesidad  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]'"+
 ",OutcomeVar='@0a1Dicotomía_obesidad_' ")
    /VARIABLES=tromboli  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[3]'"+
 ",OutcomeVar='@0a3Categórica_tromboli_' ")
    /VARIABLES=anticoag  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[3]'"+
 ",OutcomeVar='@0a3Categórica_anticoag_' ")
    /VARIABLES=ic  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_ic_' ")
    /VARIABLES=sexo  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_sexo_' ")
    /VARIABLES=tiempo  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[5]'"+
 ",OutcomeVar='Enterosnonegativos_tiempo_' ")
    /VARIABLES=result  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[4]'"+
 ",OutcomeVar='@1a4Categórica_result_' ")
    /VARIABLES=diabetes  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]'"+
 ",OutcomeVar='@0a1Dicotomía_diabetes_' ")
    /VARIABLES=nitro  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_nitro_' ") .
* 0 a 3 Categórica.
COMPUTE @0a3Categórica_anticoag_ = NOT(ANY(VALUE(anticoag), 0, 1, 2, 3) OR
  (MISSING(anticoag) AND NOT(SYSMIS(anticoag)))) OR SYSMIS(anticoag).
COMPUTE @0a3Categórica_tromboli_ = NOT(ANY(VALUE(tromboli), 0, 1, 2, 3) OR
  (MISSING(tromboli) AND NOT(SYSMIS(tromboli)))) OR SYSMIS(tromboli).
* Enteros no negativos.
COMPUTE Enterosnonegativos_edad_ = NOT(VALUE(edad)>=0 AND
  VALUE(edad)=TRUNC(VALUE(edad)) OR (MISSING(edad) AND NOT(SYSMIS(edad)))) OR
  SYSMIS(edad).
COMPUTE Enterosnonegativos_tiempo_ = NOT(VALUE(tiempo)>=0 AND
  VALUE(tiempo)=TRUNC(VALUE(tiempo)) OR (MISSING(tiempo) AND
  NOT(SYSMIS(tiempo)))) OR SYSMIS(tiempo).
* 1 a 4 Categórica.
COMPUTE @1a4Categórica_edadcat_ = NOT(ANY(VALUE(edadcat), 1, 2, 3, 4) OR
  (MISSING(edadcat) AND NOT(SYSMIS(edadcat)))) OR SYSMIS(edadcat).
COMPUTE @1a4Categórica_result_ = NOT(ANY(VALUE(result), 1, 2, 3, 4) OR
  (MISSING(result) AND NOT(SYSMIS(result)))) OR SYSMIS(result).
* Números no negativos.
COMPUTE Númerosnonegativos_coste_ = NOT(VALUE(coste)>=0 OR (MISSING(coste)
  AND NOT(SYSMIS(coste)))) OR SYSMIS(coste).
* 0 a 2 Categórica.
COMPUTE @0a2Categórica_ps_ = NOT(ANY(VALUE(ps), 0, 1, 2) OR (MISSING(ps) AND
  NOT(SYSMIS(ps)))) OR SYSMIS(ps).
* 0 a 1 Dicotomía.
DO REPEAT #OV=@0a1Dicotomía_obesidad_ @0a1Dicotomía_colest_
  @0a1Dicotomía_fuma_ @0a1Dicotomía_im_ @0a1Dicotomía_angina_
  @0a1Dicotomía_activo_ @0a1Dicotomía_nitro_ @0a1Dicotomía_sexo_
  @0a1Dicotomía_diabetes_ @0a1Dicotomía_ic_
  /#IV=obesidad colest fuma im angina activo nitro sexo diabetes ic.
COMPUTE #OV=NOT(ANY(VALUE(#IV), 0, 1) OR (MISSING(#IV) AND NOT(SYSMIS(#IV))))
  OR SYSMIS(#IV).
END REPEAT.
* Marcar variables de resultados de reglas como tales en el diccionario de
  datos de SPSS.
VARIABLE ATTRIBUTE
   VARIABLES=@0a3Categórica_anticoag_  TO @0a1Dicotomía_ic_
   ATTRIBUTE=$VD.RuleOutcomeVar("Yes").
VARIABLE LABELS @1a4Categórica_edadcat_  '1 a 4 Categórica:Categoría de'+
 ' edad'.
VARIABLE LABELS @0a1Dicotomía_activo_  '0 a 1 Dicotomía:Físicamente activo'.
VARIABLE LABELS @0a1Dicotomía_angina_  '0 a 1 Dicotomía:Historial de angina'.
VARIABLE LABELS Enterosnonegativos_edad_  'Enteros no negativos:Edad en'+
 ' años'.
VARIABLE LABELS Númerosnonegativos_coste_  'Números no negativos:Coste total'+
 ' de tratamiento y rehabilitación en miles'.
VARIABLE LABELS @0a1Dicotomía_fuma_  '0 a 1 Dicotomía:Fumador'.
VARIABLE LABELS @0a2Categórica_ps_  '0 a 2 Categórica:Presión sanguínea'.
VARIABLE LABELS @0a1Dicotomía_im_  '0 a 1 Dicotomía:Historial de infarto de'+
 ' miocardio'.
VARIABLE LABELS @0a1Dicotomía_colest_  '0 a 1 Dicotomía:Colesterol'.
VARIABLE LABELS @0a1Dicotomía_obesidad_  '0 a 1 Dicotomía:Obesidad'.
VARIABLE LABELS @0a3Categórica_tromboli_  '0 a 3 Categórica:Drogas'+
 ' trombolíticas'.
VARIABLE LABELS @0a3Categórica_anticoag_  '0 a 3 Categórica:Toma drogas'+
 ' anticoagulantes'.
VARIABLE LABELS @0a1Dicotomía_ic_  '0 a 1 Dicotomía:Ingresó cadáver'.
VARIABLE LABELS @0a1Dicotomía_sexo_  '0 a 1 Dicotomía:Género'.
VARIABLE LABELS Enterosnonegativos_tiempo_  'Enteros no negativos:Tiempo'+
 ' hasta el hospital'.
VARIABLE LABELS @1a4Categórica_result_  '1 a 4 Categórica:Resultado del'+
 ' tratamiento'.
VARIABLE LABELS @0a1Dicotomía_diabetes_  '0 a 1 Dicotomía:Historial de'+
 ' diabetes'.
VARIABLE LABELS @0a1Dicotomía_nitro_  '0 a 1 Dicotomía:Prescripción de'+
 ' nitroglicerina'.
VALUE LABELS @0a3Categórica_anticoag_  TO @0a1Dicotomía_ic_  1 'Inválido' 0
  'Válido'.
FORMAT @0a3Categórica_anticoag_  TO @0a1Dicotomía_ic_  (F1.0).
VARIABLE WIDTH @0a3Categórica_anticoag_  TO @0a1Dicotomía_ic_  (4).
VARIABLE LEVEL @0a3Categórica_anticoag_  TO @0a1Dicotomía_ic_  (NOMINAL).
* Validar datos.
VALIDATEDATA
  VARIABLES=tamañohos edad edadcat sexo activo obesidad diabetes ps fa fuma
  colest angina im nitro anticoag ait tiempo ic rango0 exptac tromboli exhosp
  result cirugia rehab dura_rehab coste rango1 rango2 rango3 barthel1 barthel2
  barthel3 recbart1 recbart2 recbart3
  ID=idhosp idpac idmed
 /VARCHECKS STATUS=ON PCTMISSING=70 PCTEQUAL=95 PCTUNEQUAL=90 CV=0.001
  STDDEV=0
 /IDCHECKS INCOMPLETE DUPLICATE
 /CASECHECKS REPORTEMPTY=YES SCOPE=ALLVARS
 /CASEREPORT DISPLAY=YES MINVIOLATIONS=1 CASELIMIT=FIRSTN(100)
 /RULESUMMARIES BYVARIABLE.


* Finalmente, crear algunas reglas propias
*.
DELETE VARIABLES 
  @0a3Categórica_anticoag_ @0a3Categórica_tromboli_ Enterosnonegativos_edad_
  Enterosnonegativos_tiempo_ @1a4Categórica_edadcat_ @1a4Categórica_result_
  Númerosnonegativos_coste_ @0a2Categórica_ps_ @0a1Dicotomía_obesidad_
  @0a1Dicotomía_colest_ @0a1Dicotomía_fuma_ @0a1Dicotomía_im_
  @0a1Dicotomía_angina_ @0a1Dicotomía_activo_ @0a1Dicotomía_nitro_
  @0a1Dicotomía_sexo_ @0a1Dicotomía_diabetes_ @0a1Dicotomía_ic_.

* (Re)definir reglas de validación inter-variables.
DATAFILE ATTRIBUTE ATTRIBUTE=
   $VD.CRule[1]("Label='DosDefunciones',OutcomeVar='DosDefunciones_'"+
 ",Expression='(ic = 1) & (exhosp=1)' ").
* Eliminar reglas de validación de variable única existentes.
DATAFILE ATTRIBUTE DELETE=$VD.SRule.
* Eliminar vínculos existentes entre variables y reglas.
VARIABLE ATTRIBUTE  VARIABLES=ALL  DELETE=$VD.SRuleRef.
* (Re)definir reglas de validación de variable única.
DATAFILE ATTRIBUTE ATTRIBUTE=
      $VD.SRule[1]("Label='0 a 1 Dicotomía', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '1' ")
      $VD.SRule[2]("Label='0 a 2 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '1' '2' ")
      $VD.SRule[3]("Label='0 a 3 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='1' '2' '3' ")
      $VD.SRule[4]("Label='1 a 4 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='1' '2' '3' '4' ")
      $VD.SRule[5]("Label='Enteros no negativos', Type='Numeric',"+
 " Domain='Range', Minimum='0', Maximum='', FlagUserMissing='No',"+
 " FlagSystemMissing='Yes', FlagBlank='No', FlagNoninteger='Yes',"+
 " FlagUnlabeled='No' ")
      $VD.SRule[6]("Label='Números no negativos', Type='Numeric',"+
 " Domain='Range', Minimum='0', Maximum='', FlagUserMissing='No',"+
 " FlagSystemMissing='Yes', FlagBlank='No', FlagNoninteger='No',"+
 " FlagUnlabeled='No' ")
      $VD.SRule[7]("Label='1 a 3 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='1' '2' '3' ")
      $VD.SRule[8]("Label='0 a 5 Categórica', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '1' '2' '3' '4' '5' ")
      $VD.SRule[9]("Label='0 a 100 por 5', Type='Numeric', Domain='List',"+
 " FlagUserMissing='No', FlagSystemMissing='Yes', FlagBlank='No',"+
 " CaseSensitive='No',List='0' '5' '10' '15' '20' '25' '30' '35' '40' '45' '50'"+
 " '55' '60' '65' '70' '75' '80' '85' '90' '95' '100' ").
* (Re)definir vínculos entre variables y reglas.
VARIABLE ATTRIBUTE
    VARIABLES=rango3  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[8]'"+
 ",OutcomeVar='@0a5Categórica_rango3_' ")
    /VARIABLES=edadcat  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[4]'"+
 ",OutcomeVar='@1a4Categórica_edadcat_' ")
    /VARIABLES=activo  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_activo_'"+
 " ")
    /VARIABLES=angina  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_angina_'"+
 " ")
    /VARIABLES=edad  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[5]'"+
 ",OutcomeVar='Enterosnonegativos_edad_' ")
    /VARIABLES=coste  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[6]'"+
 ",OutcomeVar='Númerosnonegativos_coste_' ")
    /VARIABLES=fuma  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_fuma_'"+
 " ")
    /VARIABLES=ps  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[2]',OutcomeVar='@0a2Categórica_ps_' ")
    /VARIABLES=im  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_im_' ")
    /VARIABLES=colest  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_colest_'"+
 " ")
    /VARIABLES=obesidad  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]'"+
 ",OutcomeVar='@0a1Dicotomía_obesidad_' ")
    /VARIABLES=barthel1  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[9]',OutcomeVar='@0a100por5_barthel1_'"+
 " ")
    /VARIABLES=barthel2  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[9]',OutcomeVar='@0a100por5_barthel2_'"+
 " ")
    /VARIABLES=barthel3  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[9]',OutcomeVar='@0a100por5_barthel3_'"+
 " ")
    /VARIABLES=tromboli  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[3]'"+
 ",OutcomeVar='@0a3Categórica_tromboli_' ")
    /VARIABLES=anticoag  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[3]'"+
 ",OutcomeVar='@0a3Categórica_anticoag_' ")
    /VARIABLES=ic  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_ic_' ")
    /VARIABLES=sexo  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_sexo_'"+
 " ")
    /VARIABLES=tiempo  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[5]'"+
 ",OutcomeVar='Enterosnonegativos_tiempo_' ")
    /VARIABLES=result  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[4]'"+
 ",OutcomeVar='@1a4Categórica_result_' ")
    /VARIABLES=rango0  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[8]'"+
 ",OutcomeVar='@0a5Categórica_rango0_' ")
    /VARIABLES=tamañohos  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[7]'"+
 ",OutcomeVar='@1a3Categórica_tamañohos_' ")
    /VARIABLES=diabetes  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]'"+
 ",OutcomeVar='@0a1Dicotomía_diabetes_' ")
    /VARIABLES=rango1  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[8]'"+
 ",OutcomeVar='@0a5Categórica_rango1_' ")
    /VARIABLES=rango2  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[8]'"+
 ",OutcomeVar='@0a5Categórica_rango2_' ")
    /VARIABLES=nitro  ATTRIBUTE=
      $VD.SRuleRef[1]("Rule='$VD.SRule[1]',OutcomeVar='@0a1Dicotomía_nitro_'"+
 " ") .
TEMPORARY.
* 0 a 3 Categórica.
COMPUTE @0a3Categórica_anticoag_ = NOT(ANY(VALUE(anticoag), 1, 2, 3) OR
  (MISSING(anticoag) AND NOT(SYSMIS(anticoag)))) OR SYSMIS(anticoag).
COMPUTE @0a3Categórica_tromboli_ = NOT(ANY(VALUE(tromboli), 1, 2, 3) OR
  (MISSING(tromboli) AND NOT(SYSMIS(tromboli)))) OR SYSMIS(tromboli).
* 1 a 3 Categórica.
COMPUTE @1a3Categórica_tamañohos_ = NOT(ANY(VALUE(tamañohos), 1, 2, 3) OR
  (MISSING(tamañohos) AND NOT(SYSMIS(tamañohos)))) OR SYSMIS(tamañohos).
* 0 a 100 por 5.
COMPUTE @0a100por5_barthel3_ = NOT(ANY(VALUE(barthel3), 0, 5, 10, 15, 20, 25,
  30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100) OR
  (MISSING(barthel3) AND NOT(SYSMIS(barthel3)))) OR SYSMIS(barthel3).
COMPUTE @0a100por5_barthel2_ = NOT(ANY(VALUE(barthel2), 0, 5, 10, 15, 20, 25,
  30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100) OR
  (MISSING(barthel2) AND NOT(SYSMIS(barthel2)))) OR SYSMIS(barthel2).
COMPUTE @0a100por5_barthel1_ = NOT(ANY(VALUE(barthel1), 0, 5, 10, 15, 20, 25,
  30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100) OR
  (MISSING(barthel1) AND NOT(SYSMIS(barthel1)))) OR SYSMIS(barthel1).
* Enteros no negativos.
COMPUTE Enterosnonegativos_edad_ = NOT(VALUE(edad)>=0 AND
  VALUE(edad)=TRUNC(VALUE(edad)) OR (MISSING(edad) AND NOT(SYSMIS(edad)))) OR
  SYSMIS(edad).
COMPUTE Enterosnonegativos_tiempo_ = NOT(VALUE(tiempo)>=0 AND
  VALUE(tiempo)=TRUNC(VALUE(tiempo)) OR (MISSING(tiempo) AND
  NOT(SYSMIS(tiempo)))) OR SYSMIS(tiempo).
* 1 a 4 Categórica.
COMPUTE @1a4Categórica_edadcat_ = NOT(ANY(VALUE(edadcat), 1, 2, 3, 4) OR
  (MISSING(edadcat) AND NOT(SYSMIS(edadcat)))) OR SYSMIS(edadcat).
COMPUTE @1a4Categórica_result_ = NOT(ANY(VALUE(result), 1, 2, 3, 4) OR
  (MISSING(result) AND NOT(SYSMIS(result)))) OR SYSMIS(result).
* 0 a 5 Categórica.
DO REPEAT #OV=@0a5Categórica_rango3_ @0a5Categórica_rango2_
  @0a5Categórica_rango1_ @0a5Categórica_rango0_
  /#IV=rango3 rango2 rango1 rango0.
COMPUTE #OV=NOT(ANY(VALUE(#IV), 0, 1, 2, 3, 4, 5) OR (MISSING(#IV) AND
  NOT(SYSMIS(#IV)))) OR SYSMIS(#IV).
END REPEAT.
* Números no negativos.
COMPUTE Númerosnonegativos_coste_ = NOT(VALUE(coste)>=0 OR (MISSING(coste)
  AND NOT(SYSMIS(coste)))) OR SYSMIS(coste).
* 0 a 2 Categórica.
COMPUTE @0a2Categórica_ps_ = NOT(ANY(VALUE(ps), 0, 1, 2) OR (MISSING(ps) AND
  NOT(SYSMIS(ps)))) OR SYSMIS(ps).
* 0 a 1 Dicotomía.
DO REPEAT #OV=@0a1Dicotomía_obesidad_ @0a1Dicotomía_colest_
  @0a1Dicotomía_fuma_ @0a1Dicotomía_im_ @0a1Dicotomía_angina_
  @0a1Dicotomía_activo_ @0a1Dicotomía_nitro_ @0a1Dicotomía_sexo_
  @0a1Dicotomía_diabetes_ @0a1Dicotomía_ic_
  /#IV=obesidad colest fuma im angina activo nitro sexo diabetes ic.
COMPUTE #OV=NOT(ANY(VALUE(#IV), 0, 1) OR (MISSING(#IV) AND NOT(SYSMIS(#IV))))
  OR SYSMIS(#IV).
END REPEAT.
* DosDefunciones.
COMPUTE DosDefunciones_ = (ic = 1) & (exhosp=1).
* Marcar variables de resultados de reglas como tales en el diccionario de
  datos de SPSS.
VARIABLE ATTRIBUTE
   VARIABLES=@0a3Categórica_anticoag_  TO DosDefunciones_
   ATTRIBUTE=$VD.RuleOutcomeVar("Yes").
* Validar datos.
VALIDATEDATA
  VARIABLES=tamañohos edad edadcat sexo activo obesidad diabetes ps fa fuma
  colest angina im nitro anticoag ait tiempo ic rango0 exptac tromboli exhosp
  result cirugia rehab dura_rehab coste rango1 rango2 rango3 barthel1 barthel2
  barthel3 recbart1 recbart2 recbart3
  ID=idhosp idpac idmed
  CROSSVARRULES=$VD.CRule[1]
 /VARCHECKS STATUS=ON PCTMISSING=70 PCTEQUAL=95 PCTUNEQUAL=90 CV=0.001
  STDDEV=0
 /IDCHECKS INCOMPLETE DUPLICATE
 /CASECHECKS REPORTEMPTY=YES SCOPE=ALLVARS
 /CASEREPORT DISPLAY=YES MINVIOLATIONS=1 CASELIMIT=FIRSTN(100)
 /RULESUMMARIES BYVARIABLE.
