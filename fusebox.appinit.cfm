<!---
	fusebox.appinit.cfm is included by the framework when the application is
	started, i.e., on the very first request (in production mode) or whenever
	the framework is reloaded, either with development-full-load mode or when
	fusebox.load=true or fusebox.loadclean=true is specified.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-application initialization that can not easily be
	done in the appinit global fuseaction.
	It is included inside a conditional lock, ensuring that only one request
	can execute this file.
	
	For example, if you are sharing application variables between a Fusebox
	application and a non-Fusebox application, you can initialize them here
	and then cfinclude this file into your non-Fusebox application.
--->

<!--- I check the cgi.http_host and decide if we should be using local relative file paths or LIVE (aws S3) file paths --->
<cfif cgi.HTTP_HOST EQ "www.scribble.local">
	<cfset application.stuHeaders.strJquery		= "/js/jquery.min.js">
	<cfset application.stuHeaders.strNoisyMaps	= "/js/noisyMaps_markers.js">
	<cfset application.stuHeaders.strBootstrap	= "/css/bootstrap.min.css">
	<cfset application.stuHeaders.strNormalCss	= "/css/noisymaps.css">
	<cfset application.stuHeaders.strMapCss		= "/css/noisymaps_maps.css">
	<cfset application.strDsn					= "AWSphrases"/>
	<cfset application.oNearestDao				= createObject("component","components.nearestDao_derby").init(strDSN	=	application.strDsn) />
<cfelse>
	<cfset application.stuHeaders.strJquery		= "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js">
	<cfset application.stuHeaders.strNoisyMaps	= "http://s3.amazonaws.com/noisyJS/noisyMaps_markers.js">
	<cfset application.stuHeaders.strBootstrap	= "//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css">
	<cfset application.stuHeaders.strNormalCss	= "http://s3.amazonaws.com/noisyCSS/noisymaps.css">
	<cfset application.stuHeaders.strMapCss		= "http://s3.amazonaws.com/noisyCSS/noisymaps_maps.css">
	<cfset application.strDsn					= "localaws"/>
	<cfset application.oNearestDao				= createObject("component","components.nearestDao_mysql").init(strDSN	=	application.strDsn) />
</cfif>

<cfset application.oNearestBusiness	=	createObject("component","components.nearestBusiness").init(oNearestDao	=	application.oNearestDao) />