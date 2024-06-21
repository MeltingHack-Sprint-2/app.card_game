import "dart:convert";

import "package:card_game/core/apis/api_request_extension.dart";
import "package:http/http.dart" as http;

// Class representing API request with detailed parameters (Extends request from extension)
class APIRequest extends Request {
  // Route for API call
  final String route;

  // Optional query parameters || body params
  @override
  Map<String, dynamic>? params;

  // Type of the request (GET, PUT, POST, PATCH, PUT)
  final RequestType requestType;

  // Constructor requiring route, request type, and optional parameters
  APIRequest({required this.route, this.params, required this.requestType});

  @override
  Future<http.Response> request(
      {required String baseURLPath, Map<String, String>? headers}) async {
    // Build url based on request type and route
    final url = Uri.parse(baseURLPath + route);
    // Perform http request based on request type
    switch (requestType) {
      case RequestType.post:
        return http.post(url, headers: headers, body: jsonEncode(params));

      case RequestType.patch:
        return http.patch(url, headers: headers, body: jsonEncode(params));

      case RequestType.put:
        return http.put(url, headers: headers, body: jsonEncode(params));

      case RequestType.get:
        return http.get(url.replace(queryParameters: params), headers: headers);

      case RequestType.delete:
        return http.delete(url, headers: headers, body: jsonEncode(params));
    }
  }

  // Return API path (same as route)
  @override
  String get apiPath => route;
}
