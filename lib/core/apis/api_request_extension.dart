import 'dart:convert';

import 'package:http/http.dart' as http;

// Enum defining different type of request types

enum RequestType {
  get,
  post,
  put,
  patch,
  delete,
}

// Converts request type to its string value
extension RequestTypeValue on RequestType {
  String value() {
    switch (this) {
      case RequestType.get:
        return "GET";
      case RequestType.post:
        return "POST";
      case RequestType.put:
        return "PUT";
      case RequestType.patch:
        return "PATCH";
      case RequestType.delete:
        return "DELETE";
    }
  }
}

// Abstract class representing network request

abstract class Request {
  // API path for the request
  String get apiPath;

  // Optional query params
  Map<String, dynamic>? get params;

  // Default request type (Can be overriden in subclasses)
  RequestType type = RequestType.post;

  // Method to make the actual HTTP request with base url and headers
  Future<http.Response> request(
      {required String baseURLPath, required Map<String, String> headers});
}

// Class for representing generic error is in API responses
class GenericResponseError {
  // Error message received from the server
  final String errorMessage;

  GenericResponseError({required this.errorMessage});
}

extension EasyPockerResponse on http.Response {
  // Checks if response is successful
  bool isSuccess() {
    return statusCode >= 200 && statusCode < 300;
  }

  // Retrieves parsed json data from response body
  dynamic get data {
    Map<String, dynamic> decoded = json.decode(body);
    return decoded["data"];
  }

  // Retrieves error message from json response if present
  String? get errorMessage {
    Map<String, dynamic> decoded = json.decode(body);
    return decoded['message'];
  }
}
