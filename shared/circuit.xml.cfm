<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public" xmlns:cf="cf/">

	<fuseaction name="mainLayout">
		<!-- I am the main site wide layout file -->
		<do action="footer" contentvariable="strFooter" />
		<include template="layout/lay_template" />
	</fuseaction>

	<fuseaction name="mapLayout">
		<!-- I am the main site wide layout file -->
		<do action="footer" contentvariable="strFooter" />
		<include template="layout/lay_map_template" />
	</fuseaction>
	
	<fuseaction name="thanks">
		<!-- I just display a boring thanks message -->
		<include template="display/dspThanks" contentvariable="strContent" />
		<do action="mainLayout" />
	</fuseaction>
	
	<!-- Internal -->
	<fuseaction name="footer">
		<include template="display/dsp_footer" />
	</fuseaction>
</circuit>
