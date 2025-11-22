import 'package:flutter/material.dart';

const Color _primaryBlue = Color(0xFF0D47A1);

class header extends StatelessWidget implements PreferredSizeWidget {
  const header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      decoration: const BoxDecoration(
        color: _primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(child: Image.asset('assets/Pongas.png', height: 60)),
    );
  }
}
