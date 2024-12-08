import "package:coffee_meet_app/entities/global_state.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  List<Marker> markers = [
    Marker(
        markerId: MarkerId("gps_ghost"),
        infoWindow: InfoWindow(title: "Gps Ghost"),
        position: LatLng(37.422, -122.084),
    ),
    Marker(
        markerId: MarkerId("water"),
        infoWindow: InfoWindow(title: "Some Water"),
        position: LatLng(37.475, -122.084)
    ),
    Marker(
      markerId: MarkerId("mountain"),
      infoWindow: InfoWindow(title: "Some Mountain"),
      position: LatLng(37.302, -122.184),
    )
  ];

  Future<void> _locate() async{

    bool locationServicesEnabled = await Geolocator.isLocationServiceEnabled();
    if(!locationServicesEnabled){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location Services Disabled"))
      );
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
    }
    if(permission != LocationPermission.denied&& permission!=LocationPermission.deniedForever){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Wait"))
      );

      Position p = await Geolocator.getCurrentPosition();
      setState(() {
        GlobalState().setLocation(LatLng(p.latitude,p.longitude));
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${GlobalState().getLocation()}"))
      );

      mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: GlobalState().getLocation(),zoom: 11)
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permissions Denied"))
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton(
          onPressed: _locate,
          child: Center(child: Text("Locate")),
      ),
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              CameraPosition(target: GlobalState().getLocation() ?? LatLng(0,0), zoom: 11.0),
          markers: Set<Marker>.of(markers) ,
        ),
      ),
    );
  }
}
