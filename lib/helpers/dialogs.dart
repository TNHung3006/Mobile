import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(BuildContext context, String dispMessage) async {
  AlertDialog dialog = AlertDialog(
    title: const Text("Xac nhan"),
    content: Text(dispMessage),
    actions: [
      ElevatedButton(
        onPressed: () =>
            Navigator.of(context, rootNavigator: true).pop("cancel"),
        child: Text("Huy"),
      ), // ElevatedButton
      ElevatedButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
        child: Text("OK"),
      ), // ElevatedButton
    ],
  ); // AlertDialog
  String? res = await showDialog<String?>(
      barrierDismissible: false, // Phai bam vao nut huy hoặc OK
  context: context,
      builder:(context) => dialog,
  );
  return res;
}
void showSnackBar(BuildContext context, String message, int seconds) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: seconds),)
  );
}