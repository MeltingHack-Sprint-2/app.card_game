
import 'package:card_game/core/apis/api_request_extension.dart';
import 'package:card_game/core/config/app_instance.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// Artisan client class for handling API request
class UnoClient {
  final _logger = Logger(); // For logging instance messages
  // Static method to get the base url path from the app instance configuration
  static get baseURLPath => AppInstance().config()!.apiUrl;
  final http.Client httpClient =
      http.Client(); // Http client for making request

  // Method for a regular API request
  Future<http.Response> executeRequest({required Request request}) async {
    // Creating base headers for the request
    final headers = await _createBaseHeaders();
    try {
      // Logging request execution details
      _logger.d(
          'Executing request: ${request.apiPath} with params ${request.params}');
      // Making the request and getting the response
      final response =
          await request.request(baseURLPath: baseURLPath, headers: headers);
      // Logging the response details
      _logger.d('Response: ${response.body}');
      return response; // Returning the response
    } catch (e) {
      // Logging any error that occurs during the request execution
      _logger.e(e.toString());
      rethrow; // Rethrowing the error
    }
  }

  // Method to execute a streamed API request for uploading files
  Future<http.Response> executeStreamedRequest(
      {required String path,
      required RequestType type,
      required http.MultipartFile file,
      required Map<String, dynamic>? data}) async {
    _logger.d('Streamed request called');
    final headers = await _createBaseHeaders(); // Creating base headers
    try {
      //Creating a multipart request for uploading files
      var request = http.MultipartRequest(
        type.value(),
        Uri.parse('$baseURLPath$path'),
      );
      request.headers.addAll(headers); // Adding headers to the request
      request.files.add(file); // Adding files to the request

      // Adding any additional data to the request
      data?.keys.forEach((key) {
        request.fields[key] = data[key].toString();
      });

      _logger.d('Request URL is ${request.url}'); // Logging the request URL
      final response =
          await request.send(); // Sending the request and getting the response
      var responsed = await http.Response.fromStream(response);
      return responsed; // Return the response
    } catch (e) {
      // Logging any error that occurred during request execution
      _logger.e(e.toString());
      rethrow; // Rethrowing error
    }
  }

  // Method to create base header for API requests
  Future<Map<String, String>> _createBaseHeaders() async {
    // Base headers
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Accept': 'application/json',
    };
    return headers;
  }
}
