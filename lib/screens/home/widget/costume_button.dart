import 'package:flutter/material.dart';

class CostumeButton extends StatelessWidget {
  const CostumeButton({
    super.key,
    required this.onTab,
    this.isActive = true,
    this.icLoader = false,
  });

  final VoidCallback onTab;
  final bool isActive;
  final bool icLoader;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? Colors.blue : Colors.grey.withValues(alpha: 0.7),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      onPressed: icLoader
          ? null
          : isActive
              ? onTab
              : null,
      child: icLoader
          ? CircularProgressIndicator.adaptive()
          : Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
