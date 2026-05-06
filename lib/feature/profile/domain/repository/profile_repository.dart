import 'package:furniture_app/feature/profile/data/model/profile_model.dart';

import '../../../../core/constant/app_imports.dart';

abstract interface class ProfileRepository {

  Future<Either<Failure, ProfileModel>> getUserProfile({
    required String userId,
  });
}
