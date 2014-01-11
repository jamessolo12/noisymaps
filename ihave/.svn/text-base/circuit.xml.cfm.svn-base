<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public" xmlns:cf="cf/">

	<fuseaction name="main">
		<include template="model/act_iHave" />
		<include template="display/dsp_iHave" contentvariable="strContent"/>
		<set name="variables.intZoomLevel" value="3" />
		<do action="shared.mapLayout" />
	</fuseaction>

	<fuseaction name="subitNew">
		<include template="model/act_iHaveValidate" />
		<if condition="variables.stuValidate.bValid eq true">
			<true>
				<include template="model/act_InsertArtefact" />
				<relocate xfa="thanks" />
			</true>
			<false>
				<!-- validation error -->
				<do action="main" />
			</false>
		</if>
	</fuseaction>
</circuit>
