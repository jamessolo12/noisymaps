<cfparam name="form.sel_category"	type="numeric"	default="0" />
<cfparam name="form.txtLatitude"	type="string"	default="" />
<cfparam name="form.txtLongitude"	type="string"	default="" />

<cfset application.oNearestDao		=	createObject("component","components.nearestDao_mysql").init(strDSN	=	application.strDsn) />
<cfset application.oNearestBusiness	=	createObject("component","components.nearestBusiness").init(oNearestDao	=	application.oNearestDao) />

<cfscript>
	
	
	//validate
	variables.stuErrors							= structNew();
	variables.stuErrors.bLatOk					= len(form.txtLatitude);
	variables.stuErrors.bLonOk					= len(form.txtLongitude);
	variables.stuErrors.bCatOK					= len(form.sel_category);
	variables.stuErrors.bNoErrors				= variables.stuErrors.bLatOk && variables.stuErrors.bLonOk && variables.stuErrors.bCatOK;
	
	if(variables.stuErrors.bNoErrors){
		//Long Lat from form
		variables.stuArgs						=	structNew();
		variables.stuArgs.intCategoryID			=	form.sel_category;
		variables.stuArgs.fltLatitude			=	form.txtLatitude;
		variables.stuArgs.fltLongitude			=	form.txtLongitude;
		variables.stuArgs.intDistance			=	50; //Currently hardcoding the distance
		
		//we need these for the google maps location on the layout page.
		variables.fltLatitude					=	form.txtLatitude;
		variables.fltLongitude					=	form.txtLongitude;
		
		//Get category name
		variables.strCategory					=	application.oNearestBusiness.lookupCategory(intCategoryID	=	variables.stuArgs.intCategoryID);

		//Get nearest
		variables.qArtefacts					=	application.oNearestBusiness.findNearest(argumentCollection	=	variables.stuArgs);
		
		//Calculate bearings & heading (NESW)
		variables.stuArgs2						=	structNew();
		variables.stuArgs2.qArtefacts			=	variables.qArtefacts;
		variables.stuArgs2.fltCurrentLatitude	=	variables.stuArgs.fltLatitude;
		variables.stuArgs2.fltCurrentLongitude	=	variables.stuArgs.fltLongitude;
		variables.qArtefacts					=	application.oNearestBusiness.calcBearings(argumentCollection	=	variables.stuArgs2);
		
		//zoom level
		variables.intZoomLevel					=	12;
	}else{
		//there are errors
		variables.qArtefacts					=	queryNew('');
	}
</cfscript>