<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: system --->
<!--- fuseaction: setup --->
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
<cfset myFusebox.thisFuseaction = "setup">
<cftry>
<cfoutput><cfinclude template="../system/model/actSetup.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 18 and right(cfcatch.MissingFileName,18) is "model/actSetup.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse model/actSetup.cfm in circuit system which does not exist (from fuseaction system.setup).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>

