<cfparam name="qCategorys" type="query" default="#queryNew('')#" />
	<form action="<cfoutput>#myself##xfa.ineedresults#</cfoutput>" method="POST">
		<h1>I Need</h1>
		
		<p>
			Are you looking for something? Noisy Maps can help you find it!
		</p>
		
		<div id="geoLocateFail" class="alert alert-error" style="display: none;">
			<strong>GeoLocation Fail</strong> - Sorry, Gelocation timed out or you refused. Please manually enter your location.
		</div>
		
		<div class="indent">
			<h3>1) Where are you?</h3>
			<p>
				<button type="button" onclick="getGeoLocation();" class="btn btn-info">Find My Location</button>
				<table border="0" cellpadding="3" cellspacing="3">
					<tr>
						<td>Lat:</td> 
						<td><input type="text" name="txtLatitude" id="txtLatitude" /></td>
						<td rowspan="2">
							<!--- I am a loading image for the geolocation plugin, hidden with css --->
							<span id="loadingImg">
								<img src="http://s3-eu-west-1.amazonaws.com/noisyimages/loading.gif" height="32" width="32" />
							</span>
						</td>
					</tr>
					<tr>
						<td>Long:</td>
						<td><input type="text" name="txtLongitude" id="txtLongitude" /></td>
					</tr>
				</table>
			</p>
			
			<h3>2) What are you looking for?</h3>
			<p>
				<select name="sel_category" id="sel_category">
					<cfoutput query="qCategorys">
						<option value="#intCategoryId#">#strCategoryName#</option>
					</cfoutput>
				</select>
			</p>
			<input type="submit" name="submit" value="Find My Nearest" class="btn btn-primary" />
		</div><!-- /indent -->
	</form>

<script type="text/javascript">
	var bGeoHandled	= false;
	var intTimeout	= 6000;
	
	function handleNotNow(){
		//Manual timeout fired to check if we've done anything yet.
		if(bGeoHandled == false){
			handleError("");
		}
	}
	
	function handleError(error){
		bGeoHandled	=	true;
		$('#geoLocateFail').show();
		//Gelocation fail
		$('#txtLatitude').val('51.477222');//Greenwhich
		$('#txtLongitude').val('0.0'); 
		$('#loadingImg').hide();
	}
	
	function handleSuccess(position) {
		bGeoHandled	=	true;
		$('#txtLatitude').val(position.coords.latitude);
		$('#txtLongitude').val(position.coords.longitude);
		$('#loadingImg').hide();
	}
	
	function getGeoLocation(){
		$('#loadingImg').show();
		//FF can select option "not now" in which case we want to do something instead of wait forever.
		setTimeout("handleNotNow()",intTimeout + 1000);
		
		if (navigator.geolocation) {  
			//geolocation is available
			navigator.geolocation.getCurrentPosition(
				handleSuccess,
				handleError,
				{timeout:intTimeout});
		} else {
			//Gelocation not available
			$('#txtLatitude').val('51.477222'); //Greenwhich
			$('#txtLongitude').val('0.0');
		}
	}
</script>