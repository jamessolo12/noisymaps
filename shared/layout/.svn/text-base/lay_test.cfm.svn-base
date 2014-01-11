<cfparam name="strContent"					type="string"	default="" />
<cfparam name="strFooter"					type="string"	default="" />
<cfparam name="variables.fltLatitude"		type="numeric"	default="0" />
<cfparam name="variables.fltLongitude"		type="numeric"	default="0" />
<cfparam name="variables.intZoomLevel"		type="numeric"	default="2" />
<cfparam name="variables.bShowCenterPoint"	type="boolean"	default="false" />
<cfset request.cancelFooter			=	true>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>A personal map and navigation utility for locating and tracking useful utilities. Nearby ATM, Nearest Post Office, this map tool can help.</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="Noisy Maps is a utility for locating and tracking the nearest ATM, Cash Point, post office, telephone to your current location.">
		<meta name="author" content="Noisy Cloud">
		
		<!--- 1) Set the main NC variables up, 2) Instantiate the NC functions in noisyMaps_markers.js 3) Call the NC variables. Must be in this order.  --->
		<script type="text/javascript">
			function NC(){};
			var map			= "";
			var arrMarkers	= [];
			
			<cfif variables.qArtefacts.recordcount>
				<cfset intCount	=	0>
				arrMarkers = [
					<cfoutput query="variables.qArtefacts">
						<cfset intCount	=	intCount + 1>
						<!--- If we have a name use it, if not use category name...ie Phone box. --->
						<cfif len(variables.qArtefacts.strName)>
							<cfset variables.strGooglePinName	= variables.qArtefacts.strName>	
						<cfelse>
							<cfset variables.strGooglePinName	= variables.qArtefacts.strCategoryName>	
						</cfif>	
						{ lat: #variables.qArtefacts.gpsLatitude#, lng: #variables.qArtefacts.gpsLongitude#, name: "#variables.strGooglePinName#", artId: #variables.qArtefacts.intArtefactId# }
						<cfif variables.qArtefacts.recordcount NEQ intCount>,</cfif>
					</cfoutput>
				];
			</cfif>
		</script>
		
		<cfoutput>
			<script type="text/javascript" src="#application.stuHeaders.strJquery#"></script>
			<script type="text/javascript" src="/js/noisyMaps_markers.js"></script>
		
			<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
		
			<link href="#application.stuHeaders.strBootstrap#" rel="stylesheet">
			<link href="#application.stuHeaders.strMapCss#" rel="stylesheet" />
		</cfoutput>

		<cfoutput>
			<script type="text/javascript">
				var infowindow	= new google.maps.InfoWindow();
				
				NC.noisymapsMarkers({
					fltLatitude			: #variables.fltLatitude#,
					fltLongitude		: #variables.fltLongitude#,
					intZoomLevel		: #variables.intZoomLevel#
				});
				
				$(document).ready(function() {
					map = NC.createMap();
					
					NC.addYouAreHereMarket(map);
					
					// Create the markers ad infowindows.
					for (index in arrMarkers){
						NC.addArtefact(arrMarkers[index], map, "#myself#ajax.showInfoWindow");
					}
				});
	
				//watch dom for the smile or frown id's, when they appear attach click events to count that smile/frown						
				$('.smileButton').live("click", function() {
					NC.smileButtonClick(this,"#myself#ajax.countSmile");
				});
	
			</script>
		</cfoutput>
	</head>

	<body>
		<div class="container">
			<div class="hero-unit">
				<h1>Noisy Maps</h1>
			</div>
		
			<div class="row">
				<div class="span12">
					<cfoutput>#strContent#</cfoutput>
				</div><!-- /span12 -->
			</div><!-- /row -->
			
			<div class="row">
				<div class="span12">
					<cfif variables.bShowCenterPoint><div id="centerpoint">&nbsp;</div></cfif>
					<div id="map_canvas"></div>
				</div><!-- /span12 -->
			</div><!-- /row -->
			
			<div class="row">
				<div class="span12">
					<footer>
						<cfoutput>#strFooter#</cfoutput>
					</footer><!-- /footer -->
				</div><!-- /span12 -->
			</div><!-- /row -->
		</div><!-- /container -->

	</body>
</html>
