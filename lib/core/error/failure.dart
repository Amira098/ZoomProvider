/// Base class for all failures
abstract class Failure implements Exception {
  final String message;
  final Map<String, dynamic>? details;

  Failure(this.message, {this.details});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class ValidationFailure extends Failure {
  ValidationFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

/// Network failure (e.g., no internet connection)
class NetworkFailure extends Failure {
  NetworkFailure() : super('No internet connection');
}

/// Unknown or unhandled failure
class UnknownFailure extends Failure {
  UnknownFailure(String message) : super(message);
}
