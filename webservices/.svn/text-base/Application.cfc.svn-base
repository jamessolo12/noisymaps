<cfcomponent output="false">
	<!--- set application name --->
	<cfset this.name 			= "api" />
	<cfset this.strDsn			= "localaws"/>
	
	<cffunction name="onApplicationStart" access="public" returnType="boolean" output="false">
		<cfset var oNearestDao				= createObject("component","noisymaps.components.nearestDao_mysql").init(strDSN	= this.strDsn) />
		<cfset application.oNearestBusiness	= createObject("component","noisymaps.components.nearestBusiness").init(oNearestDao	= oNearestDao) />
		<cfreturn true />
	</cffunction>
	
</cfcomponent>