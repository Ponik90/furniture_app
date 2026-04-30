import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/core/use_case/use_case.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';

import '../../../../core/constant/app_imports.dart';

class LoginUseCase extends UseCase<UserCredential, UserEmailPassParms> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserCredential>> call(UserEmailPassParms params) async {
    return await authRepository.loginData(email: params.email, password: params.pass);
  }
}

class UserEmailPassParms extends Equatable {
  final String email;
  final String pass;

  const UserEmailPassParms({required this.email, required this.pass});

  @override
  List<Object?> get props => [email, pass];
}
