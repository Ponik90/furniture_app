import 'dart:developer';

import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/constant/storage_key.dart';
import 'package:furniture_app/core/services/cloudinary_upload_image_service/upload_image_service.dart';
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/profile/data/model/profile_model.dart';
import 'package:furniture_app/feature/profile/domain/use_case/get_profile_use_case.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/use_case/update_profile_use_case.dart';

class ProfileProvider extends ChangeNotifier {
  final StorageService storageService;
  final UploadImageService uploadImageService;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileProvider({
    required this.getProfileUseCase,
    required this.storageService,
    required this.uploadImageService,
    required this.updateProfileUseCase,
  });

  ProfileModel profileData = ProfileModel();
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
            log("message fail upload image :: $l");
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

  Future<void> getProfileData() async {
    final userId = storageService.getString(key: StorageKey.userId);

    final response = await getProfileUseCase.call(userId ?? "");

    response.fold(
      (l) {
        log("Profile Data error :: $l");
      },
      (profileModel) {
        profileData = profileModel;
        notifyListeners();
      },
    );
  }

  bool _isUpdateProfile = false;

  bool get isUpdateProfile => _isUpdateProfile;

  set isUpdateProfile(bool value) {
    _isUpdateProfile = value;
    notifyListeners();
  }

  Future<void> updateProfileData({
    required String name,
    required String dob,
    required String image,
    required String number,
  }) async {
    isUpdateProfile = true;
    final userId = storageService.getString(key: StorageKey.userId);
    final response = await updateProfileUseCase.call(
      UpdateProfileParams(
        userId: userId ?? "",
        name: name,
        dob: dob,
        image: image,
        number: number,
      ),
    );

    response.fold(
      (l) {
        isUpdateProfile = false;
        log("Filed update profile :: $l");
      },
      (r) {
        isUpdateProfile = false;
        getProfileData();
        log("Profile Update Successfully");
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.pop();
        }
      },
    );
  }
}
