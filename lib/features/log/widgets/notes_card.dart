import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final TextEditingController controller;

  const NotesCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notes",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Write anything you want to remember...",
              filled: true,
              fillColor: const Color(0xFFFFF7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}