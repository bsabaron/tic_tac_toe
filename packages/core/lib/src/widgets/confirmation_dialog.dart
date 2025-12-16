import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      title: Text(title, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onCancel?.call();
          },
          child: Text('Non'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
          child: Text('Oui'),
        ),
      ],
    );
  }
}
