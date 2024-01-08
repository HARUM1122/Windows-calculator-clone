import 'package:flutter/material.dart';

void showSnackBar_(context) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        backgroundColor: const Color.fromRGBO(54, 54, 54, 1),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        margin: const EdgeInsets.only(left: 80, right: 80, bottom: 30),
        content:
            const Text("Text copied", style: TextStyle(color: Colors.white))));
