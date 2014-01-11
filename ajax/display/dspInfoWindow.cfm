<cfparam name="variables.qArtefact"		type="query"	default="#queryNew('')#">
<cfset request.cancelFooter	= true>
<!--- If we have a name use it, if not use category name...ie Phone box. --->

<cfif len(variables.qArtefact.strName)>
	<cfset variables.strArtefactName	= variables.qArtefact.strName>	
<cfelse>
	<cfset variables.strArtefactName	= variables.qArtefact.strCategoryName>	
</cfif>	
<cfoutput>
	<div id="infoBoxContent">
		<h4>#variables.strArtefactName# - #variables.fltVotePercent#%</h4>
		<table border="0" id="tblSmiles" cellpadding="5" cellspacing="5" class="tblSmiles">
			<tr data-id="#url.intArtefactId#">
				<td id="smile" class="smileButton" data-val="true"><img src="http://s3-eu-west-1.amazonaws.com/noisyimages/icons/smile.png" id="imgSmile" /></td>
				<td id="frown" class="smileButton" data-val="false"><img src="http://s3-eu-west-1.amazonaws.com/noisyimages/icons/frown.png" id="imgFrown" /></td>
			</tr>
		</table>
		
		<div id="mainInfoBoxContent">
			Please vote if this exists using the buttons above.
		</div>
	</div>
</cfoutput>
