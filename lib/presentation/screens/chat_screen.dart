// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   File? _selectedImage;
//   final List<Map<String, dynamic>> _messages = [];
//   final TextEditingController _textController = TextEditingController();

//   // Kamera orqali rasm tanlash
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera, // Kameradan rasm olish
//     );
//     if (pickedFile == null) return;

//     setState(() {
//       _selectedImage = File(pickedFile.path);
//       // Tanlangan rasmni xabar sifatida qo‘shish
//       _messages.add({"type": "image", "content": _selectedImage});
//     });
//   }

//   // Yozilgan xabarni yuborish
//   void _sendMessage() {
//     if (_textController.text.trim().isEmpty) return;

//     setState(() {
//       _messages.add({"type": "text", "content": _textController.text});
//       _textController.clear(); // Matnni tozalash
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Agronom AI Chat"),
//         backgroundColor: Colors.green,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Chatdagi xabarlar ro‘yxatini chiqarish
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 if (message["type"] == "text") {
//                   return _buildTextMessage(message["content"]);
//                 } else if (message["type"] == "image") {
//                   return _buildImageMessage(message["content"]);
//                 }
//                 return const SizedBox.shrink(); // Hech qanday xabar yo‘q bo‘lsa
//               },
//             ),
//           ),

//           // Foydalanuvchi uchun input qismi
//           _buildInputArea(),
//         ],
//       ),
//     );
//   }

  
//   Widget _buildTextMessage(String text) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.green[200],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 16, color: Colors.black87),
//         ),
//       ),
//     );
//   }


//   Widget _buildImageMessage(File image) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Image.file(
//             image,
//             height: 200,
//             width: 150,
//             fit: BoxFit.cover,
//           ), // Rasmni ekranda chiqarish
//         ),
//       ),
//     );
//   }


//   Widget _buildInputArea() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 5,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Kamera tugmasi
//           IconButton(
//             onPressed: _pickImage,
//             icon: const Icon(Icons.camera_alt, color: Colors.green, size: 30),
//           ),

//           // Matnli input
//           Expanded(
//             child: TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 hintText: "Xabar yozing...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//               ),
//             ),
//           ),

//           // Yuborish tugmasi
//           IconButton(
//             onPressed: _sendMessage,
//             icon: const Icon(Icons.send, color: Colors.green, size: 30),
//           ),
//         ],
//       ),
//     );
//   }
// }
