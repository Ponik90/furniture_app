import 'dart:developer';

import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/constant/storage_key.dart';
import 'package:furniture_app/core/services/cloudinary_upload_image_service/upload_image_service.dart';
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/profile/data/model/profile_model.dart';
import 'package:furniture_app/feature/profile/domain/use_case/get_profile_use_case.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfileUseCase getProfileUseCase;
  final StorageService storageService;
  final UploadImageService uploadImageService;

  ProfileProvider({
    required this.getProfileUseCase,
    required this.storageService,
    required this.uploadImageService,
  });

  ProfileModel profileData = ProfileModel();

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
}
