import 'package:csc_picker/model/select_status_model.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;

  LatLng? _selectedLocation;

  Future<LatLng?> _getLatLngFromLocation(String? locationName) async {
    try {
      List<Location> locations = await locationFromAddress(locationName!);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return LatLng(location.latitude, location.longitude);
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
    return null;
  }

  void _onCountryChanged(String? countryValue) async {
    if (countryValue != null) {
      _selectedLocation = await _getLatLngFromLocation(countryValue);
      _moveToLocation();
    }
  }

  void _onStateChanged(String? stateValue) async {
    if (stateValue != null) {
      _selectedLocation = await _getLatLngFromLocation(stateValue);
      _moveToLocation();
    }
  }

  void _onCityChanged(String? cityValue) async {
    if (cityValue != null) {
      _selectedLocation = await _getLatLngFromLocation(cityValue);
      _moveToLocation();
    }
  }

  void _moveToLocation() {
    if (_mapController != null && _selectedLocation != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country picker'),
      ),
      body: Column(
        children: [
          CSCPicker(
            onCountryChanged: _onCountryChanged,
            onStateChanged: _onStateChanged,
            onCityChanged: _onCityChanged,
            showStates: true,
            showCities: true,
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(17.968901, 79.594055),
                zoom: 12,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
