<cfparam name="variables.strCategory" type="string" default="" />
<cfparam name="variables.qArtefacts" type="query" default="#queryNew('')#" />
<cfif (NOT variables.qArtefacts.recordcount) AND len(variables.strCategory)>
	<p>Unfortunately we have not been able to find any <cfoutput>#variables.strCategory#</cfoutput>'s near you.</p>
<cfelseif NOT variables.qArtefacts.recordcount>
	<p>Unfortunately we can't help you much.</p>
<cfelse>
	<cfoutput>
		<p>
			We have found <strong>#variables.qArtefacts.recordcount#</strong> 
			<cfif variables.qArtefacts.recordcount EQ 1>
				#variables.strCategory#
			<cfelse>
				#variables.strCategory#'s
			</cfif>
			near you:
		</p>
	</cfoutput>
	
	<table border="0" cellpadding="5">
		<tr>
			<td><strong>Distance (miles)</strong></td>
			<td><strong>Name</strong></td>
			<td><strong>Heading</strong></td>
		</tr>
	<cfoutput query="variables.qArtefacts">
		<tr>
			<td>#numberFormat(variables.qArtefacts.fltDistance,"999.99")#</td>
			<cfif len(variables.qArtefacts.strName)>
				<td>#variables.qArtefacts.strName#</td>
			</cfif>
			<td>#variables.qArtefacts.strHeading#</td>
		</tr>
	</cfoutput>
	</table>
</cfif>
