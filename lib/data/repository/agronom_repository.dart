import 'dart:convert';
import 'dart:io';
import 'package:agranomai/data/model/agronom_ai.dart';
import 'package:dio/dio.dart';

class AgronomAiRepository {
  final String baseUrl;
  final Dio dio;

  AgronomAiRepository({required this.baseUrl}) : dio = Dio() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      "Content-Type": "application/json",
    };
  }

  Future<AgronomAi?> fetchAgronomAiData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);

      if (response.statusCode == 200) {
        return AgronomAi.fromJson(response.data);
      } else {
        print('Xatolik: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Xatolik yuz berdi: $e');
      return null;
    }
  }

  Future<bool> sendAgronomAiData(AgronomAi agronomAi) async {
    try {
      final response = await dio.post(
        '/data',
        data: jsonEncode(agronomAi.toJson()),
      );

      if (response.statusCode == 201) {
        print('✅ Ma’lumot muvaffaqiyatli yuborildi!');
        return true;
      } else {
        print('Yuborishda xatolik: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Xatolik yuz berdi: $e');
      return false;
    }
  }

  Future<bool> sendImage(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path),
      });

      final response = await dio.post(
        '/upload', // O‘zgartirish kerak bo‘lishi mumkin, serverda rasmni yuklash uchun kerakli endpoint
        data: formData,
      );

      if (response.statusCode == 200) {
        print('✅ Rasm muvaffaqiyatli yuborildi!');
        return true;
      } else {
        print('Rasm yuborishda xatolik: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Rasm yuborishda xatolik: $e');
      return false;
    }
  }
}
