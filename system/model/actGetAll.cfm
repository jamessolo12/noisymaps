<!--- Get All artefacts --->
<cfset variables.qArtefacts	=	application.oNearestBusiness.getAll() />

<!---

This isn't working

<!--- Now lets try server side working out of where we are. --->
<cfif cgi.remote_addr eq "127.0.0.1">
	<cfset variables.strIP	= "82.111.156.194">
<cfelse>
	<cfset variables.strIP	= cgi.remote_addr>
</cfif>

<!--- We're going to get the users IP address and figure out where they are. --->
<cfhttp url="http://api.hostip.info/get_json.php" method="POST" resolveurl="Yes" throwOnError="Yes">
	<cfhttpparam type="formField" name="ip" value="#variables.strIP#" />
	<cfhttpparam type="formField" name="position" value="true" />
</cfhttp>

<cfset variables.stuIPLookups	= DeserializeJSON(cfhttp.fileContent)>

<cfdump var="#variables.stuIPLookups#">
<cfabort>


<!--- If we can't get the exact lat and long from hostip lets take the country they provided and see if google can find the lat long --->
<cfif variables.stuIPLookups.lat eq "null" OR variables.stuIPLookups.lng eq "null">
	<cfhttp url="http://maps.googleapis.com/maps/api/geocode/json"method="POST" resolveurl="Yes" throwOnError="Yes">
		<cfhttpparam type="formField" name="address"	value="#variables.stuIPLookups.country_name#" />
		<cfhttpparam type="formField" name="sensor"		value="true" />
	</cfhttp>
	
	<cfset variables.stuIPLookups	= DeserializeJSON(cfhttp.fileContent)>
	<cfset variables.fltLatitude	= variables.stuIPLookups.results[1].geometry.location.lat>
	<cfset variables.fltLongitude	= variables.stuIPLookups.results[1].geometry.location.lng>
	<cfset variables.intZoomLevel	= 5>
<cfelse>
	<cfset variables.fltLatitude	= variables.stuIPLookups.lat>
	<cfset variables.fltLongitude	= variables.stuIPLookups.lng>
	<cfset variables.intZoomLevel	= 5>
</cfif>

<cfcatch>
	<cfdump var="#cfcatch#">
</cfcatch>
</cftry>

--->