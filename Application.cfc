<cfcomponent extends="fusebox5.Application" output="false">
	<!--- set application name based on the directory path --->
	<cfset this.name = "myNearest" />
	
	<!--- enable debugging --->
	<cfset FUSEBOX_PARAMETERS.debug = false />
	
	<!--- force the directory in which we start to ensure CFC initialization works: --->
	<cfset FUSEBOX_CALLER_PATH = getDirectoryFromPath(getCurrentTemplatePath()) />

</cfcomponent>