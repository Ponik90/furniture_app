import 'package:equatable/equatable.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';

class CreateUserUseCase implements UseCase<void, CreateUserParams> {
  final AuthRepository authRepository;

  CreateUserUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) {
    return authRepository.createUser(
      userId: params.userId,
      name: params.name,
      email: params.email,
    );
  }
}

class CreateUserParams extends Equatable {
  final String userId;
  final String name;
  final String email;

  const CreateUserParams({
    required this.userId,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [];
}
