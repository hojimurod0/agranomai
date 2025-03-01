import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agranomai/provider/chat_provider.dart';
import 'package:agranomai/presentation/screens/first_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agronom AI',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FirstScreen(),
    );
  }
}