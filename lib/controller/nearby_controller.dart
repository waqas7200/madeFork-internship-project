import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/nerabyresturentModel/nearbyresturntModl.dart';


class NearbyController extends GetxController {
  var nearbyRestaurants = <RestaurantModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyRestaurants();
  }

  Future<void> fetchNearbyRestaurants() async {
    try {
      if (nearbyRestaurants.isEmpty) {
        isLoading.value = true;
      }
      errorMessage.value = '';

      // 1. Get User Location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // 2. Fetch Restaurants from Supabase
      final response = await Supabase.instance.client.from('restaurants').select();
      
      List<RestaurantModel> tempRestaurants = [];

      for (var rest in response) {
        dynamic locField = rest['location']; 
        double? rLat;
        double? rLng;

        // Parse location whether it's a JSON Map or a String
        if (locField != null) {
          try {
            if (locField is Map) {
              // PostGIS, JSON map, or profile coordinates format
              if (locField['latitude'] != null && locField['longitude'] != null) {
                rLat = (locField['latitude'] as num).toDouble();
                rLng = (locField['longitude'] as num).toDouble();
              } else if (locField['coordinates'] != null) {
                rLng = (locField['coordinates'][0] as num).toDouble();
                rLat = (locField['coordinates'][1] as num).toDouble();
              } else if (locField['lat'] != null && locField['lng'] != null) {
                rLat = (locField['lat'] as num).toDouble();
                rLng = (locField['lng'] as num).toDouble();
              }
            } else if (locField is String && locField.contains(',')) {
              // Comma-separated string format
              var parts = locField.split(',');
              rLat = double.tryParse(parts[0].trim());
              rLng = double.tryParse(parts[1].trim());
            }

            if (rLat != null && rLng != null) {
              // Calculate distance in meters
              double distanceInMeters = Geolocator.distanceBetween(
                  position.latitude, position.longitude, rLat, rLng);

              tempRestaurants.add(RestaurantModel.fromJson(rest, distanceInMeters));
            }
          } catch (e) {
            print("Error parsing location for restaurant: $e");
          }
        }
      }

      // Sort by closest distance
      tempRestaurants.sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));

      // Compare lists to avoid unnecessary UI redraws
      bool hasChanged = false;
      if (tempRestaurants.length != nearbyRestaurants.length) {
        hasChanged = true;
      } else {
        for (int i = 0; i < tempRestaurants.length; i++) {
          if (tempRestaurants[i] != nearbyRestaurants[i]) {
            hasChanged = true;
            break;
          }
        }
      }

      if (hasChanged) {
        nearbyRestaurants.value = tempRestaurants;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
