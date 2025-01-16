import 'package:flutter/material.dart';
import '../../../core/utils/extension/extension.dart';

class TextAndButton extends StatelessWidget {
  const TextAndButton({
    super.key,
    this.text,
    this.buttonText,
    this.onTap,
  });
  final String? text;
  final String? buttonText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text ?? 'Don\'t have an account? ',
          style: context.textTheme.displaySmall,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            buttonText ?? 'Sign Up',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
