import 'dart:developer';
import 'dart:io';
import 'package:agranomai/common/constant/network.constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

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

      final uploadResponse = await _dio.post(
        NetworkConstants.uploadUrl,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer ${NetworkConstants.token}",
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      log(uploadResponse.statusCode.toString());

      if (uploadResponse.statusCode == 201 &&
          uploadResponse.data["data"] != null) {
        final imageUrl = uploadResponse.data["data"]["url"];

        final predictResponse = await _dio.post(
          NetworkConstants.predictUrl,
          data: {"image_path": imageUrl},
          options: Options(
            headers: {
              "Authorization": "Bearer ${NetworkConstants.token}",
              "Content-Type": "application/json",
            },
          ),
        );
        log(predictResponse.statusCode.toString());
        if (predictResponse.statusCode == 201 &&
            predictResponse.data["data"] != null) {
          setState(() {
            _detectedName =
                predictResponse.data["data"]["type"]["name_uz"] ?? "Noma’lum";
            _detectedDescription =
                predictResponse.data["data"]["type"]["description"] ??
                "Tavsif yo‘q";
            _detectedImageUrl =
                predictResponse.data["data"]["image"] != null
                    ? "https://api.agronomai.birnima.uz${predictResponse.data["data"]["image"]}"
                    : null;
          });
        } else {
          throw Exception("AI prognozi olishda xatolik yuz berdi.");
        }
      } else {
        throw Exception("Rasm yuklashda xatolik yuz berdi.");
      }
    } catch (e) {
      print("Xatolik: $e");
      setState(() {
        _detectedName = "Xatolik yuz berdi.";
        _detectedDescription = "Iltimos, internet ulanishingizni tekshiring.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AgronomAI",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image == null
                ? Text(
                  "Iltimos, rasm yuklang 🖼️",

                  style: TextStyle(fontSize: 24, color: Colors.black54),
                )
                : Container(
                  alignment: Alignment.topRight,

                  child: Image.file(_image!, height: 200, fit: BoxFit.cover),
                ),
            const SizedBox(height: 20),

            _detectedName != null
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _detectedName!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _detectedDescription ?? "",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                )
                : Container(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.green[800],
      ),
    );
  }
}
