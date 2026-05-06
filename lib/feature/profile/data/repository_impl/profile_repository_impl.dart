import 'package:dio/dio.dart';
import 'package:furniture_app/feature/profile/data/data_source/remote_data.dart';
import 'package:furniture_app/feature/profile/data/model/profile_model.dart';
import 'package:furniture_app/feature/profile/domain/repository/profile_repository.dart';

import '../../../../core/constant/app_imports.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteData profileRemoteData;

  ProfileRepositoryImpl({required this.profileRemoteData});

  @override
  Future<Either<Failure, ProfileModel>> getUserProfile({
    required String userId,
  }) async {
    try {
      final result = await profileRemoteData.getProfileData(userId: userId);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppInterceptor.handleException(e));
    } catch (e) {
      return Left(AppInterceptor.handleException(e));
    }
  }
}
