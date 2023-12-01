import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/calc/calc.dart';
import '../custom_snackbar.dart';
class HistoryTile extends StatelessWidget {
  final String expression;
  final String answer;
  final bool isStandard;
  const HistoryTile({required this.expression,required this.answer, required this.isStandard,super.key});

  @override
  Widget build(BuildContext context) {
    final StandardCalcProvider standardCalcProv = Provider.of<StandardCalcProvider>(context,listen:false);
    final ScientificCalcProvider scientificCalcProv = Provider.of<ScientificCalcProvider>(context,listen:false);
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal:4,vertical:10),
      child: TextButton(
        onPressed:standardCalcProv.errorOccurred||scientificCalcProv.errorOccurred?null:(){
          if(isStandard){
            final List<String> exp = expression.trim().split(" ");
            standardCalcProv
            ..left = exp[0]
            ..currentOperator = exp[1]
            ..right = exp[2]
            ..rightUsed=true
            ..eql(null);
          }
          else{
            scientificCalcProv
            ..expression = expression
            ..eql(null);
          }
          Navigator.pop(context);
        },
        onLongPress: (){
          Clipboard.setData(ClipboardData(text:"$expression = $answer"));
          Navigator.pop(context);
          showSnackBar_(context);
        },
        style:ButtonStyle(
          backgroundColor:const MaterialStatePropertyAll<Color>(Colors.transparent),
          overlayColor:const MaterialStatePropertyAll<Color>(Colors.transparent),
          shape:MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        child: SizedBox( 
          width:double.infinity,
          height:70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end, 
            children:[ 
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  fit:BoxFit.fitWidth,
                  child: Text(
                    "$expression = ",
                    textAlign: TextAlign.right,
                    style:const TextStyle(
                      color:Colors.white54,
                      fontSize:20,
                      fontWeight:FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height:10),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  fit:BoxFit.fitWidth,
                  child:Text(
                    answer,
                    textAlign: TextAlign.right,
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:30,
                      fontWeight:FontWeight.w500
                    ),
                  ),
                ),
              ),
            ]
          ),
        )
      ),
    );
  }
}