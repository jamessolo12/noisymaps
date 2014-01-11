<cfcomponent output="false" extends="nearestDao">

	
	<cffunction name="findNearest" access="public" output="false" returntype="query" hint="I take in latitude and longitude and return all artefacts with a given categoryID and their distance from that lat and long.">
		<cfargument name="intCategoryID"	type="numeric" required="true">
		<cfargument name="fltLatitude"		type="numeric" required="true">
		<cfargument name="fltLongitude"		type="numeric" required="true">
		<cfargument name="intDistance"		type="numeric" required="true" hint="I am the distance from the point you are searching for" />
		<cfset var qArtefacts	=	queryNew("") />
		
		<cfset var searchDegree =	4 />
		<cfset var fltRadius 	=	111.3195 /> <!--- km --->
		<cfset var fltRadius 	=	69.17073 /> <!--- mi --->
		<!---
			To calculate the distance between two points (Latitude/Longitude pairs) on the earth's surface, we have to use Spherical Law of Cosines 
			(http://en.wikipedia.org/wiki/Spherical_law_of_cosines) shown below:
			d = acos( sin(φ1).sin(φ2) + cos(φ1).cos(φ2).cos(Δλ) ).R
			where: φ = latitude, λ = longitude, R = radius of earth, d = distance between the points
		--->
		
		
		<!--- Do complicated math type thing in sql --->
		<cfquery name="qArtefacts" datasource="#variables.strDSN#">
			Select <cfqueryparam cfsqltype="CF_SQL_REAL" value="#fltRadius#"/> * Degrees(
				acos(
					sin(radians(<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#"/>)) * sin(radians(gpsLatitude))
					+
					cos(radians(<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#"/>)) * cos(radians(gpsLatitude)) * cos(radians(gpsLongitude)-radians(<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLongitude#"/>))
				)
			) As fltDistance,
			a.intArtefactId, a.strName, a.gpsLongitude, a.gpsLatitude, a.intCategoryID, c.strJsIconName
			From artefact a
			join category c on a.intCategoryID = c.intCategoryID
			Where
			a.intCategoryID = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#arguments.intCategoryID#"/>
			AND 
			(
				gpsLatitude between
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#"/> - #searchDegree#
				and
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#"/> + #searchDegree#
			)
			And
			(
				gpsLongitude between
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLongitude#"/> - #searchDegree#
				and
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLongitude#"/> + #searchDegree#
			)
			And
			(
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#fltRadius#"/> * Degrees(
					acos(
						sin(radians(<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#"/>))* sin(radians(gpsLatitude))
						+
						cos(radians(<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#"/>)) * cos(radians(gpsLatitude)) * cos(radians(gpsLongitude)-radians(<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLongitude#"/>))
					)
				)
			) < <cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.intDistance#"/>
			Order By fltDistance, intArtefactId
		</cfquery>
		
		<cfreturn qArtefacts />
	</cffunction>

	<cffunction name="insertVote" access="public" returnType="void" output="false" hint="I insert a vote on if an artefact exists or not">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		<cfargument name="bVoteTrue"		type="boolean" required="true" hint="I am the vote, true or false." />
		<cfset var qInsert		= queryNew('') />
		<cfset var intVote		= 0>
		
		<!--- Apache Derby doesn't do BOOLEAN :( --->
		<cfif arguments.bVoteTrue>
			<cfset var intVote	= 1>
		</cfif>
		
		<cfquery name="qInsert" datasource="#variables.strDSN#">
			insert into votes
			(intArtefactId,bPositive)
			values
			(
				<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#arguments.intArtefactID#" />,
				<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#intVote#" />
			)
		</cfquery>
	</cffunction>

	<cffunction name="getVotesPercentage" access="public" returnType="numeric" output="false" hint="I get all the votes that have been made for a specific artefact and calculate the percentage that are true">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		<cfset var qGetVotes		= queryNew('') />
		<cfset var intPositiveVotes	= 0 />
		<cfset var fltPercent		= 0.0 />

		<!--- This is lame, but apache derby can't do percentage calculations unfortunately :( --->
		
		<cfquery name="qGetVotes" datasource="#variables.strDSN#">
			select bPositive
			from votes 
			where intArtefactID = 
			<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#arguments.intArtefactID#" />
		</cfquery>
		
		<cfif qGetVotes.recordcount>
			<cfset intPositiveVotes	= arraySum(listToArray(valueList(qGetVotes.bPositive))) />
			<cfset fltPercent		= intPositiveVotes * 100 / qGetVotes.recordcount />
		</cfif>
		
		<cfreturn fltPercent />
	</cffunction>

</cfcomponent>