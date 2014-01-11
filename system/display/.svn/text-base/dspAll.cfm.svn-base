<cfparam name="variables.qArtefacts" type="query" default="#queryNew('')#" />
<div id="columnRight">
	<table class="table table-striped">
		<tr>
			<th><strong>ID</strong></th>
			<th><strong>Name</strong></th>
			<th><strong>Category</strong></th>
		</tr>
		<cfoutput query="variables.qArtefacts">
			<tr>
				<td>#variables.qArtefacts.intArtefactID#</td>
				<td>#variables.qArtefacts.strName#</td>
				<td>#variables.qArtefacts.strCategoryName#</td>
			</tr>
		</cfoutput>
	</table>
</div>