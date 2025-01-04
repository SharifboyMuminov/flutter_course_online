import 'package:flutter/material.dart';

class CostumeButton extends StatelessWidget {
  const CostumeButton({
    super.key,
    required this.onTab,
    this.isActive = true,
  });

  final VoidCallback onTab;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? Colors.blue : Colors.grey.withValues(alpha: 0.7),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      onPressed: isActive ? onTab : null,
      child: Text(
        "Submit",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
