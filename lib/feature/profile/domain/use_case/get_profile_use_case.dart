import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/profile/data/model/profile_model.dart';
import 'package:furniture_app/feature/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase implements UseCase<ProfileModel, String> {
  final ProfileRepository profileRepository;

  GetProfileUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, ProfileModel>> call(String params) {
    return profileRepository.getUserProfile(userId: params);
  }
}
