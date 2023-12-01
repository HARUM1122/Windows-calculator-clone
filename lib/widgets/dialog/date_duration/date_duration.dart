import 'package:flutter/material.dart';
import 'duration_tile.dart';
class DurationDialog extends StatelessWidget {
  final int option;
  const DurationDialog({required this.option,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:0,
      height:300,
      child:ListView.builder(
        physics:const BouncingScrollPhysics(),
        itemCount:1000,
        itemBuilder: (context,index){
          return DurationTile(
            option:option,
            duration:index,
          );
        }
      )
    );
  }
}