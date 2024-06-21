import 'app_exception.dart';

class ErrorMapper {
  static String getErrorMessage(dynamic error) {
    if (error is AppException) {
      return error.message;
    }
    return "An unexpected error occurred.";
  }

  static String mapStatusCodeToMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
      case 403:
        return "Unauthorized. Please log in again.";
      case 404:
        return "Resource not found.";
      case 500:
      default:
        return "Server error. Please try again later.";
    }
  }
}
