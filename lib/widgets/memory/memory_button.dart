import 'package:flutter/material.dart';

class MemoryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool disable;
  const MemoryButton({required this.text,required this.onPressed,this.disable=false,super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
            foregroundColor: disable?const MaterialStatePropertyAll<Color>(Colors.white54):MaterialStateProperty.resolveWith<Color>((Set<MaterialState>state)=>
              state.contains(MaterialState.pressed)?const Color.fromRGBO(120, 120, 120, 1):Colors.white
            ),
            overlayColor:const MaterialStatePropertyAll<Color>(Colors.transparent),
          ),
        onPressed: disable?null:onPressed,
        child:Text(
          text,
          style:const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400
          )
        )
      ),
    );
  }
}