import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  String? _detectedName;
  String? _detectedDescription;
  String? _detectedImageUrl;

  final Dio _dio = Dio();
  final String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdjMDQ0N2E5ZjA2NTY3NjM0MDhkNThiIiwiaWF0IjoxNzQwNzM3NDgzfQ.pBXPJ719H69sAyFwicnvDhvCjAde0uoeppt2bNmHyKg";

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _detectedName = null;
      _detectedDescription = null;
      _detectedImageUrl = null;
    });

    await _sendImageToApi(_image!);
  }

  Future<void> _sendImageToApi(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      String fileExt = fileName.split('.').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType("image", fileExt),
        ),
      });

      final response = await _dio.post(
        'https://api.agronomai.birnima.uz/api/upload',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $_token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      debugPrint("Server javobi: ${response.data}");

      if (response.statusCode == 200 && response.data["data"] != null) {
        setState(() {
          _detectedName =
              response.data["data"]["type"]["name_uz"] ?? "Noma’lum";
          _detectedDescription =
              response.data["data"]["type"]["description"] ?? "Tavsif yo‘q";
          _detectedImageUrl =
              response.data["data"]["image"] != null
                  ? "https://api.agronomai.birnima.uz${response.data["data"]["image"]}"
                  : null;
        });
      } else {
        debugPrint(" noto‘g‘ri javob keldi: ${response.data}");
      }
    } catch (e, stackTrace) {
      debugPrint('Xatolik: $e\nStackTrace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text("Iltimos, rasm yuklang")
                : Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            _detectedName != null
                ? Column(
                  children: [
                    Text(
                      _detectedName!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _detectedDescription ?? "",
                      textAlign: TextAlign.center,
                    ),
                    if (_detectedImageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.network(
                          _detectedImageUrl!,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text(
                              "Rasmni yuklashda xatolik yuz berdi",
                            );
                          },
                        ),
                      ),
                  ],
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
