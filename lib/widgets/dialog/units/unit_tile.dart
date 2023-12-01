import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/drawer_dialog_unit.dart';
class UnitTile extends StatelessWidget {
  final int id;
  final String currentUnit;
  final bool isSecond;
  const UnitTile({
    required this.currentUnit,
    required this.id,
    required this.isSecond,
    super.key});
  @override
  Widget build(BuildContext context) {
    final UnitProvider textProv = Provider.of<UnitProvider>(context,listen:false);
    final DialogProvider dialogProv = Provider.of<DialogProvider>(context,listen:false);
    return Container(
      margin:const EdgeInsets.only(top:6,bottom:6,left:10,right:10),
      decoration: BoxDecoration(
        color:id==(isSecond?selectedUnitIndex2:selectedUnitIndex)?const Color.fromRGBO(56, 56, 56,1):Colors.transparent,
        borderRadius: BorderRadius.circular(8)
      ),
      height:40,
      child: TextButton(
        onPressed:(){
        dialogProv.changeUnit(id,second:isSecond);
        textProv.notify();
        Navigator.pop(context);
        },
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero),
          overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent)
        ),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height:15,
              width:4,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color:id==(isSecond?selectedUnitIndex2:selectedUnitIndex)?const Color.fromRGBO(118, 185, 237,1):Colors.transparent
              )
            ),
            const SizedBox(width:6),
            Text(
              currentUnit,
              style:const TextStyle(
                color:Colors.white,
                fontSize:18
              )
            )
          ],
        )
      ),
    );
  }
}