import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkgrid_y/features/harita/repository/harita_repository.dart';
import 'package:parkgrid_y/models/harita_model.dart';

class HaritaController extends ChangeNotifier {
  final HaritaRepository _repository;
  
  HaritaController({HaritaRepository? repository})
      : _repository = repository ?? HaritaRepository();

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  // Initial camera position
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(40.19288452999717, 29.96974009654622), // Başlangıç koordinatları (örneğin San Francisco)
    zoom: 14.5,  // Başlangıç zoom seviyesi
  );

  // Getters
  GoogleMapController? get googleMapController => _googleMapController;
  Marker? get origin => _origin;
  Marker? get destination => _destination;
  Directions? get info => _info;

  // Initialize map controller
  void setMapController(GoogleMapController controller) {
    _googleMapController = controller;
    notifyListeners();
  }

  // Add markers
  Future<void> addMarker(LatLng position) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Set origin
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: position,
      );
      // Reset destination and info
      _destination = null;
      _info = null;
    } else {
      // Set destination
      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: position,
      );

      // Fetch directions using repository method
      _info = await getDirections(
        origin: _origin!.position,
        destination: position,
      );
    }
    notifyListeners();
  }

  // Wrapper method to get directions from the repository
  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    return await _repository.getDirections(
      origin: origin,
      destination: destination,
    );
  }

  // Reset the camera position
  void resetCamera() {
    if (_googleMapController != null) {
      _googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition),
      );
    }
  }

  // Animate camera to origin or destination
  void animateCameraToMarker(Marker? marker) {
    if (marker != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: marker.position,
            zoom: 14.5,
            tilt: 50.0,
          ),
        ),
      );
    }
  }

  // Center map to bounds
  void centerMapToBounds() {
    if (_info != null && _googleMapController != null) {
      _googleMapController!.animateCamera(
        CameraUpdate.newLatLngBounds(_info!.bounds, 100.0),
      );
    }
  }

  // Dispose controller
  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }
}
