import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onTab,
    this.isActiveButton = true,
    this.isLoading = false,
  });

  final VoidCallback onTab;
  final bool isActiveButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
        backgroundColor: isActiveButton ? Colors.blue : Colors.grey,
      ),
      onPressed: isActiveButton ? onTab : null,
      child: isLoading
          ? CircularProgressIndicator.adaptive()
          : Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
    );
  }
}
