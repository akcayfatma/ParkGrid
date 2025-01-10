import 'package:dio/dio.dart';
import 'package:parkgrid_y/features/harita/controller/.env.dart';
import 'package:parkgrid_y/models/harita_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HaritaRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  HaritaRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );

      // Check if response is successful
      if (response.statusCode == 200) {
        // Check if routes are available in the response
        if (response.data['routes'] != null && (response.data['routes'] as List).isNotEmpty) {
          return Directions.fromMap(response.data);
        } else {
          throw Exception('No routes found');
        }
      } else {
        throw Exception('Failed to fetch directions: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching directions: $e");
      return null;  // Return null or handle the error based on your need
    }
  }
}
