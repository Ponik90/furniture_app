import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';

class CheckUserUseCase implements UseCase<DocumentSnapshot, String> {
  final AuthRepository authRepository;

  CheckUserUseCase({required this.authRepository});

  @override
  Future<Either<Failure, DocumentSnapshot<Object?>>> call(String params) {
    return authRepository.checkUser(userId: params);
  }
}
