<cfparam name="strContent"	type="string" default="" />
<cfparam name="strFooter"	type="string" default="" />
<cfset request.cancelFooter			=	true>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Noisy Maps - A personal navigation utility for locating and tracking useful utilities.</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="Noisy Maps is a utility for locating and tracking the nearest ATM, Cash Point, post office, telephone to your current location.">
		<meta name="author" content="http://www.noisycloud.co.uk">
		<meta name="msvalidate.01" content="51F60D2F435D6DD48CECFD18F8F3DCA7" /><!--- Bing Verify --->
		
		<cfoutput><script type="text/javascript" src="#application.stuHeaders.strJquery#"></script></cfoutput>
		
		<script type="text/javascript">
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-33835913-1']);
			_gaq.push(['_trackPageview']);
			
			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
		</script>
		
		<cfoutput>
			<link href="#application.stuHeaders.strBootstrap#" rel="stylesheet">
			<link href="#application.stuHeaders.strNormalCss#" rel="stylesheet" />
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
					<footer>
						<cfoutput>#strFooter#</cfoutput>
					</footer><!-- /footer -->
				</div><!-- /span12 -->
			</div><!-- /row -->
		</div><!-- /container -->
	</body>
</html>