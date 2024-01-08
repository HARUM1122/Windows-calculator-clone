import 'package:flutter/material.dart';
import 'unit_tile.dart';
import '../../../providers/drawer_dialog_unit.dart';

class UnitDialog extends StatelessWidget {
  final bool isSecond;
  const UnitDialog({required this.isSecond, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0,
      height: unitList.length == 4 ? 200 : 300,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: unitList.length,
          itemBuilder: (context, index) {
            return UnitTile(
              currentUnit: unitList[index].name,
              id: index,
              isSecond: isSecond,
            );
          }),
    );
  }
}
