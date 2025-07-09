import 'package:flutter/material.dart';

final inputDecoration = InputDecoration(
  filled: true,
  fillColor: const Color(0xFFF4F0E6),
  contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide.none,
  ),
  hintStyle: const TextStyle(color: Color(0xFF9E8747), fontSize: 16.0),
);
