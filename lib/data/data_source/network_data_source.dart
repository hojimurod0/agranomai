import 'package:agranomai/data/model/agronom_ai.dart';
import 'package:agranomai/data/model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class AgronomAirService {
  final Dio _dio = Dio();

  Future<void> fetchImage(String imageFilePath) async {
    try {
      print("imageFilePath $imageFilePath");
      String fileName = imageFilePath.split('/').last;
      var fileExt = fileName.split('.').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFilePath,
          filename: fileName,
          contentType: MediaType("image", fileExt),
        ),
      }
      );


      print("formData ${formData.fields}");
      final response = await _dio.post(
        'https://api.agronomai.birnima.uz/api/upload',
        data: formData,
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdjMDQ0N2E5ZjA2NTY3NjM0MDhkNThiIiwiaWF0IjoxNzQwNzI0NTUxfQ.u6hYO0l54C9N-BB4tIVhCS7RKu8nJO9YWDHzOZuC14M",

            "Content-Type": "multipart/form-data",
          },
        ),
      );
      print("response is: $response");

      if (response.statusCode == 200) {
        final agronomAi = AgronomAi.fromJson(response.data);
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
    Future<ProductModel?> fetchProductData(String endpoint) async {
    try {
      final response = await _dio.get(
        'https://api.agronomai.birnima.uz/api/$endpoint',
       options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdjMDQ0N2E5ZjA2NTY3NjM0MDhkNThiIiwiaWF0IjoxNzQwNzI0NTUxfQ.u6hYO0l54C9N-BB4tIVhCS7RKu8nJO9YWDHzOZuC14M",

            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        print("Server xatosi: ${response.statusCode}");
      }
    } catch (e) {
      print("API xatosi: $e");
    }
    return null;
  }
}
