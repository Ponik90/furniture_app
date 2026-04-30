import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:furniture_app/feature/auth/domain/usecase/login_use_case.dart';

import '../../../../core/constant/app_imports.dart';

class CreateAccountUseCase implements UseCase<UserCredential,UserEmailPassParms>{

  final AuthRepository authRepository;

  CreateAccountUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserCredential>> call(UserEmailPassParms params) async {
    return await authRepository.loginData(email: params.email, password: params.pass);
  }
}