<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: ajax --->
<!--- fuseaction: showInfoWindow --->
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
<cfset myFusebox.thisCircuit = "ajax">
<cfset myFusebox.thisFuseaction = "showInfoWindow">
<cfif not isDefined("url.intArtefactId")><cfset url.intArtefactId = "0" /></cfif>
<cftry>
<cfoutput><cfinclude template="../ajax/model/actInfoWindow.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 23 and right(cfcatch.MissingFileName,23) is "model/actInfoWindow.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse model/actInfoWindow.cfm in circuit ajax which does not exist (from fuseaction ajax.showInfoWindow).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cftry>
<cfoutput><cfinclude template="../ajax/display/dspInfoWindow.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 25 and right(cfcatch.MissingFileName,25) is "display/dspInfoWindow.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse display/dspInfoWindow.cfm in circuit ajax which does not exist (from fuseaction ajax.showInfoWindow).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>

