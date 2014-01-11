<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: home --->
<!--- fuseaction: welcome --->
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
<cfset myFusebox.thisCircuit = "home">
<cfset myFusebox.thisFuseaction = "welcome">
<cftry>
<cfsavecontent variable="strContent"><cfoutput><cfinclude template="../home/display/dsp_welcome.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 23 and right(cfcatch.MissingFileName,23) is "display/dsp_welcome.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse display/dsp_welcome.cfm in circuit home which does not exist (from fuseaction home.welcome).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<!--- do action="shared.mainLayout" --->
<!--- do action="footer" --->
<cfset myFusebox.thisCircuit = "shared">
<cfset myFusebox.thisFuseaction = "footer">
<cfsavecontent variable="strFooter">
<cftry>
<cfoutput><cfinclude template="../shared/display/dsp_footer.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 22 and right(cfcatch.MissingFileName,22) is "display/dsp_footer.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse display/dsp_footer.cfm in circuit shared which does not exist (from fuseaction shared.footer).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfsavecontent>
<cfset myFusebox.thisFuseaction = "mainLayout">
<cftry>
<cfoutput><cfinclude template="../shared/layout/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 23 and right(cfcatch.MissingFileName,23) is "layout/lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse layout/lay_template.cfm in circuit shared which does not exist (from fuseaction shared.mainLayout).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>

