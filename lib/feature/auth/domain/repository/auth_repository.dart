import 'package:firebase_auth/firebase_auth.dart';

import 'package:furniture_app/core/constant/app_imports.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> loginData({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserCredential>> createAccount({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> createUser({
    required String userId,
    required String name,
    required String email,
  });

  Future<Either<Failure, void>> completeUserProfile({
    required String userId,
    required String image,
    required String name,
    required String number,
    required String dob,
  });
}
