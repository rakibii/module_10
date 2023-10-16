import 'package:flutter/material.dart';

InputDecoration AppInputDecoration(label) {
  return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      border: const OutlineInputBorder(
      ),
      labelText: label);
}
