<cfparam name="intErrorCode" type="numeric" default="0">
<cfswitch expression="#intErrorCode#">
	<cfcase value="1">
		<cfset variables.strError	=	"Invalid params" />
	</cfcase>
	<cfdefaultcase>
		<cfset variables.strError	=	"Unkown Error" />
	</cfdefaultcase>
</cfswitch>
<h2>Error</h2>
<cfoutput><p>#variables.strError#</p></cfoutput>