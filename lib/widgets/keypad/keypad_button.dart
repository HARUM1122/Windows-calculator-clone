import 'package:flutter/material.dart';

class KeyPadButton extends StatelessWidget {
  final Color color;
  final Color? activeColor;
  final double?height;
  final bool disable;
  final Function() onPressed;
  final Widget child;
  const KeyPadButton({
      this.height,
      this.activeColor,
      this.disable=false,
      required this.color,
      required this.child,
      required this.onPressed,
      super.key
    });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height:height??MediaQuery.of(context).size.height/11.5,
        margin:const EdgeInsets.all(2),
        child: Material(
          color:disable?const Color.fromRGBO(40,40,40,1):color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              highlightColor:activeColor??Colors.transparent,
              splashColor: activeColor??Colors.transparent,
              onTap:disable?null:onPressed,
              child: Center(
                child:child
              ),
            ),
          ),
        ),
      ),
    );
  }
}