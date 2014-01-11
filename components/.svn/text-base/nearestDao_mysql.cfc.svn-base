<cfcomponent output="false" extends="nearestDao">
	
	<cffunction name="findNearest" access="public" returntype="query" output="false" hint="I use a stored proc to find the distance between my location (intLat,intLong) and any nearby artefacts.">
		<cfargument name="intCategoryID"	type="numeric" required="true" hint="I am the category of artefact we are looking for" />
		<cfargument name="fltLatitude"		type="numeric" required="true" hint="I am the latitude of where you are now" />
		<cfargument name="fltLongitude"		type="numeric" required="true" hint="I am the longitude of where you are now" />
		<cfargument name="intDistance"		type="numeric" required="true" hint="I am the distance from the point you are searching for" />
		<cfset var qArtefacts	= queryNew('')>
		<!--- Uses law of cosines http://en.wikipedia.org/wiki/Spherical_law_of_cosines --->
		<cfstoredproc datasource="#variables.strDSN#" procedure="getNearbyArtefacts">
			<cfprocparam  cfsqltype="CF_SQL_REAL"		value="#this.fltRadiusMiles#" /> <!--- fltRadius --->
			<cfprocparam  cfsqltype="CF_SQL_REAL"		value="#arguments.fltLatitude#" /> <!--- fltLatitude --->
			<cfprocparam  cfsqltype="CF_SQL_REAL"		value="#arguments.fltLongitude#" /> <!--- fltLongitude --->
			<cfprocparam  cfsqltype="CF_SQL_INTEGER"	value="4" /> <!--- intSearchDegree --->
			<cfprocparam  cfsqltype="CF_SQL_REAL"		value="#arguments.intDistance#" /> <!--- fltDistance ---><!--- distance from the point you are searching for --->
			<cfprocparam  cfsqltype="CF_SQL_INTEGER"	value="#arguments.intCategoryID#" /> <!--- intMyCategoryID --->
			<cfprocresult name="qArtefacts">
		</cfstoredproc>
		
		<cfreturn qArtefacts />
	</cffunction>

	<cffunction name="insertVote" access="public" returnType="void" output="false" hint="I insert a vote on if an artefact exists or not">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		<cfargument name="bVoteTrue"		type="boolean" required="true" hint="I am the vote, true or false." />
		<cfset var qInsert		= queryNew('') />
		
		<cfquery name="qInsert" datasource="#variables.strDSN#">
			insert into votes
			(intArtefactId,bPositive)
			values
			(
				<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#arguments.intArtefactID#" />,
				<cfqueryparam cfsqltype="CF_SQL_BIT"		value="#arguments.bVoteTrue#" />
			)
		</cfquery>
	</cffunction>

	<cffunction name="getVotesPercentage" access="public" returnType="numeric" output="false" hint="I get all the votes that have been made for a specific artefact and calculate the percentage that are true">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		<cfset var qGetVotes		= queryNew('') />

		<cfquery name="qGetVotes" datasource="localaws">
			select sum(bPositive) / count(*) * 100 as fltPercent from votes where intArtefactID = 
			<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#arguments.intArtefactID#" />
		</cfquery>

		<cfif qGetVotes.recordcount AND qGetVotes.fltPercent NEQ ''>
			<cfreturn qGetVotes.fltPercent />
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>

</cfcomponent>