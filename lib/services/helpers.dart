import 'package:flutter/material.dart';

// Common function to navigating to new route
void pushToNewRoute(BuildContext context, Widget routeName) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => routeName));
}

// Common function to show snack bar
void showSnackBar(
    BuildContext context, String message, int durationInMilliseconds) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(milliseconds: durationInMilliseconds),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
