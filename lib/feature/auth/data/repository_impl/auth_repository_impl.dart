import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/feature/auth/data/remote_data/auth_remote_data.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';

import '../../../../core/constant/app_imports.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, UserCredential>> loginData({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remote.login(email: email, password: password);
      return Right(result);
    } catch (e) {
      return Left(AppInterceptor.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remote.createAccount(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(AppInterceptor.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> createUser({
    required String userId,
    required String name,
    required String email,
  }) async {
    try {
      final result = await remote.createUser(
        email: email,
        name: name,
        userId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(AppInterceptor.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> completeUserProfile({
    required String userId,
    required String image,
    required String name,
    required String number,
    required String dob,
  }) async {
    try {
      final result = await remote.completeUserProfile(
        dob: dob,
        number: number,
        image: image,
        name: name,
        userId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(AppInterceptor.handleException(e));
    }
  }
}
