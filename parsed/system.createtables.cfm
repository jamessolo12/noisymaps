<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: system --->
<!--- fuseaction: createTables --->
<cftry>
<!--- fuseaction action="system.getXfas" --->
<cfset myFusebox.thisPhase = "preprocessFuseactions">
<cfset myFusebox.thisCircuit = "system">
<cfset myFusebox.thisFuseaction = "getXfas">
<cfset xfa.home = "home.welcome" />
<cfset xfa.ineed = "ineed.main" />
<cfset xfa.ihave = "ihave.main" />
<cfset xfa.ineedresults = "ineed.searchResults" />
<cfset xfa.ihavesubmit = "ihave.subitNew" />
<cfset xfa.thanks = "shared.thanks" />
<cfset xfa.infoWindow = "ajax.showInfoWindow" />
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset myFusebox.thisFuseaction = "createTables">
<cftry>
<cfoutput><cfinclude template="../system/model/createTables_mysql.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 28 and right(cfcatch.MissingFileName,28) is "model/createTables_mysql.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse model/createTables_mysql.cfm in circuit system which does not exist (from fuseaction system.createTables).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>

