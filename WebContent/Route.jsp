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
        height: 600px;
      }
    </style>
</head>



<body>
   <div id="map"></div>
    <div id="right-panel">
    <div>
    <input id = "data" name="data" type="hidden" value="${requestScope['data']}" />
	<input id = "stoplists" name="stoplists" type="hidden" value="${requestScope['stoplists']}" />
    <div id="directions-panel"></div>
    </div>
    </div>
    
    
    <script>
   
    var wayptsTemp = document.getElementById("stoplists").value.split("\n");
    wayptsTemp.pop();
    
    
    
    var order = document.getElementById("data").value.split(" ");
    order.pop();
  
    ////need to change b/c algorithm is not working/////
    
    var waypts = [];
    var i;
    for (i = 0; i < order.length; i++){
    		waypts.push({
    			location: wayptsTemp[parseInt(order[i])],
    			stopover: true
    		});
    }
    /////////////////////////////////////////

    
      function initMap() {
        var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 6,
          center: {lat: 41.85, lng: -87.65}
        });
        directionsDisplay.setMap(map);

        
          //calculateAndDisplayRoute(directionsService, directionsDisplay);
       
     
     
        directionsService.route({
          origin: wayptsTemp[0],
          destination: wayptsTemp[0],
          waypoints: waypts,
          //optimizeWaypoints: true,
          travelMode: 'WALKING'
        }, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
            var route = response.routes[0];
            var summaryPanel = document.getElementById('directions-panel');
            summaryPanel.innerHTML = '';
            // For each route, display summary information.
            for (var i = 0; i < route.legs.length; i++) {
              var routeSegment = i + 1;
              summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment +
                  '</b><br>';
              summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
              summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
              summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
            }
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      }
</script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALqtYqo05DV7hazAfshHGHF3fWzU_L4Rg&libraries=places&callback=initMap"
        async defer></script>

</body>
</html>