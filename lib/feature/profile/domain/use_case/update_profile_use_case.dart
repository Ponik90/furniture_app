import 'package:equatable/equatable.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/profile/domain/repository/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<void, UpdateProfileParams> {
  ProfileRepository profileRepository;

  UpdateProfileUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) {
    return profileRepository.updateProfileData(
      number: params.number,
      name: params.name,
      dob: params.dob,
      image: params.image,
      userId: params.userId,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String userId;
  final String name;
  final String dob;
  final String image;
  final String number;

  const UpdateProfileParams({
    required this.userId,
    required this.name,
    required this.dob,
    required this.image,
    required this.number,
  });

  @override
  List<Object?> get props => [userId, name, dob, image, number];
}
