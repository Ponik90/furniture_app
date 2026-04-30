import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// 🔥 General Failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// 🌐 Network
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// 🔐 Auth
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

// 🗄 Database
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
