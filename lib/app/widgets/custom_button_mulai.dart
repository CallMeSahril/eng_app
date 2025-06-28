import 'package:flutter/material.dart';

class CustomButtonMulai extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomButtonMulai({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFC8A76B), // Warna latar belakang (cokelat muda)
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF5C3B00), // Warna border (cokelat tua)
            width: 4,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEFE4AA), // Shadow halus
              offset: Offset(3, 3),
              blurRadius: 4,
            )
          ],
        ),
        child: const Text(
          'Mulai',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}
