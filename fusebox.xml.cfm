<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox>
<fusebox xmlns:test="test">
	<circuits>
		<!-- illustrates defaults for parent ("") and relative ("true") -->
		<circuit alias="home"	path="home" />
		<circuit alias="shared" path="shared" />
		<circuit alias="system" path="system" />
		<circuit alias="ihave"	path="ihave" />
		<circuit alias="ineed"	path="ineed" />
		<circuit alias="ajax"	path="ajax" />
	</circuits>

	<parameters>
		<parameter name="defaultFuseaction" value="home.welcome" />
		<!-- you may want to change this to development-full-load mode: -->
		<parameter name="mode" value="development-circuit-load" />
		<parameter name="conditionalParse" value="false" />
		<!-- change this to something more secure: -->
		<parameter name="password" value="skeleton" />
		<parameter name="strictMode" value="true" />
		<parameter name="debug" value="false" />
		
		<parameter name="fuseactionVariable" value="fuseaction" />
		<parameter name="scriptFileDelimiter" value="cfm" />
		
		<!-- we use the core file error templates 
		<parameter name="errortemplatesPath" value="/fusebox5/errortemplates/" />-->
		<!--
			These are all default values that can be overridden:
		<parameter name="precedenceFormOrUrl" value="form" />
		<parameter name="maskedFileDelimiters" value="htm,cfm,cfml" />
		<parameter name="characterEncoding" value="utf-8" />
		<parameter name="strictMode" value="false" />
		<parameter name="allowImplicitCircuits" value="false" />
		-->
	</parameters>

	<globalfuseactions>
		<preprocess>
			<fuseaction action="system.getXfas"/>
		</preprocess>
	<!--
		<postprocess>
			<fuseaction action="time.postprocess"/>
		</postprocess>
	-->
	</globalfuseactions>

	<plugins>
		<!--
		<phase name="preProcess">
		</phase>
		<phase name="preFuseaction">
		</phase>
		<phase name="postFuseaction">
		</phase>
		<phase name="fuseactionException">
		</phase>
		<phase name="postProcess">
		</phase>
		<phase name="processError">
		</phase>
		-->
	</plugins>

</fusebox>
