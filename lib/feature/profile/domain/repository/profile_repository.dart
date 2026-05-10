import 'package:furniture_app/feature/profile/data/model/profile_model.dart';

import '../../../../core/constant/app_imports.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getUserProfile({
    required String userId,
  });

  Future<Either<Failure, void>> updateProfileData({
    required String userId,
    required String name,
    required String dob,
    required String image,
    required String number,
  });
}
