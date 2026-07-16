import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service to monitor network connectivity status throughout the application.
class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  final Connectivity _connectivity = Connectivity();

  /// Stream of connectivity change lists (for connectivity_plus v6.x and v7.x)
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  /// Check if the device has an active internet connection (WiFi, Mobile data, Ethernet, or VPN)
  Future<bool> hasConnection() async {
    final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
    return hasActiveConnection(results);
  }

  /// Helper to check if any of the active connections provide internet
  bool hasActiveConnection(List<ConnectivityResult> results) {
    if (results.isEmpty) return false;
    return results.any((result) =>
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn);
  }
}
