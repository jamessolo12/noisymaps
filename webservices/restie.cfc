<cfcomponent rest="true" restpath="/hello">


	<cffunction name="getsome" access="remote" returntype="string" httpmethod="GET" restpath="/getsome">
		<cfreturn '[1,2,3,4,4,7]' />
	</cffunction>


	<cffunction name="getall" access="remote" produces="application/json" httpMethod="GET" restPath="/getall">
		<cfscript>
			var intRow			= 0;
			var arrMarkers	= [];
			var stuArtefact		= {};
			var qAllArtefacts = application.oNearestBusiness.getAll();
			
			/*
			[
				{
				"id": 1,
					"categoryId": 2,
					"fltLongitude": -0.111537,
					"fltLatitude": 51.51817
				},
				{
					"id": 2,
					"categoryId": 3,
					"fltLongitude": -0.097589,
					"fltLatitude": 51.514912
				}
			]
			*/
			
			//Data needs to be an array of objects, so we'll use structs and let serializeJson do the work.
			for(intRow = 1; intRow LT qAllArtefacts.RecordCount; intRow ++){
				stuArtefact	= {
					id				= qAllArtefacts.intArtefactId[intRow], 
					categoryId		= qAllArtefacts.intCategoryID[intRow], 
					fltLongitude	= qAllArtefacts.gpsLongitude[intRow], 
					fltLatitude		= qAllArtefacts.gpsLatitude[intRow]
				};
				arrMarkers[intRow]	= stuArtefact;
			}
		
			response	= {
				status		= 200,
				headers		= {},
				content		= serializeJson(arrCategories)
			};
		
			restSetResponse(response);
		</cfscript>
	</cffunction>


	<cffunction name="getCategories" access="remote" produces="application/json" httpmethod="GET" restpath="/getcategories" hint="I get all available categories">
		<cfscript>
			var intRow			= 0;
			var arrCategories	= [];
			var qCategories		= application.oNearestBusiness.getAllCategories();
			//json to be returned in format as such:
			//[{"NAME":"Post Office","ID":1},{"NAME":"Phone Box","ID":2},{"NAME":"Post Box","ID":3},{"NAME":"Cash Point","ID":4},{"NAME":"Hospital","ID":5}] ]
		
			//Data needs to be an array of objects, so we'll use structs and let serializeJson do the work.
			for(intRow = 1; intRow LTE qCategories.RecordCount; intRow ++){
				arrCategories[intRow]	= {id = qCategories.intCategoryId[intRow], name = qCategories.strCategoryName[intRow]};
			}
			
			response	= {
				status		= 200,
				headers		= {},
				content		= serializeJson(arrCategories)
			};
		
			restSetResponse(response);
		</cfscript>
	</cffunction>


	<cffunction name="getnearest" access="remote" produces="application/json" httpMethod="GET" restPath="/getnearest/intcategoryid/{intcategoryid}/fltlatitude/{fltlatitude}/fltlongitude/{fltlongitude}/intdistance/{intdistance}">
		<cfargument name="intcategoryid"	type="numeric"	restArgSource="Path">
		<cfargument name="fltlatitude"		type="numeric"	restArgSource="Path">
		<cfargument name="fltlongitude"		type="numeric"	restArgSource="Path">
		<cfargument name="intdistance"		type="numeric"	restArgSource="Path">
		<cfscript>
			var intRow			= 0;
			var arrMarkers		= [];
			var stuArtefact		= {};
			var qArtefacts		= application.oNearestBusiness.findNearest(argumentCollection = arguments);
			
			//Data needs to be an array of objects, so we'll use structs and let serializeJson do the work.
			for(intRow = 1; intRow LTE qArtefacts.RecordCount; intRow ++){
				stuArtefact	= {
					id				= qArtefacts.intArtefactId[intRow], 
					categoryId		= qArtefacts.intCategoryID[intRow],
					fltDistance		= qArtefacts.fltDistance[intRow],
					strName			= qArtefacts.strName[intRow],
					strJsIconName	= qArtefacts.strJsIconName[intRow],
					fltLongitude	= qArtefacts.gpsLongitude[intRow], 
					fltLatitude		= qArtefacts.gpsLatitude[intRow]
				};
				arrMarkers[intRow]	= stuArtefact;
			}
		
			response	= {
				status		= 200,
				headers		= {},
				content		= serializeJson(arrMarkers)
			};
		
			restSetResponse(response);
		</cfscript>
	</cffunction>


	<cffunction name="addnew" access="remote" produces="application/json" httpMethod="POST" restPath="/addnew/">
		<cfargument name="intcategoryid"	type="numeric"	restArgSource="Form" />
		<cfargument name="fltlatitude"		type="numeric"	restArgSource="Form" />
		<cfargument name="fltlongitude"		type="numeric"	restArgSource="Form" />
		<cfargument name="strname"			type="string"	restArgSource="Form" />
		
		<cfset application.oNearestBusiness.insertArtefact(argumentCollection = arguments)>
	</cffunction>
	

</cfcomponent>