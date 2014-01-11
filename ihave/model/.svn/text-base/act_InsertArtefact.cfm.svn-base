<!--- 4) Insert --->
<cfset variables.stuArgs				=	structNew() />
<cfset variables.stuArgs.intCategoryID	=	form.sel_category />
<cfset variables.stuArgs.fltLatitude	=	form.txtLatitude />
<cfset variables.stuArgs.fltLongitude	=	form.txtLongitude />
<cfset variables.stuArgs.strName		=	form.txtName />
<cfset application.oNearestBusiness.insertArtefact(argumentCollection	=	variables.stuArgs) />