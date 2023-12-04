import 'package:flutter/material.dart';
import 'package:latext/latext.dart';
import 'keypad_button.dart';
import '../../providers/providers.dart';
import 'package:provider/provider.dart';
import '../../utils/utils.dart';
import 'dart:math' show pi,e;
class KeyPad{
  static List<Widget> standardKeypad(BuildContext context){
    final HistoryProvider historyProv = Provider.of<HistoryProvider>(context,listen:false);
    return <Widget>[
      Consumer<StandardCalcProvider>(
        builder:(context,standardProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.useOperator("%",historyProv.addToHistory),
              disable:standardProv.errorOccurred,
              child:Text(
                "%",
                style:TextStyle(
                  fontSize:24,
                  color:standardProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed:()=>standardProv.clearEntry(false),
              child:const Text(
                "CE",
                style:TextStyle(
                  fontSize:20,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.clearEntry(true),
              child:const Text(
                "C",
                style:TextStyle(
                  fontSize:20,
                  color:Colors.white
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed:standardProv.del,
              child:const Text(
                "DEL",
                style:TextStyle(
                  fontSize:20,
                  color:Colors.white
                )
              )
            )
          ],
        ),
      ),
      Consumer<StandardCalcProvider>(
        builder:(context,standardProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.useOperator("^",historyProv.addToHistory),
              disable:standardProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                  r" $x^y$",
                  style:TextStyle(
                    color:standardProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              disable:standardProv.errorOccurred,
              onPressed:(){
                if(standardProv.calculated){
                  standardProv.reset(resetScreenText: false);
                }
                else if(!standardProv.rightUsed&&standardProv.currentOperator.isNotEmpty){
                  standardProv
                  ..right=standardProv.left
                  ..rightUsed=true;
                }
                standardProv.calc('sqr(${trimTrailingZeros(standardProv.screenText)})');
              },
              child:LaTexT(
                laTeXCode: Text(
                  r" $x^2$",
                  textAlign: TextAlign.right,
                  style:TextStyle(
                    color:standardProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              disable:standardProv.errorOccurred,
              onPressed:(){
                if(standardProv.calculated){
                  standardProv.reset(resetScreenText: false);
                }
                else if(!standardProv.rightUsed&&standardProv.currentOperator.isNotEmpty){
                  standardProv
                  ..right=standardProv.left
                  ..rightUsed=true;
                }
                standardProv.calc('sqrt(${trimTrailingZeros(standardProv.screenText)})');
              },
              child:LaTexT(
                laTeXCode: Text(
                  r"$\sqrt[2]{x}$ ",
                  style:TextStyle(
                    color:standardProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:22,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.useOperator("÷",historyProv.addToHistory),
              disable:standardProv.errorOccurred,
              child: Text(
                "÷",
                style:TextStyle(
                  fontSize:34,
                  fontWeight: FontWeight.w300,
                  color:standardProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<StandardCalcProvider>(
        builder:(context,standardProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('7'),
              child:const Text(
                "7",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('8'),
              child:const Text(
                "8",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('9'),
              child:const Text(
                "9",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.useOperator("×",historyProv.addToHistory),
              disable:standardProv.errorOccurred,
              child: Text(
                "×",
                style:TextStyle(
                  fontSize:34,
                  fontWeight: FontWeight.w300,
                  color:standardProv.errorOccurred?Colors.white54:Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<StandardCalcProvider>(
        builder:(context,standardProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('4'),
              child:const Text(
                "4",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('5'),
              child:const Text(
                "5",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('6'),
              child:const Text(
                "6",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.useOperator("-",historyProv.addToHistory),
              disable:standardProv.errorOccurred,
              child: Text(
                "—",
                style:TextStyle(
                  fontSize:28,
                  fontWeight: FontWeight.w400,
                  color:standardProv.errorOccurred?Colors.white54:Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<StandardCalcProvider>(
        builder:(context,standardProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('1'),
              child:const Text(
                "1",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('2'),
              child:const Text(
                "2",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('3'),
              child:const Text(
                "3",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              onPressed: ()=>standardProv.useOperator("+",historyProv.addToHistory),
              disable:standardProv.errorOccurred,
              child:Text(
                "+",
                style:TextStyle(
                  fontSize:34,
                  fontWeight: FontWeight.w300,
                  color:standardProv.errorOccurred?Colors.white54:Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<StandardCalcProvider>(
        builder: (context,standardProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: standardProv.posNeg,
              disable:standardProv.errorOccurred,
              child:Text(
                "+/−",
                style:TextStyle(
                  fontSize:22,
                  color:standardProv.errorOccurred?Colors.white54:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen('0'),
              child:const Text(
                "0",
                style:TextStyle(
                  fontSize:24,
                  color:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: ()=>standardProv.addToScreen("."),
              disable:standardProv.errorOccurred,
              child:Text(
                ".",
                style:TextStyle(
                  fontSize:30,
                  color:standardProv.errorOccurred?Colors.white54:Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(118, 185, 237,1),
              activeColor: const Color.fromRGBO(109, 169, 216,1),
              onPressed:()=>standardProv.eql(historyProv.addToHistory),
              child:const Text(
                "=",
                style:TextStyle(
                  fontSize:34,
                  color:Colors.black,
                  fontWeight: FontWeight.w300,
                )
              )
            )
          ],
        ),
      )
    ];
  }
  static List<Widget> scientificKeypad(BuildContext context){
    final HistoryProvider historyProv = Provider.of<HistoryProvider>(context,listen:false);
    // final ScientificCalcProvider scientificCalcProv = Provider.of<ScientificCalcProvider>(context,listen:false);
    return <Widget>[
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color: scientificProv.second?const Color.fromRGBO(118, 185, 237,1):const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.changeBool(2),
              disable: scientificProv.errorOccurred,
              child:Text(
                "2ⁿᵈ",
                style:TextStyle(
                  fontSize:20,
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):(scientificProv.second?Colors.black:Colors.white),
                  fontWeight: FontWeight.w400,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.replaceScreenTextWith(pi.toString()),
              disable: scientificProv.errorOccurred,
              child: LaTexT(
                laTeXCode: Text(
                  r" $\pi$ ",
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.replaceScreenTextWith(e.toString()),
              disable: scientificProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                  r" $e$ ",
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:scientificProv.clear,
              child:Text(
                scientificProv.clearAll||scientificProv.calculated?"C":"CE",
                style:const TextStyle(
                  color:Colors.white,
                  fontSize:20,
                )
              ),
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:scientificProv.del,
              child:const Text(
                "DEL",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:20,
                )
              ),
            ),
          ],
        ),
      ),
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useFunc(scientificProv.second?'cube(':'sqr('),
              disable: scientificProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                scientificProv.second?r" $x^3$":r" $x^2$",
                  style: TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.useFunc('1/('),
              disable: scientificProv.errorOccurred,
              child: LaTexT(
                laTeXCode: Text(
                  r" $\frac{1}{x}$ ",
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:20,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.useOperator("%"),
              disable: scientificProv.errorOccurred,
              child:Text(
                "%",
                style:TextStyle(
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                  fontSize:22,
                )
              ),
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:scientificProv.useExp,
              disable: scientificProv.errorOccurred,
              child:Text(
                "exp",
                style:TextStyle(
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                  fontSize:20,
                )
              ),
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.useOperator("mod"),
              disable: scientificProv.errorOccurred,
              child:Text(
                "mod",
                style:TextStyle(
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                  fontSize:20,
                )
              ),
            ),
          ],
        ),
      ),
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useFunc(scientificProv.second?'cuberoot(':'sqrt('),
              disable:scientificProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                  scientificProv.second? r"$\sqrt[3]{x}$ ": r"$\sqrt[2]{x}$ ",
                  style: TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.useParenthesis("("),
              disable:scientificProv.errorOccurred,
              child:Stack(
                fit:StackFit.expand,
                children: [
                  Center(
                    child: Text(
                      "(",
                      style:TextStyle(
                        color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                        fontSize:20,
                      )
                    ),
                  ),
                  Positioned(
                    top:28,
                    left:40,
                    child:Text(
                      scientificProv.parenthesesCount.toString()=="0"?'':scientificProv.parenthesesCount.toString(),
                      style:const TextStyle(
                        color:Colors.white,
                        fontSize:12
                      )
                    )
                  )
                ],
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.useParenthesis(")"),
              disable:scientificProv.errorOccurred,
              child: Text(
                ")",
                style:TextStyle(
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                  fontSize:20,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.useFunc('fact('),
              disable:scientificProv.errorOccurred,
              child: LaTexT(
                laTeXCode: Text(
                  r"$n!$",
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useOperator("÷"),
              disable:scientificProv.errorOccurred,
              child:Text(
                "÷",
                style:TextStyle(
                  fontSize:34,
                  fontWeight: FontWeight.w300,
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useOperator(scientificProv.second?'yroot':'^'),
              disable:scientificProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                  scientificProv.second? r"$\sqrt[y]{x}$ ":r" $x^y$",
                  style: TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:24,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("7"),
              child:const Text(
                "7",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("8"),
              child:const Text(
                "8",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("9"),
              child:const Text(
                "9",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useOperator("×"),
              disable:scientificProv.errorOccurred,
              child: Text(
                "×",
                style:TextStyle(
                  fontSize:34,
                  fontWeight: FontWeight.w300,
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useFunc(scientificProv.second?'2^(':'10^('),
              disable:scientificProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                  scientificProv.second? r" $2^x$": r" $10^x$",
                  style: TextStyle(
                    color: scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:22,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("4"),
              child:const Text(
                "4",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("5"),
              child:const Text(
                "5",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("6"),
              child:const Text(
                "6",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useOperator("-"),
              disable:scientificProv.errorOccurred,
              child: Text(
                "—",
                style:TextStyle(
                  fontSize:28,
                  fontWeight: FontWeight.w400,
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              disable:scientificProv.errorOccurred,
              onPressed: () {
                if(scientificProv.second){
                  scientificProv.useOperator('logbase');
                }
                else {
                  scientificProv.useFunc('log(');
                }
              },
              child:LaTexT(
                laTeXCode: Text(
                  scientificProv.second?r"$log_yx$":"log",
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:scientificProv.second?18:20,
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("1"),
              child:const Text(
                "1",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("2"),
              child:const Text(
                "2",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("3"),
              child:const Text(
                "3",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor: const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useOperator("+"),
              disable:scientificProv.errorOccurred,
              child: Text(
                "+",
                style:TextStyle(
                  fontSize:34,
                  fontWeight: FontWeight.w300,
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            )
          ],
        ),
      ),
      Consumer<ScientificCalcProvider>(
        builder:(context,scientificProv,_)=>Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            KeyPadButton(
              color:  const Color.fromRGBO(50,50,50,1),
              activeColor:const Color.fromRGBO(60,60,60,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed: ()=>scientificProv.useFunc(scientificProv.second?'e^(':'ln('),
              disable:scientificProv.errorOccurred,
              child:LaTexT(
                laTeXCode: Text(
                  scientificProv.second? r" $e^x$": "ln",
                  style:TextStyle(
                    color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                    fontSize:scientificProv.second?24:20
                  )
                ),
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:scientificProv.posNeg,
              disable:scientificProv.errorOccurred,
              child: Text(
                "+/−",
                style:TextStyle(
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                  fontSize:22,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("0"),
              child:const Text(
                "0",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:24,
                )
              )
            ),
             KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.addToScreen("."),
              disable:scientificProv.errorOccurred,
              child: Text(
                ".",
                style:TextStyle(
                  fontSize:30,
                  color:scientificProv.errorOccurred?const Color.fromRGBO(120, 120, 120, 1):Colors.white,
                )
              )
            ),
            KeyPadButton(
              color:  const Color.fromRGBO(118, 185, 237,1),
              activeColor: const Color.fromRGBO(109, 169, 216,1),
              height:MediaQuery.of(context).size.height/15,
              onPressed:()=>scientificProv.eql(historyProv.addToHistory),
              child:const Text(
                "=",
                style:TextStyle(
                  fontSize:34,
                  color:Colors.black,
                  fontWeight: FontWeight.w300,
                )
              )
            )
          ],
        ),
      ),
    ];
  }
  static List<Widget> unitKeypad(BuildContext context){
    UnitProvider textProvider = Provider.of<UnitProvider>(context,listen:false);
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child:Container()
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(50,50,50,1),
            activeColor: const Color.fromRGBO(60,60,60,1),
            onPressed:textProvider.resetText,
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "CE",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(50,50,50,1),
            activeColor: const Color.fromRGBO(60,60,60,1),
            onPressed:textProvider.del,
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "DEL",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          )
        ],
      ),
      Row(
        children: [
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("7"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "7",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("8"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "8",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("9"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "9",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
        ],
      ),
      Row(
        children: [
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("4"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "4",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("5"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "5",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("6"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "6",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
        ],
      ),
      Row(
        children: [
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("1"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "1",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("2"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "2",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("3"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "3",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
        ],
      ),
      Row(
        children: [
          Consumer<DrawerProvider>(
            builder:(context,drawerProv,child)=>
            const ["Power","Temperature","Angle"].contains(title)?
            KeyPadButton(
              color:  const Color.fromRGBO(60,60,60,1),
              activeColor:const Color.fromRGBO(50,50,50,1),
              onPressed: textProvider.plusMinus,
              height:MediaQuery.of(context).size.height/12.5,
              child:const Text(
              "+/−",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
            ):Expanded(
              child:Container()
            )
          ),
           KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("0"),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              "0",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          ),
          KeyPadButton(
            color:  const Color.fromRGBO(60,60,60,1),
            activeColor: const Color.fromRGBO(50,50,50,1),
            onPressed:()=>textProvider.changeText("."),
            height:MediaQuery.of(context).size.height/12.5,
            child:const Text(
              ".",
              style:TextStyle(
                fontSize:20,
                color:Colors.white,
              )
            )
          )
        ],
      ),
    ];
  }
}
