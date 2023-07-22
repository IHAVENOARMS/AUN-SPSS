#/***********************************************************************
# * Licensed Materials - Property of IBM 
# *
# * IBM SPSS Products: Statistics Common
# *
# * (C) Copyright IBM Corp. 1989, 2011
# *
# * US Government Users Restricted Rights - Use, duplication or disclosure
# * restricted by GSA ADP Schedule Contract with IBM Corp. 
# ************************************************************************/

helptext="The SPSSINC RASCH DEMO command requires the R Integration Plug-in
and the R ltm package.

SPSSINC RASCH DEMO
/VARIABLES ITEMS=variable list
[/OPTIONS [MISSING={LISTWISE**, ALLAVAILABLE}] ]

Split files and weight are not honored by this command.

SPSSINC RASCH DEMO /HELP prints this information and does nothing else.

Example:
SPSSINC RASCH DEMO item1 item2 item3 item4 item5.

Execute the rasch function from the R ltm package.
The command line variable list specifies the items.  It is assumed that
the values of these variables is 0,1.

MISSING=LISTWISE causes listwise deletion of missing values.  ALLAVAILABLE
causes all available information to be used; i.e., cases with missing values
are still used.
"

run_rasch<-function(items, missing="listwise")
{
    tryCatch(library(ltm), error=function(e){
        stop("The R ltm package is required but could not be loaded.",call.=FALSE)
        }
    )

    if (identical(missing,"listwise")) {missing<-na.exclude} else {missing<-NULL}
    
    dta<-spssdata.GetDataFromSPSS(items,missingValueToNA=TRUE)

    res <- tryCatch(
            summary(fit<-rasch(data=dta,na.action=missing)),
            error=function(e) {return(c("ERROR:",e))}
           )
    
    if (!is.null(res$message)) {print(res$message)} else {
        miss<-ifelse(identical(missing,na.exclude),"na.exclude","NULL")
        spsspkg.StartProcedure("Rasch Model")
        spsspivottable.Display(res$coefficients, 
            title="Coefficients",
            templateName="SPSSINCRasch",
            caption=paste("rasch(data = dta, na.action = ",miss,")",sep=""),
            isSplit=FALSE)
        spsspkg.EndProcedure()
    }

    res <- tryCatch(rm(list=ls()),warning=function(e){return(NULL)})
    
}

Run<-function(args){
    args <- args[[2]]
    oobj<-spsspkg.Syntax(templ=list(
                spsspkg.Template(kwd="ITEMS",subc="VARIABLES",ktype="existingvarlist",var="items",islist=TRUE),
                spsspkg.Template(kwd="MISSING",subc="OPTIONS",ktype="str",var="missing")
                ))

    if ("HELP" %in% attr(args,"names"))
        writeLines(helptext)
    else
        res <- spsspkg.processcmd(oobj,args,"run_rasch")
        
}