import 'package:equatable/equatable.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';

class CompleteProfileUseCase implements UseCase<void, CompleteProfileParams> {
  final AuthRepository authRepository;

  CompleteProfileUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(CompleteProfileParams params) {
    return authRepository.completeUserProfile(
      number: params.number,
      dob: params.dob,
      image: params.image,
      userId: params.userId,
      name: params.name,
      isVerified: params.isVerified,
    );
  }
}

class CompleteProfileParams extends Equatable {
  final String userId;
  final String name;
  final String number;
  final String dob;
  final String image;
  final bool isVerified;

  const CompleteProfileParams({
    required this.userId,
    required this.name,
    required this.number,
    required this.dob,
    required this.image,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [userId, name, number, dob, image, isVerified];
}
