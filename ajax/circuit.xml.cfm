<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public" xmlns:cf="cf/">

	<fuseaction name="showInfoWindow">
		<set name="url.intArtefactId"	value="0" overwrite="false" />
		<include template="model/actInfoWindow.cfm" />
		<include template="display/dspInfoWindow.cfm" />
	</fuseaction>

	<fuseaction name="countSmile">
		<include template="model/actCountSmile.cfm" />
	</fuseaction>

</circuit>
