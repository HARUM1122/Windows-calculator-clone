import 'package:flutter/material.dart';
export 'units/unit_dialog.dart';
showD(BuildContext context,Widget child){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color.fromRGBO(45, 45, 45,1),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child:child
      );
    }
  );
}