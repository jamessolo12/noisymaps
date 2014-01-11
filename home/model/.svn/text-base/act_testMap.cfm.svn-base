<cfparam name="form.sel_category" type="numeric" default="0" />

<cfscript>
	//<!--- Long Lat of Holborn --->
	variables.fltLatitude	= 51.51742248092708;
	variables.fltLongitude	= -0.12003421783447266;
	variables.intZoomLevel	= 12;

	variables.qArtefacts	=	queryNew('fltDistance,intArtefactId,intCategoryID,strName,gpsLongitude,gpsLatitude');
	queryAddRow(variables.qArtefacts);
	querySetCell(variables.qArtefacts,"fltDistance",3);
	querySetCell(variables.qArtefacts,"intArtefactId",3);
	querySetCell(variables.qArtefacts,"intCategoryID",3);
	querySetCell(variables.qArtefacts,"strName","Tube 1");
	querySetCell(variables.qArtefacts,"gpsLongitude",-0.105443000793);
	querySetCell(variables.qArtefacts,"gpsLatitude",51.5205735874);
	queryAddRow(variables.qArtefacts);
	querySetCell(variables.qArtefacts,"fltDistance",5);
	querySetCell(variables.qArtefacts,"intArtefactId",4);
	querySetCell(variables.qArtefacts,"intCategoryID",3);
	querySetCell(variables.qArtefacts,"strName","Tube 2");
	querySetCell(variables.qArtefacts,"gpsLongitude",-0.107443000793);
	querySetCell(variables.qArtefacts,"gpsLatitude",51.5105735874);
	
	
	//<!--- Calculate bearings & heading (NESW) --->
	variables.stuArgs2						=	structNew();
	variables.stuArgs2.qArtefacts			=	variables.qArtefacts;
	variables.stuArgs2.fltCurrentLatitude	=	variables.fltLatitude;
	variables.stuArgs2.fltCurrentLongitude	=	variables.fltLongitude;
	variables.qArtefacts					=	application.oNearestBusiness.calcBearings(argumentCollection	=	variables.stuArgs2);
</cfscript>