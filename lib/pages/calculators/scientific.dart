import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../widgets/memory/memory.dart';
import '../../widgets/keypad/keypad.dart';
import '../../providers/calc/scientific.dart';
import '../../widgets/dialog/calc/calc.dart';
import '../../widgets/dialog/dialog.dart';
import '../../widgets/custom_snackbar.dart';
class ScientificCalculator extends StatelessWidget {
  const ScientificCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color:const Color.fromRGBO(32, 32, 32,1),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height:20),
          SizedBox(
            width:double.infinity,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end, 
              children:[
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  child: FittedBox(
                    fit:BoxFit.fitWidth,
                    child: Consumer<ScientificCalcProvider>(
                      builder:(context,calcProv,_) =>
                      Text(
                        calcProv.expression.isEmpty?" ":calcProv.expression,
                        textAlign: TextAlign.right,
                        style:const TextStyle(
                          color:Colors.white54,
                          fontSize:20,
                          fontWeight:FontWeight.w500
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  child: FittedBox(
                    fit:BoxFit.fitWidth,
                      child:Consumer<ScientificCalcProvider>(
                        builder: (context,calcProv,_)=>
                        GestureDetector(
                          onLongPress: (){
                            Clipboard.setData(ClipboardData(text:calcProv.screenText));
                            showSnackBar_(context);
                          },
                          child: Text(
                            calcProv.screenText,
                            textAlign: TextAlign.right,
                            style:const TextStyle(
                              color:Colors.white,
                              fontSize:60,
                              fontWeight:FontWeight.w500
                            )
                          ),
                        ),
                      ),
                  ),
                ),
              ]
            )
          ),
          const Spacer(),
          Consumer<ScientificCalcProvider>(
            builder:(context,scientificProv,_)=>
            SizedBox(
              height:MediaQuery.of(context).size.height/18,
              child: TextButton(
                onPressed:scientificProv.errorOccurred?null:scientificProv.changeAngleUnit,
                style:const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll<Color>(Colors.transparent),
                  overlayColor:MaterialStatePropertyAll<Color>(Colors.transparent)
                ),
                child: Text(
                  scientificProv.currentAngleUnit.first,
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize: 16
                  )
                )
              ),
            ),
          ),
          const ScientificMemoryPad(),
          const Divider(color:Colors.white38),
          Consumer<ScientificCalcProvider>(
            builder:(context,scientificProv,_)=>Row(
              children:[
                SizedBox(
                  height:MediaQuery.of(context).size.height/18,
                  child: TextButton(
                    onPressed:scientificProv.errorOccurred?null:()=>showD(context,const TrigonometryDialog()),
                    style:const ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll<Color>(Colors.transparent),
                      overlayColor:MaterialStatePropertyAll<Color>(Colors.transparent),
                    ),
                    child:Text(
                      "Trigonometry",
                      style:TextStyle(
                        color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                        fontSize: 16
                      )
                    )
                  ),
                ),
                const SizedBox(width:6),
                SizedBox(
                  height:MediaQuery.of(context).size.height/18,
                  child: TextButton(
                    onPressed:scientificProv.errorOccurred?null:()=>showD(context,const FunctionsDialog()),
                    style:const ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll<Color>(Colors.transparent),
                      overlayColor:MaterialStatePropertyAll<Color>(Colors.transparent)
                    ),
                    child: Text(
                      "Function",
                      style:TextStyle(
                        color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                        fontSize: 16
                      )
                    )
                  ),
                )
              ]
            ),
          ),
          for(final Widget row in KeyPad.scientificKeypad(context))row
        ],
      )
    );
  }
}
