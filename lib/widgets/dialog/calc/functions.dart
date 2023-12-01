import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latext/latext.dart';
import '../../keypad/keypad_button.dart';
import '../../../providers/calc/scientific.dart';
import 'dart:math' show Random;
class FunctionsDialog extends StatelessWidget {
  const FunctionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ScientificCalcProvider scientificProv = Provider.of<ScientificCalcProvider>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
        color:const Color.fromRGBO(45,45,45,1),
        borderRadius: BorderRadius.circular(4)
      ),
      height:140,
      child:Row(
        children: [
          Expanded(
            child: Column(
              children: [
                KeyPadButton(
                  color: const Color.fromRGBO(60,60,60,1),
                  activeColor: const Color.fromRGBO(70,70,70,1),
                  onPressed: (){
                    scientificProv.useFunc('abs(');
                    Navigator.pop(context);
                  },
                  child:const LaTexT(
                    laTeXCode:Text(
                      r"$|x|$",
                      style: TextStyle(
                        fontSize:20,
                        color:Colors.white,
                      )
                    ),
                  )
                ),
                KeyPadButton(
                  color: const Color.fromRGBO(60,60,60,1),
                  activeColor: const Color.fromRGBO(70,70,70,1),
                  onPressed: (){
                    scientificProv.replaceScreenTextWith(Random().nextDouble().toString());
                    Navigator.pop(context);
                  },
                  child:const Text(
                    "rand",
                    style: TextStyle(
                      fontSize:18,
                      color:Colors.white,
                    )
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyPadButton(
                  color: const Color.fromRGBO(60,60,60,1),
                  activeColor: const Color.fromRGBO(70,70,70,1),
                  onPressed: (){
                    scientificProv.useFunc('floor(');
                    Navigator.pop(context);
                  },
                  child:const LaTexT(
                    laTeXCode:Text(
                      r"$⌊x⌋$",
                      style:TextStyle(
                        fontSize:20,
                        color:Colors.white,
                      )
                    ),
                  )
                ),
                KeyPadButton(
                  color: const Color.fromRGBO(60,60,60,1),
                  activeColor: const Color.fromRGBO(70,70,70,1),
                  onPressed: (){
                    scientificProv.useFunc('dms(');
                    Navigator.pop(context);
                  },
                  child:const Text(
                    "➞dms",
                    style: TextStyle(
                      fontSize:18,
                      color:Colors.white,
                    )
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyPadButton(
                  color: const Color.fromRGBO(60,60,60,1),
                  activeColor: const Color.fromRGBO(70,70,70,1),
                  onPressed: (){
                    scientificProv.useFunc('ceil(');
                    Navigator.pop(context);
                  },
                  child:const LaTexT(
                    laTeXCode:Text(
                      r"$⌈x⌉$",
                      style:TextStyle(
                        fontSize:20,
                        color:Colors.white,
                      )
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}