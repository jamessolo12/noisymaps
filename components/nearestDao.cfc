<cfcomponent>
	
	<cffunction name="init" access="public" output="false" returntype="nearestDao">
		<cfargument name="strDSN" type="string" required="true">
		<cfscript>
			variables.strDSN			= arguments.strDSN;
			
			this.fltRadiusKiloMeters	= 111.3195; // KM
			this.fltRadiusMiles			= 69.17073; // MI
			
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getAllCategories" access="public" output="false" returntype="query" hint="I return a query of all categories we have">
		<cfset var qCategorys	=	queryNew('') />
		
		<cfquery name="qCategorys" datasource="#variables.strDSN#">
			select intCategoryId, strCategoryName from category
		</cfquery>
		
		<cfreturn qCategorys />
	</cffunction>

	<cffunction name="lookupCategory" access="public" output="false" returntype="string" hint="I take in a categoryID and return the string name of the category">
		<cfargument name="intCategoryID" type="numeric" required="true" hint="I am the categoryID which I am looking for">
		<cfset var qGetCategory	=	queryNew("") />
		<cfset var strCategory	=	"" />
		
		<cfquery name="qGetCategory" datasource="#variables.strDSN#">
			select strCategoryName from category where intCategoryID = 
			<cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#arguments.intCategoryID#" />
		</cfquery>
		
		<cfif qGetCategory.recordcount>
			<cfset strCategory	=	qGetCategory.strCategoryName>
		</cfif>
		
		<cfreturn strCategory />
	</cffunction>
	
	<cffunction name="insertArtefact" access="public" output="false" returntype="void" hint="I insert a new artefact into the db">
		<cfargument name="intCategoryID"	type="numeric"	required="true" />
		<cfargument name="fltLatitude"		type="numeric"	required="true" />
		<cfargument name="fltLongitude"		type="numeric"	required="true" />
		<cfargument name="strName"			type="string"	required="true" />
		<cfset var qInsNewHave =	queryNew('') />
		
		<!--- Should check and prevent duplicates --->
		
		<cfquery name="qInsNewHave" datasource="#variables.strDSN#">
			insert into artefact
			(intCategoryID,gpsLongitude,gpsLatitude,strName)
			values
			(
				<cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#arguments.intCategoryID#" />,
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLongitude#" />,
				<cfqueryparam cfsqltype="CF_SQL_REAL" value="#arguments.fltLatitude#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.strName#" />
			)
		</cfquery>
	</cffunction>
	
	<cffunction name="getAll" access="public" output="false" returntype="query" hint="I return a query of all artefacts">
		<cfset var qArtefacts	=	queryNew('') />
		<cfquery name="qArtefacts" datasource="#variables.strDSN#">
			SELECT * FROM artefact a join category c on a.intCategoryID = c.intCategoryID
		</cfquery>
		<cfreturn qArtefacts />
	</cffunction>
	
	<cffunction name="calcBearings" access="public" output="false" returntype="query" hint="I take in a query of artefacts and calculate the heading for each artefact">
		<cfargument name="qArtefacts"				type="query"	required="true" hint="">
		<cfargument name="fltCurrentLatitude"		type="numeric"	required="true" />
		<cfargument name="fltCurrentLongitude"		type="numeric"	required="true" />
		<cfset var qReturn		=	arguments.qArtefacts />
		<cfset var stuArgs		=	structNew() />
		<cfset var intBearing	=	0 />
		<cfset var intCounter	=	0 />
		<cfset var strHeading	=	"" />
		
		<!--- Add bearing column --->
		<cfset queryAddColumn(qReturn,"fltBearing","VarChar",arrayNew(1)) />
		<cfset queryAddColumn(qReturn,"strHeading","VarChar",arrayNew(1)) />
		
		<cfloop query="qReturn">
			<cfscript>
				intCounter		=	intCounter + 1;
				stuArgs.lat1	=	arguments.fltCurrentLatitude;
				stuArgs.lon1	=	arguments.fltCurrentLongitude;
				stuArgs.lat2	=	qReturn.gpsLatitude[intCounter];
				stuArgs.lon2	=	qReturn.gpsLongitude[intCounter];
			
				//get the bearing (as in bearing on a compass)
				intBearing		=	getBearing(argumentCollection	=	stuArgs);
				//work out the cardinal point (NESW)
				strHeading		=	getHeading(intBearing			=	intBearing);
			
				//put these values into the query
				querySetCell(qReturn,"fltBearing",intBearing,intCounter);
				querySetCell(qReturn,"strHeading",strHeading,intCounter);
			</cfscript>
		</cfloop>
		
		<cfreturn qReturn />
	</cffunction>

	<cffunction name="getArtefactDetails" access="public" returnType="query" output="false" hint="Get a query about a specific artefact">
		<cfargument name="intArtefactID"	type="numeric" required="true" hint="I am the artefact ID" />
		<cfset var qGetArtefact	= queryNew('') />
		
		<cfquery name="qGetArtefact" datasource="#variables.strDSN#">
			select a.*, c.strCategoryName
			from artefact a
			left join category c on c.intCategoryId = a.intCategoryId
			where a.intArtefactID = 
			<cfqueryparam cfsqltype="CF_SQL_NUMERIC"	value="#arguments.intArtefactID#" />
		</cfquery>
		
		<cfreturn qGetArtefact />
	</cffunction>
	
	
	
