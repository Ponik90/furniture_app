import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/constant/storage_key.dart';
import 'package:furniture_app/core/services/cloudinary_upload_image_service/upload_image_service.dart';
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/auth/domain/usecase/check_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/complete_profile_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_account_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/login_use_case.dart';
import 'package:furniture_app/feature/profile/data/model/profile_model.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService storageService;
  final LoginUseCase loginUseCase;
  final CheckUserUseCase checkUserUseCase;
  final CreateAccountUseCase createAccountUseCase;
  final CreateUserUseCase createUserUseCase;
  final CompleteProfileUseCase completeProfileUseCase;
  final UploadImageService uploadImageService;

  AuthProvider({
    required this.storageService,
    required this.loginUseCase,
    required this.createAccountUseCase,
    required this.createUserUseCase,
    required this.completeProfileUseCase,
    required this.uploadImageService,
    required this.checkUserUseCase,
  });

  Future<void> navigateAccordingState() async {
    final isLogeIn = storageService.getBool(key: StorageKey.isLogin);
    final userId = storageService.getString(key: StorageKey.userId);
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      if (isLogeIn ?? false) {
        checkUser(userId: userId ?? '');
      } else {
        context.goNamed(Routes.loginScreen.name);
      }
    }
  }

  ///create user credential and data base

  bool _isCreatingAccount = false;

  bool get isCreatingAccount => _isCreatingAccount;

  set isCreatingAccount(bool value) {
    _isCreatingAccount = value;
    notifyListeners();
  }

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    isCreatingAccount = true;
    final result = await createAccountUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    await result.fold(
      (l) async {
        isCreatingAccount = false;
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          CommonSnackbar.show(context: context, message: l.message, isError: true);
        }
        log("create account failed message :: ${l.message}");
      },
      (r) async {
        log("successful message :: ${r.user}");
        await _createUser(
          email: r.user?.email ?? "",
          name: r.user?.displayName ?? "",
          userId: r.user?.uid ?? "",
        );
        isCreatingAccount = false;
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          CommonSnackbar.show(context: context, message: "Account created successfully!");
        }
      },
    );
  }

  Future<void> _createUser({
    required String email,
    required String name,
    required String userId,
  }) async {
    final result = await createUserUseCase.call(
      CreateUserParams(email: email, userId: userId),
    );
    result.fold(
      (l) {
        log("Create User message :: ${l.message}");
      },
      (r) {
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(
            Routes.completeProfileScreen.name,
            queryParameters: {'user_id': userId, "email": email},
          );
        }
      },
    );
  }

  ///login user
  bool _isLoginAccount = false;

  bool get isLoginAccount => _isLoginAccount;

  set isLoginAccount(bool value) {
    _isLoginAccount = value;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    isLoginAccount = true;
    final result = await loginUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    await result.fold(
      (l) async {
        isLoginAccount = false;
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          CommonSnackbar.show(context: context, message: l.message, isError: true);
        }
        log("login failed message :: ${l.message}");
      },
      (r) async {
        log("successful message :: ${r.user}");
        await checkUser(userId: r.user?.uid ?? "");
        isLoginAccount = false;
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          CommonSnackbar.show(context: context, message: "Login successful!");
        }
      },
    );
  }

  ///check user is already login or not
  Future<void> checkUser({required String userId}) async {
    log("Checking user :: $userId");

    final result = await checkUserUseCase.call(userId);
    await result.fold(
      (l) async {
        log("Failed to check user :: ${l.message}");
      },
      (DocumentSnapshot documentSnapshot) async {
        log("User data retrieved :: ${documentSnapshot.data()}");

        if (documentSnapshot.exists) {
          final ProfileModel profileModel = ProfileModel.fromMap(
            documentSnapshot.data() as Map<String, dynamic>,
          );

          await storageService.setBool(key: StorageKey.isLogin, value: true);
          await storageService.setString(
            key: StorageKey.userId,
            value: profileModel.id ?? "",
          );
          final context = rootNavigatorKey.currentContext;
          if (context != null) {
            if (profileModel.isVerified == true) {
              context.goNamed(Routes.homeScreen.name);
            } else {
              context.goNamed(
                Routes.completeProfileScreen.name,
                queryParameters: {
                  'user_id': profileModel.id,
                  "email": profileModel.email,
                },
              );
            }
          }
        } else {
          log("This User does not exist in Firestore");
        }
      },
    );
  }

  ///complete your profile
  bool _isUploadingImage = false;

  bool get isUploadingImage => _isUploadingImage;

  set isUploadingImage(bool value) {
    _isUploadingImage = value;
    notifyListeners();
  }

  String imageUrl = '';

  Future<void> getProfileImage() async {
    try {
      isUploadingImage = true;
      final image = ImagePicker();
      final fileImage = await image.pickImage(source: ImageSource.gallery);
      if (fileImage != null && fileImage.path.isNotEmpty) {
        final result = await uploadImageService.uploadImage(fileImage);
        result.fold(
          (l) {
            isUploadingImage = false;
            log("Image upload failed :: $l");
          },
          (r) {
            isUploadingImage = false;
            log("Image Data ::: ${r.data}");

            imageUrl = r.data['secure_url'];
            notifyListeners();
          },
        );
      }
    } catch (e, s) {
      log("Upload Image Error:: $e", stackTrace: s);
    } finally {
      isUploadingImage = false;
    }
  }

  bool _isCompletingAccount = false;

  bool get isCompletingAccount => _isCompletingAccount;

  set isCompletingAccount(bool value) {
    _isCompletingAccount = value;
    notifyListeners();
  }

  Future<void> completeProfile({
    required String number,
    required String userId,
    required String dob,
    required String name,
  }) async {
    isCompletingAccount = true;
    final result = await completeProfileUseCase.call(
      CompleteProfileParams(
        image: imageUrl,
        number: number,
        userId: userId,
        dob: dob,
        name: name,
        isVerified: true,
      ),
    );
    await result.fold(
      (l) async {
        isCompletingAccount = false;
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          CommonSnackbar.show(context: context, message: l.message, isError: true);
        }
        log("Complete profile failed :: ${l.message}");
      },
      (r) async {
        isCompletingAccount = false;
        log("Profile completed successfully");
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          CommonSnackbar.show(context: context, message: "Profile completed successfully!");
          context.goNamed(Routes.homeScreen.name);
        }
      },
    );
  }

  ///logout
  Future<void> logOut() async {
    await storageService.removeValue(key: StorageKey.isLogin);
    await storageService.removeValue(key: StorageKey.userId);
    await storageService.clearStorage();
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      context.goNamed(Routes.loginScreen.name);
    }
  }

  ///forget password
  bool _isResettingPassword = false;
  bool get isResettingPassword => _isResettingPassword;

  Future<void> forgetPassword({required String email}) async {
    _isResettingPassword = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        CommonSnackbar.show(context: context, message: "Password reset email sent!");
        context.pop();
      }
    } catch (e) {
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        CommonSnackbar.show(context: context, message: e.toString(), isError: true);
      }
    } finally {
      _isResettingPassword = false;
      notifyListeners();
    }
  }
}
