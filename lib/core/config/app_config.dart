import 'dart:convert';

import 'package:flutter/services.dart';

// AppConfig class for managing the application configuration
class AppConfig {
  final String apiUrl; // API URL for the application
  final String wsUrl; // Websocket URL
  // Constructor for the AppConfig class
  AppConfig({required this.apiUrl, required this.wsUrl});
  // Constants for different environment types
  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String staging = 'staging';
  // Method to get the configuration based on the environment type
  static String _getConfig({String? env}) {
    switch (env) {
      case AppConfig.dev:
        return AppConfig.dev;
      case AppConfig.prod:
        return AppConfig.prod;
      case AppConfig.staging:
        return AppConfig.staging;
      default:
        return 'dev'; // Default to dev environment if no match
    }
  }

  // Method to load the AppConfig for a specific environment
  static Future<AppConfig> forEnvironment({String? env}) async {
    // Load JSON file for the specified environment
    final contents = await rootBundle
        .loadString('assets/config/${_getConfig(env: env)}.json');
    // Decode the JSON contents
    final json = jsonDecode(contents);

    // Create an instance of AppConfig with the API URL from the JSON
    return AppConfig(apiUrl: json['apiUrl'], wsUrl: json['wsUrl']);
  }
}
