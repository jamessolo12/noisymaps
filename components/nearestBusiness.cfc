<cfcomponent output="false">

	<cffunction name="init" access="public" output="false" returntype="nearestBusiness">
		<cfargument name="oNearestDao" type="nearestDao" required="true">
		<cfscript>
			variables.oNearestDao			= arguments.oNearestDao;
			
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="getAllCategories" access="public" output="false" returntype="query" hint="I return a query of all categories we have">
		<cfreturn variables.oNearestDao.getAllCategories() />
	</cffunction>
	
	<cffunction name="lookupCategory" access="public" output="false" returntype="string" hint="I take in a categoryID and return the string name of the category">
		<cfargument name="intCategoryID" type="numeric" required="true" hint="I am the categoryID which I am looking for">
		
		<cfreturn variables.oNearestDao.lookupCategory(intCategoryID	= arguments.intCategoryID) />
	</cffunction>
	
	<cffunction name="findNearest" access="public" output="false" returntype="query" hint="I take in latitude and longitude and return all artefacts with a given categoryID and their distance from that lat and long.">
		<cfargument name="intCategoryID"	type="numeric" required="true">
		<cfargument name="fltLatitude"		type="numeric" required="true">
		<cfargument name="fltLongitude"		type="numeric" required="true">
		<cfargument name="intDistance"		type="numeric" required="true" hint="I am the distance from the point you are searching for" />
		
		<cfreturn variables.oNearestDao.findNearest(argumentCollection = arguments) />
	</cffunction>
	
	<cffunction name="insertArtefact" access="public" output="false" returntype="void" hint="I insert a new artefact into the db">
		<cfargument name="intCategoryID"	type="numeric"	required="true" />
		<cfargument name="fltLatitude"		type="numeric"	required="true" />
		<cfargument name="fltLongitude"		type="numeric"	required="true" />
		<cfargument name="strName"			type="string"	required="true" />
		
		<cfreturn variables.oNearestDao.insertArtefact(argumentCollection = arguments) />
	</cffunction>
	
	<cffunction name="getAll" access="public" output="false" returntype="query" hint="I return a query of all artefacts">
		<cfreturn variables.oNearestDao.getAll() />
	</cffunction>
	
	<cffunction name="calcBearings" access="public" output="false" returntype="query" hint="I take in a query of artefacts and calculate the heading for each artefact">
		<cfargument name="qArtefacts"				type="query"	required="true" hint="">
		<cfargument name="fltCurrentLatitude"		type="numeric"	required="true" />
		<cfargument name="fltCurrentLongitude"		type="numeric"	required="true" />

		<cfreturn variables.oNearestDao.calcBearings(argumentCollection = arguments) />
	</cffunction>

	<cffunction name="getArtefactDetails" access="public" returnType="query" output="false" hint="Get a query about a specific artefact">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		
		<cfreturn variables.oNearestDao.getArtefactDetails(intArtefactID = arguments.intArtefactID) />
	</cffunction>

	<cffunction name="insertVote" access="public" returnType="void" output="false" hint="I insert a vote on if an artefact exists or not">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		<cfargument name="bVoteTrue"		type="boolean" required="true" hint="I am the vote, true or false." />

		<cfreturn variables.oNearestDao.insertVote(argumentCollection = arguments) />
	</cffunction>

	<cffunction name="getVotesPercentage" access="public" returnType="numeric" output="false" hint="I get all the votes that have been made for a specific artefact and calculate the percentage that are true">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />

		<cfreturn variables.oNearestDao.getVotesPercentage(intArtefactID = arguments.intArtefactID) />
	</cffunction>


</cfcomponent>