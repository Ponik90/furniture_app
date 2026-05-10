import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/core/constant/app_constant.dart';
import 'package:furniture_app/feature/profile/data/model/profile_model.dart';

abstract interface class ProfileRemoteData {
  Future<ProfileModel> getProfileData({required String userId});

  Future<void> updateProfileData({
    required String userId,
    required String name,
    required String dob,
    required String image,
    required String number,
  });
}

class ProfileRemoteDataImpl implements ProfileRemoteData {
  final FirebaseFirestore firebaseFirestore;

  ProfileRemoteDataImpl({required this.firebaseFirestore});

  @override
  Future<ProfileModel> getProfileData({required String userId}) async {
    final data = await firebaseFirestore
        .collection(AppConstant.userCollection)
        .doc(userId)
        .get();

    return ProfileModel.fromMap(data.data()!);
  }

  @override
  Future<void> updateProfileData({
    required String userId,
    required String name,
    required String dob,
    required String image,
    required String number,
  }) async {
    await firebaseFirestore
        .collection(AppConstant.userCollection)
        .doc(userId)
        .update({
          "name": name,
          "dob": dob,
          "image": image,
          "number": number,
          "update_date": Timestamp.now(),
        });
  }
}
