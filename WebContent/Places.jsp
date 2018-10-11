<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Route</title>
    <style>
      #right-panel {
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

      #right-panel select, #right-panel input {
        font-size: 15px;
      }

      #right-panel select {
        width: 100%;
      }

      #right-panel i {
        font-size: 12px;
      }
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
        float: left;
        width: 70%;
        height: 100%;
      }
      #right-panel {
        margin: 20px;
        border-width: 2px;
        width: 20%;
        height: 400px;
        float: left;
        text-align: left;
        padding-top: 0;
      }
      #directions-panel {
        margin-top: 10px;
        background-color: #FFEE77;
        padding: 10px;
        overflow: scroll;
        height: 174px;
      }
    </style>
</head>



<body>
   <div id="map"></div>
    <div id="right-panel">
    <div>
    <b>Start/End:</b>
    <select id="start">
      <option value="Bucknell University, Moore Avenue, Lewisburg, PA, USA">Bucknell University</option>
      <option value="Walmart Supercenter, AJK Boulevard, Lewisburg, PA, USA">Walmart at AJK</option>
      <option value="Barnes & Noble at Bucknell University, Market Street, Lewisburg, PA, USA">Barnes and Noble</option>
      <option value="Campus Theatre, Market Street, Lewisburg, PA, USA">Campus Theatre</option>
    </select>
    <br>
    <b>Waypoints:</b> <br>
    <i>(Ctrl+Click or Cmd+Click for multiple selection)</i> <br>
    <select multiple id="waypoints">
      <option value="Bucknell University, Moore Avenue, Lewisburg, PA, USA">Bucknell University</option>
      <option value="Walmart Supercenter, AJK Boulevard, Lewisburg, PA, USA">Walmart at AJK</option>
      <option value="Barnes & Noble at Bucknell University, Market Street, Lewisburg, PA, USA">Barnes and Noble</option>
      <option value="Campus Theatre, Market Street, Lewisburg, PA, USA">Campus Theatre</option>
      <option value="Pizza Phi, Market Street, Lewisburg, PA"> Pizza Phi</option>
    </select>
    <br>
    
      <input type="submit" value = "Click Me FIRST" id="calc">
      
     <form method = POST action = Process1>
	<input id = "data" name="data" type="hidden" value="" />
	<input id = "stoplists" name="stoplists" type="hidden" value="" />
	 <input type="submit" id="submit">
	</form>
	</div>
	</div>
    
    
    
    <script>
    var waypts = [];
    document.getElementById("data").style.display="none";
    
      function initMap() {
        var directionsService = new google.maps.DirectionsService;
        //var directionsDisplay = new google.maps.DirectionsRenderer;
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 6,
          center: {lat: 41.85, lng: -87.65}
        });
        //directionsDisplay.setMap(map);

        document.getElementById('calc').addEventListener('click', function() {
          calculateAndDisplayRoute(directionsService);
        });
      }
      
      

      function calculateAndDisplayRoute(directionsService) {
    	  	var e = document.getElementById('start');
    	    var stops = [e.options[e.selectedIndex].value];
    	    
        var checkboxArray = document.getElementById('waypoints');
        for (var i = 0; i < checkboxArray.length; i++) {
          if (checkboxArray.options[i].selected) {
            waypts.push({
              location: checkboxArray[i].value,
              stopover: true
            });
            stops.push(checkboxArray[i].value);
          }
        }
        
        
        //////////////
        var service = new google.maps.DistanceMatrixService();
		service.getDistanceMatrix(
  		{
   			 origins: stops,
   			 destinations: stops,
    			 travelMode: 'WALKING',
    			 
  			}, callback);
		
		
		
		
		//store stops for later use
		
		stopString = "";
		for (i = 0; i < stops.length; i++){
			stopString = stopString + stops[i];
			stopString = stopString + "\n";
		}
		var e2 = document.getElementById("stoplists");
		e2.setAttribute("value", stopString);
		
		
		
		
		
		
		var outString = stops.length.toString();
		outString = outString  + " ";
		function callback(response, status) {
			if (status == 'OK') {
			    var origins = response.originAddresses;
			    var destinations = response.destinationAddresses;

			    for (var i = 0; i < origins.length; i++) {
			      var results = response.rows[i].elements;
			      for (var j = 0; j < results.length; j++) {
			        var element = results[j];
			        var distance = element.distance.value;
			        
			        var duration = element.duration.value;
			        outString = outString + distance.toString();
			        outString = outString + " ";
			        
			        
			        
			        var from = origins[i];
			        var to = destinations[j];
			      }
			      
			    }
			  }
			var el = document.getElementById("data");
			el.setAttribute("value", outString);
			
			
			
		}
      }
		
	
        
        
        
        
        
        /////////////
        
        

       
     
</script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALqtYqo05DV7hazAfshHGHF3fWzU_L4Rg&libraries=places&callback=initMap"
        async defer></script>

</body>
</html>