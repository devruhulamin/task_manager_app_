import 'package:flutter/material.dart';

void statusSnackBar(BuildContext context, String msg, bool isError) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    msg,
    style: TextStyle(color: isError ? Colors.red : Colors.black),
  )));
}
