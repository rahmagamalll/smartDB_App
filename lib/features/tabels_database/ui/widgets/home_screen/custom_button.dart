
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/theming/colors.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.name, required this.onTap});
  final String name;
  final VoidCallback onTap;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(8.0),
        height: _isPressed ? 90 : 100,
        width: _isPressed ? 90 : 100,
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.primaryColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
