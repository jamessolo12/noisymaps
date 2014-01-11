<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public" xmlns:cf="cf/">
	
	<fuseaction name="welcome">
		<include template="display/dsp_welcome" contentvariable="strContent"/>
	</fuseaction>
	

<!-- Test Fuses -->	
	
	<fuseaction name="test">
		<include template="display/dsp_test" contentvariable="strContent"/>
	</fuseaction>
	
	<fuseaction name="testMaps">
		<include template="model/act_testMap" />
		<include template="../ineed/display/dsp_results" contentvariable="strContent"/>
	</fuseaction>
		
	<postfuseaction>
		<do action="shared.mainLayout" />
	</postfuseaction>
</circuit>
