import 'package:flutter/material.dart';
import '../../providers/drawer_dialog_unit.dart';
class DrawerTile extends StatelessWidget {
  final int id;
  final IconData icon;
  final String currentName;
  final DrawerProvider drawerProv;
  final UnitProvider? textProv;
  final DialogProvider? dialogProv;
  const DrawerTile({
    required this.icon,
    required this.currentName,
    required this.id,
    required this.drawerProv,
    this.textProv,
    this.dialogProv,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:id==selectedCategory?const Color.fromRGBO(56, 56, 56,1):Colors.transparent,
        borderRadius: BorderRadius.circular(8)
      ),
      height:50,
      child: TextButton(
        onPressed:(){
          drawerProv.changeCategory(id);
          if(id>2){
            dialogProv!.resetUnitIndices();
            textProv!.resetText(); 
          }
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
              height:20,
              width:4,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color:id==selectedCategory?const Color.fromRGBO(118, 185, 237,1):Colors.transparent
              )
            ),
            const SizedBox(width:6),
            Icon(
              icon,
              color:Colors.white
            ),
            const SizedBox(width:10),
            Text(
              currentName,
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