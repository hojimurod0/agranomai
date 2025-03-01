import 'dart:io';
import 'package:agranomai/data/repository/agronom_repository.dart';
import 'package:flutter/material.dart';

import 'package:agranomai/data/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ChatProvider extends ChangeNotifier {
  final AgronomAiRepository _repository = AgronomAiRepository(baseUrl: "https://api.agronomai.birnima.uz/api");
  ProductModel? productModel;
  bool isLoading = false;
  File? selectedImage;

  Future<void> getProductData(String endpoint) async {
    isLoading = true;
    notifyListeners();
    productModel = await _repository.fetchAgronomAiData(endpoint) as ProductModel?;
    isLoading = false;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
      await sendImage();
    }
  }

  Future<void> sendImage() async {
    if (selectedImage == null) return;
    isLoading = true;
    notifyListeners();
    bool success = await _repository.sendImage(selectedImage!);
    if (success) {
      await getProductData("latest");
    }
    isLoading = false;
    notifyListeners();
  }
}