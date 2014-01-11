<cfparam name="form.txtLatitude"	type="string"	default="" />
<cfparam name="form.txtLongitude"	type="string"	default="" />
<cfparam name="form.sel_category"	type="numeric"	default="0" />
<cfparam name="form.txtName"		type="string"	default="" />
<cfset variables.stuValidate.bValid			=	true>
<cfset variables.stuValidate.strErrorMsg	=	"">

<!--- 1) Verify values--->
<cfif (form.sel_category LT 0)>
	<cfset variables.stuValidate.strErrorMsg	&=	"<li>Invalid Category</li>">
	<cfset variables.stuValidate.bValid			=	false>
</cfif>
	
<!--- 2) Verify Longitude --->
<cfif (not LEN(form.txtLongitude)) OR (not refind("(-?[0-8]?[0-9](\.\d*)?)|-?90(\.[0]*)?",form.txtLongitude))>
	<cfset variables.stuValidate.strErrorMsg	&=	"<li>Invalid Longitude</li>">
	<cfset variables.stuValidate.bValid			=	false>
</cfif>

<!---  and Latitude --->
<cfif (not LEN(form.txtLatitude)) OR (not refind("(-?([1]?[0-7][1-9]|[1-9]?[0-9])?(\.\d*)?)|-?180(\.[0]*)?",form.txtLatitude))>
	<cfset variables.stuValidate.strErrorMsg	&=	"<li>Invalid Latitude</li>">
	<cfset variables.stuValidate.bValid			=	false>
</cfif>



<!--- 3) Check to see if we already have that artefact...not sure how to do this yet --->