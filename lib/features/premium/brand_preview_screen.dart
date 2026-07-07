import 'package:flutter/material.dart';

class BrandPreviewScreen extends StatelessWidget {
  const BrandPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      appBar: AppBar(
        title: const Text("Dawrati Branding"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Image.asset(
          "assets/images/brand_logos.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}