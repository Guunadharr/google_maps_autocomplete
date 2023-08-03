import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Column(
        children: [
          SearchMapPlaceWidget(
              bgColor: Colors.white,
              textColor: Colors.black,
              hasClearButton: true,
              placeType: PlaceType.address,
              placeholder: 'Enter the location',
              apiKey: 'AIzaSyDKzSv7kFtDONzdSL3xH0sqMvMx2IkBmgA',
              onSelected: (Place place) async {
                Geolocation? geolocation = await place.geolocation;
                mapController!.animateCamera(
                    CameraUpdate.newLatLng(geolocation!.coordinates));
                mapController!.animateCamera(
                    CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
              }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 620,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController googleMapController) {
                    setState(() {
                      mapController = googleMapController;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(17.968901, 79.594055),
                    zoom: 15.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