<!--- PACKAGE FUNCTIONS --->
	
	<cffunction name="atan2" access="package" output="false" returntype="numeric" hint="">
		<cfargument name="firstArg"		type="numeric" required="true" hint="">
		<cfargument name="secondArg"	type="numeric" required="true" hint="">
		<cfset var objMath = createObject("java","java.lang.Math") />
		<cfreturn objMath.atan2(javacast("double",firstArg), javacast("double",secondArg)) />
	</cffunction>
	
	<cffunction name="toRad" access="package" output="false" returntype="numeric" hint="">
		<cfargument name="fltNum" type="numeric" required="true" hint="">
		<cfreturn arguments.fltNum * Pi() / 180 />
	</cffunction>
	
	<cffunction name="toDeg" access="package" output="false" returntype="numeric" hint="">
		<cfargument name="fltNum" type="numeric" required="true" hint="">
		<cfreturn arguments.fltNum * 180 / Pi() />
	</cffunction>
	
	<cffunction name="getHeading" access="package" output="false" returntype="string" hint="">
		<cfargument name="intBearing" type="numeric" required="true" hint="">
		<cfscript>
			var strCardinal	=	"";
	
			if(arguments.intBearing GT 0 and arguments.intBearing LTE 22.5){
				strCardinal	=	"N";
			}
			else if(arguments.intBearing GT 22.5 and arguments.intBearing LTE 67.5){
				strCardinal	=	"NE";
			}
			else if(arguments.intBearing GT 67.5 and arguments.intBearing LTE 112.5){
				strCardinal	=	"E";
			}
			else if(arguments.intBearing GT 112.5 and arguments.intBearing LTE 157.5){
				strCardinal	=	"SE";
			}
			else if(arguments.intBearing GT 157.5 and arguments.intBearing LTE 202.5){
				strCardinal	=	"S";
			}
			else if(arguments.intBearing GT 202.5 and arguments.intBearing LTE 247.5){
				strCardinal	=	"SW";
			}
			else if(arguments.intBearing GT 247.5 and arguments.intBearing LTE 292.5){
				strCardinal	=	"W";
			}
			else if(arguments.intBearing GT 292.5 and arguments.intBearing LTE 337.5){
				strCardinal	=	"NW";
			}
			else if(arguments.intBearing GT 337.5 and arguments.intBearing LTE 360.1){
				strCardinal	=	"N";
			}
	
			return strCardinal;
		</cfscript>
	</cffunction>
	
	<cffunction name="getBearing" access="package" output="false" returntype="numeric" hint="">
		<cfargument name="lat1" type="numeric" required="true" hint="">
		<cfargument name="lon1" type="numeric" required="true" hint="">
		<cfargument name="lat2" type="numeric" required="true" hint="">
		<cfargument name="lon2" type="numeric" required="true" hint="">
		
		<cfscript>
		    var dLon	= toRad((arguments.lon2-arguments.lon1));
		    var lat3	= toRad(arguments.lat1);
		    var lat4	= toRad(arguments.lat2);
		    var fltBrng = 0;
		 
		 	//very complicated math stuff
		    y = sin(dLon) * cos(lat4);
		    x = cos(lat3) * sin(lat4) - sin(lat3) * cos(lat4) * cos(dLon);
		    fltBrng = toDeg(atan2(y, x));
		 
			//not sure of the math of this, but sometimes N & W return negative
			if (fltBrng < 0){
		        return (180 + (180 + fltBrng));
		    }else{
		        return fltBrng;
			}
		</cfscript>
	</cffunction>

	
</cfcomponent>