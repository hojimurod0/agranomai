// import 'dart:convert';
// import 'dart:io';

// import 'package:agranomai/data/repository/agronom_repository.dart';
// import 'package:flutter/foundation.dart';
// import 'package:agranomai/data/model/agronom_ai.dart';
// import 'package:http/http.dart' as http;

// class AgronomAiProvider with ChangeNotifier {
//   final AgronomAiRepository repository;
//   AgronomAiProvider({required this.repository});

//   final String baseUrl = 'https://yourapi.com'; // Define your base URL here

//   AgronomAi? _agronomAi;
//   bool _isLoading = false;
//   String? _error;

//   AgronomAi? get agronomAi => _agronomAi;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchAgronomAiData(String endpoint) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     final data = await repository.fetchAgronomAiData(endpoint);
//     if (data != null) {
//       _agronomAi = data;
//     } else {
//       _error = "Ma'lumotni yuklashda xatolik yuz berdi";
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<bool> sendAgronomAiData(AgronomAi agronomAi) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     final success = await repository.sendAgronomAiData(agronomAi);
//     if (!success) {
//       _error = "Ma'lumotni yuborishda xatolik yuz berdi";
//     }
//     _isLoading = false;
//     notifyListeners();
//     return success;
//   }

//   Future<void> sendImage(File imageFile) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse('$baseUrl/upload'),
//       );
//       request.files.add(
//         await http.MultipartFile.fromPath('image', imageFile.path),
//       );
//       final response = await request.send();

//       if (response.statusCode == 200) {
//         final responseData = await response.stream.bytesToString();
//         _agronomAi = AgronomAi.fromJson(jsonDecode(responseData));
//       } else {
//         _error = "Rasmni yuborishda xatolik yuz berdi";
//       }
//     } catch (e) {
//       _error = "Xatolik yuz berdi: $e";
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
