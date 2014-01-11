NC.noisymapsMarkers	= function(params) {
	
	// Create our "tiny" marker icon
	this.imgTube			= "http://s3-eu-west-1.amazonaws.com/noisyimages/icons/underground.png";
	this.imgAtm				= "http://s3-eu-west-1.amazonaws.com/noisyimages/icons/bank.png";
	this.imgSmileDone		= "http://s3-eu-west-1.amazonaws.com/noisyimages/icons/smile_done.png";
	this.imgFrownDone		= "http://s3-eu-west-1.amazonaws.com/noisyimages/icons/frown_done.png";
	
	this.strMapDivID		= "#map_canvas";
	this.strSmilesClass		= ".smileButton";
	this.strSmileImgID		= "#imgSmile";
	this.strFrownImgID		= "#imgFrown";
	this.strContentBox		= "#mainInfoBoxContent";
	
	this.fltLatitude		= 0.0;
	this.fltLongitude		= 0.0;
	this.intZoomLevel		= 2;
	
	$.extend(this, params);

	this.latlngIamHere		= new google.maps.LatLng(this.fltLatitude,this.fltLongitude);
};


NC.createMap	= function(){
	var myOptions = {
		zoom: this.intZoomLevel,
		center: this.latlngIamHere,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		streetViewControl: false
	};
	return new google.maps.Map($(this.strMapDivID)[0],myOptions);
}


NC.addYouAreHereMarket	= function(map){
	//show you are here marker
	if(this.fltLatitude != 0 && this.fltLongitude != 0){
		var marker = new google.maps.Marker({
			position: this.latlngIamHere,
			title: "You are Here"
		});
		marker.setMap(map);
	}
}


NC.addArtefact	= function(data, map, strInfoWindowAjaxUrl){
	// Create the marker
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(data.lat, data.lng),
		map: map,
		title: data.name,
		icon: this[data.mapIcon]
	});


	// Open the infowindow on marker click
	google.maps.event.addListener(marker, "click", function() {
		
		infowindow.close();
			
		//onClick do the ajax call and open the marker
		$.ajax({
			url: strInfoWindowAjaxUrl,
			data: { strArtefactName: data.name, intArtefactId: data.artId },
			cache: false
		}).done(function( html ) {
			infowindow.setContent(html);
		});
		
		//show window
		infowindow.open(map, marker);
	});
}


NC.smileButtonClick	= function(objTdBtn, strVoteAjaxUrl){
	that = this;
	
	//Grey them out after click
	$(that.strSmilesClass).removeClass();
	$(that.strSmilesClass).addClass('smileButton_done');
	$(that.strSmileImgID).attr("src",this.imgSmileDone)
	$(that.strFrownImgID).attr("src",this.imgFrownDone)
	
	//count the click
	$.ajax({
		url: strVoteAjaxUrl,
		data: {intArtefactId: $(objTdBtn).parent().attr("data-id"), bIsSmile: $(objTdBtn).attr("data-val")},
		success: function(data) {
			$(that.strContentBox).html('Thank you');
		},
		error: function(xhr, text, err){
			$(that.strContentBox).html(text);
		},
		cache: false
	});
}

