<cfparam name="url.intArtefactId"	type="numeric"	default="0">
<cfparam name="url.bIsSmile"		type="boolean"	default="true">
<cfset request.cancelFooter	= true>
<cfinvoke component="#application.oNearestBusiness#" method="insertVote">
	<cfinvokeargument name="intArtefactID"	value="#url.intArtefactId#" />
	<cfinvokeargument name="bVoteTrue"		value="#url.bIsSmile#" />
</cfinvoke>