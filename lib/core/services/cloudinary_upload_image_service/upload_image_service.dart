import 'package:dio/dio.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageService {
  final Dio dio;

  UploadImageService({required this.dio});

  static const cloudName = "dzkkwixxy";

  final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

  Future<Either<Exception, Response>> uploadImage(XFile file) async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
        "upload_preset": "usigned-preset",
      });

      final response = await dio.post(url, data: formData);

      return Right(response); // ✅ success
    } on DioException catch (dioE) {
      print("Cloudinary Error: ${dioE.response?.data}"); // 🔥 IMPORTANT

      return Left(Exception(dioE.message)); // ✅ dio error
    } catch (e) {
      return Left(Exception(e.toString())); // ✅ generic error
    }
  }
}
