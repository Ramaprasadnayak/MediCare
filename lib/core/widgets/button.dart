import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final double height, width;
  final String text;
  const Button({
    super.key,
    required this.height,
    required this.width,
    required this.text,
  });
  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E63E9).withValues(alpha: 0.30),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF2F80ED), Color(0xFF1E5BD8)],
        ),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
