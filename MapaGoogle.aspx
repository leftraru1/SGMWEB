<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MapaGoogle.aspx.vb" Inherits="MapaGoogle" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<!DOCTYPE html>
<html DIR="LTR"> 
<head> 
<title>Ejemplo de la versión 3 del API de JavaScript de Google Maps: coordenadas de mapa</title>
<link href="/maps/documentation/javascript/examples/default.css" rel="stylesheet" type="text/css" />
<%--<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script> --%>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<AIzaSyCeNLcDwX9CKptCDQGZUnPD62P02zO4l14>&sensor=false" type="text/javascript"></script>


<script type="text/javascript">
var MERCATOR_RANGE = 256;
 
function bound(value, opt_min, opt_max) {
  if (opt_min != null) value = Math.max(value, opt_min);
  if (opt_max != null) value = Math.min(value, opt_max);
  return value;
}
 
function degreesToRadians(deg) {
  return deg * (Math.PI / 180);
}
 
function radiansToDegrees(rad) {
  return rad / (Math.PI / 180);
}
 
function MercatorProjection() {
  this.pixelOrigin_ = new google.maps.Point(
      MERCATOR_RANGE / 2, MERCATOR_RANGE / 2);
  this.pixelsPerLonDegree_ = MERCATOR_RANGE / 360;
  this.pixelsPerLonRadian_ = MERCATOR_RANGE / (2 * Math.PI);
};
 
MercatorProjection.prototype.fromLatLngToPoint = function(latLng, opt_point) {
  var me = this;

  var point = opt_point || new google.maps.Point(0, 0);

  var origin = me.pixelOrigin_;
  point.x = origin.x + latLng.lng() * me.pixelsPerLonDegree_;
  // NOTE(appleton): Truncating to 0.9999 effectively limits latitude to
  // 89.189.  This is about a third of a tile past the edge of the world tile.
  var siny = bound(Math.sin(degreesToRadians(latLng.lat())), -0.9999, 0.9999);
  point.y = origin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) * -me.pixelsPerLonRadian_;
  return point;
};
 
MercatorProjection.prototype.fromPointToLatLng = function(point) {
  var me = this;
  
  var origin = me.pixelOrigin_;
  var lng = (point.x - origin.x) / me.pixelsPerLonDegree_;
  var latRadians = (point.y - origin.y) / -me.pixelsPerLonRadian_;
  var lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) - Math.PI / 2);
  return new google.maps.LatLng(lat, lng);
};

  function initialize(x,y) {
    var map;
    var coordInfoWindow;
    var chicago = new google.maps.LatLng(x,y);
        var mapOptions = {
      zoom: 0,
      center: chicago,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions); 
    
    var latlngStr = "SANTIAGO, IL" +"<br />" + "LatLng: " + chicago.lat() + " , " + chicago.lng() + "<br />";
    var projection = new MercatorProjection();
    var worldCoordinate = projection.fromLatLngToPoint(chicago);
    var worldCoordStr = "World Coordinate: " + worldCoordinate.x + " , " + worldCoordinate.y;
    var pixelCoordinate = new google.maps.Point(worldCoordinate.x * Math.pow(2, map.getZoom()), worldCoordinate.y * Math.pow(2, map.getZoom()));
    var pixelCoordStr = "<br />Pixel Coordinate: " + Math.floor(pixelCoordinate.x) + " , " + Math.floor(pixelCoordinate.y);
    var tileCoordinate = new google.maps.Point(Math.floor(pixelCoordinate.x / MERCATOR_RANGE), Math.floor(pixelCoordinate.y / MERCATOR_RANGE));
    var tileCoordStr = "<br />Tile Coordinate: " + tileCoordinate.x + " , " + tileCoordinate.y + " at Zoom Level: " + map.getZoom();
    
    coordInfoWindow = new google.maps.InfoWindow({content: "SANTIAGO, CL"});
    coordInfoWindow.setContent(latlngStr + worldCoordStr + pixelCoordStr + tileCoordStr);
    coordInfoWindow.setPosition(chicago);
    coordInfoWindow.open(map);

    google.maps.event.addListener(map, 'zoom_changed', function() {
      pixelCoordinate = new google.maps.Point(worldCoordinate.x * Math.pow(2, map.getZoom()), worldCoordinate.y * Math.pow(2, map.getZoom()));
      pixelCoordStr = "<br />Pixel Coordinate: " + Math.floor(pixelCoordinate.x) + " , " + Math.floor(pixelCoordinate.y);
      tileCoordinate = new google.maps.Point(Math.floor(pixelCoordinate.x / MERCATOR_RANGE), Math.floor(pixelCoordinate.y / MERCATOR_RANGE));
      tileCoordStr = "<br />Tile Coordinate: " + tileCoordinate.x + " , " + tileCoordinate.y  + " at Zoom Level: " + map.getZoom();
    
      coordInfoWindow.setContent(latlngStr + worldCoordStr + pixelCoordStr +tileCoordStr);
      coordInfoWindow.open(map);
    });
  }
</script> 
</head> 
<body>
<%--<body onload="initialize()"> --%>
  <div id="map_canvas" style="width: 600px; height: 480px;"></div> 
</body> 
</html>
