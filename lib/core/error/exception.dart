class ServerException implements Exception {}

class NetworkException implements Exception {}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class DatabaseException implements Exception {}
