
<!--- Use cfdbinfo to get the tables of the database --->
<cfdbinfo type="tables" datasource="#application.strDsn#" name="dbdata">


<!--- Check if USERS table exists --->
<cfquery name="tableExists" dbtype="query">SELECT * FROM dbdata WHERE TABLE_TYPE='TABLE'</cfquery>

<cfscript>
	// Save results into list values to check for existance
	lstTables=valueList(tableExists.TABLE_NAME);
</cfscript>



<!--- Drop Tables if exists --->
<cfif listFindNoCase(lstTables,'category')>
	<cfquery name="dropTables" datasource="#application.strDsn#">DROP TABLE category</cfquery>
</cfif>
<cfif listFindNoCase(lstTables,'artefact')>
	<cfquery name="dropTables" datasource="#application.strDsn#">DROP TABLE artefact</cfquery>
</cfif>

<!--- Create Tables --->
<cfquery name="createTables2" datasource="#application.strDsn#">
	CREATE TABLE category
	(
		intCategoryId INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
		strCategoryName VARCHAR(100)
	)
</cfquery>
<cfquery name="createTables2" datasource="#application.strDsn#">
	CREATE TABLE artefact
	(
		intArtefactId INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
		intCategoryID int not null,
		gpsLongitude float,
		gpsLatitude float,
		strName varchar(50)
	)
</cfquery>


<!---insert--->
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Post Office')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Phone Box')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Post Box')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Cash Point')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Hospital')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Tube Station')
</cfquery>

<cfquery name="insertArtifact" datasource="#application.strDsn#">
	INSERT INTO artefact (intCategoryID,gpsLongitude,gpsLatitude,strName) VALUES (6,-0.105443000793,51.5205735874,'Farrington')
</cfquery>
<cfquery name="insertArtifact" datasource="#application.strDsn#">
	INSERT INTO artefact (intCategoryID,gpsLongitude,gpsLatitude,strName) VALUES (6,-0.124089717865,51.5303993667,'Kings Cross')
</cfquery>


<!--- Get categories and artefacts --->
<cfquery name="getCategory1" datasource="#application.strDsn#">SELECT * FROM category</cfquery>
<cfquery name="getArtefact1" datasource="#application.strDsn#">SELECT * FROM artefact</cfquery>



<!--- Dump the queries --->
<cfdump var="#getCategory1#">
<cfdump var="#getArtefact1#">



<!--- Use cfdbinfo to get the stored procedures --->
<cfdbinfo type="procedures" datasource="#application.strDsn#" name="qDbProcs">


<!--- Save results into list values to check for existance --->
<cfset lstProcs = valueList(qDbProcs.procedure_name) />

<!--- Drop Tables if exists --->
<cfif listFindNoCase(lstProcs,'getNearbyArtefacts')>
	<cfquery name="dropProc" datasource="#application.strDsn#">DROP PROCEDURE getNearbyArtefacts</cfquery>
</cfif>

<!--- 
CREATE PROCEDURE SALES.TOTAL_REVENUE(IN S_MONTH INTEGER,
IN S_YEAR INTEGER, OUT TOTAL DECIMAL(10,2))
PARAMETER STYLE JAVA READS SQL DATA LANGUAGE JAVA EXTERNAL NAME 
'com.acme.sales.calculateRevenueByMonth'

 --->

<cfquery name="qCreateProc" datasource="#application.strDsn#">
	
	
CREATE PROCEDURE getNearbyArtefacts(
	IN fltRadius		FLOAT,
	IN fltLatitude		FLOAT,
	IN fltLongitude 	FLOAT,
	IN intSearchDegree	INT,
	IN fltDistance		FLOAT,
	IN intMyCategoryID	INT
)
PARAMETER STYLE READS SQL DATA LANGUAGE JAVA EXTERNAL NAME 
'com.acme.sales.calculateRevenueByMonth'
	
	CREATE PROCEDURE getNearbyArtefacts(
		IN fltRadius		FLOAT,
		IN fltLatitude		FLOAT,
		IN fltLongitude 	FLOAT,
		IN intSearchDegree	INT,
		IN fltDistance		FLOAT,
		IN intMyCategoryID	INT
	)
	BEGIN

		Select fltRadius * Degrees(
			acos(
				sin(radians(fltLatitude)) * sin(radians(gpsLatitude))
				+
				cos(radians(fltLatitude)) * cos(radians(gpsLatitude)) * cos(radians(gpsLongitude)-radians(fltLongitude))
			)
		) As fltDistance,
		intArtefactId, strName, gpsLongitude, gpsLatitude, intCategoryID
		From artefact
		Where
		intCategoryID = intMyCategoryID
		AND 
		(
			gpsLatitude between
			fltLatitude - intSearchDegree
			and
			fltLatitude + intSearchDegree
		)
		And
		(
			gpsLongitude between
			fltLongitude - intSearchDegree
			and
			fltLongitude + intSearchDegree
		)
		And
		(
			fltRadius * Degrees(
				acos(
					sin(radians(fltLatitude))* sin(radians(gpsLatitude))
					+
					cos(radians(fltLatitude)) * cos(radians(gpsLatitude)) * cos(radians(gpsLongitude)-radians(fltLongitude))
				)
			)
		) < fltDistance
		Order By fltDistance, intArtefactId;

	END;
</cfquery>

<cfdbinfo type="procedures" datasource="#application.strDsn#" name="qDbProcs">


<cfdump var="#qDbProcs#">