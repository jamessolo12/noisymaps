


<cffunction name="getVotesPercentage" access="public" returnType="numeric" output="false" hint="I get all the votes that have been made for a specific artefact and calculate the percentage that are true">
	<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
	<cfset var qGetVotes		= queryNew('') />

	<cfquery name="qGetVotes" datasource="localaws">
		select sum(bPositive) / count(*) * 100 as fltPercent from votes where intArtefactID = 
		<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#arguments.intArtefactID#" />
	</cfquery>


	<cfreturn qGetVotes.fltPercent />
</cffunction>


<cfdump var="#getVotesPercentage(1)#">
<cfdump var="#getVotesPercentage(2)#">
<cfabort>



<p>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam convallis consectetur diam a convallis. Morbi id mauris sed tellus gravida malesuada. Maecenas vel ligula eu nisl aliquet fermentum in ac lorem. Praesent commodo enim libero, a tincidunt ligula. Praesent faucibus orci quis mi vestibulum euismod eu eu felis. Quisque pellentesque luctus nibh, sed venenatis velit posuere sed. Suspendisse facilisis libero at ante ultrices porttitor. Donec dignissim posuere vulputate. Ut sed fermentum mi. Aliquam erat volutpat. Aliquam vestibulum adipiscing rutrum. Phasellus ac gravida odio. In hac habitasse platea dictumst.
</p>

