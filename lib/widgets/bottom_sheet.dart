import 'package:flutter/material.dart';

void showSheet(BuildContext context,Widget child){
  showModalBottomSheet(
    context: context, 
    isScrollControlled: true,
    backgroundColor:Colors.transparent,
    builder: (context)=>Container(
      height:MediaQuery.of(context).size.height/1.6,
      decoration: const BoxDecoration(
        color:Color.fromRGBO(32, 32, 32,1),
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(8),
          topRight: Radius.circular(8)
        )
      ),
      child:child
    )
  );
}