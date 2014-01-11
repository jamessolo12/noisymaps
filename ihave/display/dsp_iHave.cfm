<cfparam name="qCategorys"							type="query"	default="#queryNew('')#" />
<cfparam name="variables.stuValidate"				type="struct"	default="#structNew()#" />
<cfparam name="variables.stuValidate.strErrorMsg"	type="string"	default="" />
<cfparam name="form.txtLongitude"					type="string"	default="" />
<cfparam name="form.txtLatitude"					type="string"	default="" />
<cfparam name="form.sel_category"					type="numeric"	default="1" />
<cfparam name="form.txtName"						type="string"	default="" />
<script type="text/javascript">
	function findCoOrds(){
		//get the center co-ordinates from google map and put it in our text boxes
		var fltLat	=	map.getCenter().lat();
		var fltLon	=	map.getCenter().lng();
		$("#txtLatitude").val(fltLat);
		$("#txtLongitude").val(fltLon);
	}
</script>
<div id="columnRight">
	<form id="frm_add" class="form-horizontal" action="<cfoutput>#myself##xfa.ihavesubmit#</cfoutput>" method="POST">
		<h1>I Have</h1>
		<div id="messages">
			<cfif len(variables.stuValidate.strErrorMsg)>
				<div id="invalidGuess" class="alert alert-error">
					<strong>Please fix the following errors:</strong><br />
					<ul>
						<cfoutput>#variables.stuValidate.strErrorMsg#</cfoutput>
					</ul>
				</div>
			</cfif>
		</div>
		<div id="Intro">
			The "I Have" page is where you add utilities that you know the location of. If you know
			where a post box, ATM, Bank is, then please add it to the map. The location of this utility
			will then be available for everyone to use and help them find things!
		</div>
		<table>
			<tr>
				<td>Longitude:</td>
				<td colspan="2">
					<input type="text" name="txtLongitude" id="txtLongitude" value="<cfoutput>#form.txtLongitude#</cfoutput>" />
				</td>
			</tr>
			<tr>
				<td>Latitude:</td>
				<td>
					<input type="text" name="txtLatitude" id="txtLatitude" value="<cfoutput>#form.txtLatitude#</cfoutput>" />
				</td>
				<td>
					<!--- Just a cheat button to fill in some gps co-ordinates --->
					<input type="button" class="btn btn-info" name="GetGPS" value="Get GPS From Map" onClick="findCoOrds()" />
				</td>
			</tr>
			<tr>
				<td>Category:</td>
				<td colspan="2">
					<select name="sel_category" id="sel_category">
						<cfoutput query="qCategorys">
							<cfif form.sel_category eq intCategoryId>
								<option value="#intCategoryId#" selected="selected">#strCategoryName#</option>
							<cfelse>
								<option value="#intCategoryId#">#strCategoryName#</option>
							</cfif>
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr>
				<td>Comments:</td>
				<td colspan="2">
					<input name="txtName" id="txtName" value="<cfoutput>#form.txtName#</cfoutput>" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="button" name="btn_add" value="Add" class="btn btn-primary" onclick="$('#frm_add').submit();" />
				</td>
			</tr>
		</table>
	</form>
</div>