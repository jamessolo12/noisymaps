<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public">
	
	<fuseaction name="createTables">
		<include template="model/createTables_mysql" />
	</fuseaction>
	
	<fuseaction name="displayAll">
		<include template="model/actGetAll" />
		<include template="display/dspAll" contentvariable="strContent"/>
		<do action="shared.mapLayout" />
	</fuseaction>
	
	<fuseaction name="setup">
		<include template="model/actSetup" />
	</fuseaction>
	
	<fuseaction name="getXfas">
		<xfa name="home" value="home.welcome" />
		<xfa name="ineed" value="ineed.main" />
		<xfa name="ihave" value="ihave.main" />
		<xfa name="ineedresults" value="ineed.searchResults" />
		<xfa name="ihavesubmit" value="ihave.subitNew" />
		<xfa name="thanks" value="shared.thanks" />
		<xfa name="infoWindow" value="ajax.showInfoWindow" />
	</fuseaction>
</circuit>
