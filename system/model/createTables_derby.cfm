
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
<cfif listFindNoCase(lstTables,'votes')>
	<cfquery name="dropTables" datasource="#application.strDsn#">DROP TABLE votes</cfquery>
</cfif>

<!--- Create Tables --->
<!--- strJsIconName corresponds to the icon hard coded in noisyMaps_markers.js file. --->
<cfquery name="createTables2" datasource="#application.strDsn#">
	CREATE TABLE category
	(
		intCategoryId INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
		strCategoryName VARCHAR(100),
		strJsIconName VARCHAR(20)
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
<!--- Apache derby doesn't support boolean :( --->
<cfquery name="createTables2" datasource="#application.strDsn#">
	CREATE TABLE votes
	(
		intVoteId INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
		intArtefactId INT NOT NULL,
		bPositive SMALLINT
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
	INSERT INTO category (strCategoryName, strJsIconName) VALUES ('Cash Point', 'imgAtm')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName) VALUES ('Hospital')
</cfquery>
<cfquery name="insertCategories" datasource="#application.strDsn#">
	INSERT INTO category (strCategoryName, strJsIconName) VALUES ('Tube Station', 'imgTube')
</cfquery>

<cfquery name="insertArtifact" datasource="#application.strDsn#">
	INSERT INTO artefact (intCategoryID,gpsLongitude,gpsLatitude,strName) VALUES (6,-0.105443000793,51.5205735874,'Farrington')
</cfquery>
<cfquery name="insertArtifact" datasource="#application.strDsn#">
	INSERT INTO artefact (intCategoryID,gpsLongitude,gpsLatitude,strName) VALUES (6,-0.124089717865,51.5303993667,'Kings Cross')
</cfquery>

<cfquery name="insertVote" datasource="#application.strDsn#">
	INSERT INTO votes (intArtefactId,bPositive) VALUES (1,1)
</cfquery>
<cfquery name="insertVote" datasource="#application.strDsn#">
	INSERT INTO votes (intArtefactId,bPositive) VALUES (1,1)
</cfquery>

<cfquery name="insertVote" datasource="#application.strDsn#">
	INSERT INTO votes (intArtefactId,bPositive) VALUES (2,1)
</cfquery>
<cfquery name="insertVote" datasource="#application.strDsn#">
	INSERT INTO votes (intArtefactId,bPositive) VALUES (2,0)
</cfquery>


<!--- Get categories and artefacts --->
<cfquery name="getCategory1" datasource="#application.strDsn#">SELECT * FROM category</cfquery>
<cfquery name="getArtefact1" datasource="#application.strDsn#">SELECT * FROM artefact</cfquery>
<cfquery name="getVotes1" datasource="#application.strDsn#">SELECT * FROM votes</cfquery>



<!--- Dump the queries --->
<cfdump var="#getCategory1#" label="categorys">
<cfdump var="#getArtefact1#" label="aretefacts">
<cfdump var="#getVotes1#" label="votes">


<!--- Derby doesn't support stored procs (to my knowledge) --->

