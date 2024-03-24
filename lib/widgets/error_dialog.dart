import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key,required this.errorMessage, required this.errorTitle});

  final String errorMessage;
  final String errorTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: Text(errorTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(errorMessage),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Try Again")),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          );
  }
}