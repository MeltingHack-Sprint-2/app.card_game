class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, {this.code});
}

class NetworkException extends AppException {
  NetworkException(String message, {int? code}) : super(message, code: code);
}

class ServerException extends AppException {
  ServerException(String message, {int? code}) : super(message, code: code);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message, {int? code})
      : super(message, code: code);
}

class NotFoundException extends AppException {
  NotFoundException(String message, {int? code}) : super(message, code: code);
}
