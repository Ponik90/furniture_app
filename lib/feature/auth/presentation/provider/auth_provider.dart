import 'dart:developer';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/constant/storage_key.dart';
import 'package:furniture_app/core/services/cloudinary_upload_image_service/upload_image_service.dart';
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/auth/domain/usecase/complete_profile_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_account_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/login_use_case.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService storageService;
  final LoginUseCase loginUseCase;
  final CreateAccountUseCase createAccountUseCase;
  final CreateUserUseCase createUserUseCase;
  final CompleteProfileUseCase completeProfileUseCase;

  AuthProvider({
    required this.storageService,
    required this.loginUseCase,
    required this.createAccountUseCase,
    required this.createUserUseCase,
    required this.completeProfileUseCase,
    required this.uploadImageService,
  });

  Future<void> navigateAccordingState() async {
    final isLogeIn = storageService.getBool(key: StorageKey.isLogin);
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      if (isLogeIn ?? false) {
        context.goNamed(Routes.homeScreen.name);
      } else {
        context.goNamed(Routes.loginScreen.name);
      }
    }
  }

  Future<void> login({required String email, required String password}) async {
    final result = await loginUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    result.fold(
      (l) {
        log("login failed message :: ${l.message}");
      },
      (r) {
        log("successful message :: ${r.credential}");
        storageService.setBool(key: StorageKey.isLogin, value: true);
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(Routes.homeScreen.name);
        }
      },
    );
  }

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    final result = await createAccountUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    result.fold(
      (l) {
        log("create account failed message :: ${l.message}");
      },
      (r) {
        log("successful message :: ${r.user}");
        storageService.setString(
          key: StorageKey.userId,
          value: r.user?.uid ?? "",
        );
        createUser(
          email: r.user?.email ?? "",
          name: r.user?.displayName ?? "",
          userId: r.user?.uid ?? "",
        );
      },
    );
  }

  Future<void> createUser({
    required String email,
    required String name,
    required String userId,
  }) async {
    final result = await createUserUseCase.call(
      CreateUserParams(email: email, name: 'name', userId: userId),
    );
    result.fold(
      (l) {
        log("Create User message :: ${l.message}");
      },
      (r) {
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(Routes.completeProfileScreen.name);
        }
      },
    );
  }

  final UploadImageService uploadImageService;
  String imageUrl = '';

  Future<void> getProfileImage() async {
    try {
      final image = ImagePicker();
      final fileImage = await image.pickImage(source: .gallery);
      fileImage;
      if (fileImage != null && fileImage.path.isNotEmpty) {
        final result = await uploadImageService.uploadImage(fileImage);
        result.fold(
          (l) {
            log("message fail upload image :: ${l}");
          },
          (r) {
            log("Imagev Data ::: ${r.data}");

            imageUrl = r.data['secure_url'];
            notifyListeners();
          },
        );
      }
    } catch (e, s) {
      log("Upload Image Error:: $e", stackTrace: s);
    } finally {}
  }

  Future<void> completeProfile({
    required String number,
    required String dob,
    required String name,
  }) async {
    storageService.setString(
      key: StorageKey.userId,
      value: "FvRemFPrCqa8SwNqFFhkCZgbAKD3",
    );
    final userId = storageService.getString(key: StorageKey.userId);
    final result = await completeProfileUseCase.call(
      CompleteProfileParams(
        image: imageUrl,
        number: number,
        userId: userId ?? "",
        dob: dob,
        name: name,
      ),
    );
    result.fold(
      (l) {
        log("login failed message :: ${l.message}");
      },
      (r) {
        log("successful message :: r");
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(Routes.homeScreen.name);
        }
      },
    );
  }
}
