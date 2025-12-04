import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const CatatanApp());
}

class CatatanApp extends StatelessWidget {
  const CatatanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CatatanKu",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const LoginPage(),
    );
  }
}
