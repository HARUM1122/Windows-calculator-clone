import 'package:flutter/foundation.dart';
import '../../utils/utils.dart';
import '../../eval_ex(modified)/expression.dart';
class StandardCalcProvider extends ChangeNotifier {
  String left = '0';
  String currentOperator = '';
  String expression = '';
  String right = '0';
  String screenText = '0';
  bool calculated = false;
  bool errorOccurred = false;
  bool rightUsed = false;
  String evaluateExpression(String exp) {
    try {
      String ans = trimTrailingZeros(Expression(exp).eval()!.toStringAsFixed(8));
      return ans;
    }
    on ExpressionException catch(e) {
      throwError(e.msg=='Overflow' || e.msg=='Cannot divide by 0'?e.msg:'Invalid input');
      return 'E';
    }
  }
  void throwError(String msg) {
    screenText = msg;
    expression = '';
    errorOccurred = true;
    notify();
  } 
  void reset({bool resetLeft = false, bool resetScreenText = false}) {
    left = resetLeft?'0':left;
    right = '0';
    expression = '';
    currentOperator = '';
    screenText = resetScreenText?'0':screenText;
    calculated = false;
    errorOccurred = false;
    rightUsed = false;
  }
  void addToScreen(String value) {
    if(calculated || errorOccurred) {
      reset(resetLeft: errorOccurred || value != '.',resetScreenText: errorOccurred || value != '.');
    }
    String currentText = currentOperator.isEmpty?left:right;
    if(!rightUsed && currentOperator.isNotEmpty && value == '.'){
      currentText = left;
    }
    if((currentText.contains('.')&&value=='.')||currentText.replaceAll('.','').length==16) {
      return;
    }
    currentText = currentText == '0' && value != '.'?value:currentText+value;
    screenText = addCommas(currentText);
    if(currentOperator.isEmpty) {
      left = currentText;
    }
    else {
      right = currentText;
      rightUsed = true;
    }
    notify();
  }
  void useOperator(String operator,Function add) {
    if(calculated) {
      right = '0';
      rightUsed = false;
      calculated = false;
    }
    if(rightUsed) {
      right = trimTrailingZeros(right);
      final String ans = evaluateExpression(left+currentOperator+right);
      if(ans == 'E') {
        return;
      }
      add("${standardToScientific(trimTrailingZeros(left))} $currentOperator ${standardToScientific(right)}:${addCommas(standardToScientific(ans))}");
      left = ans;
      screenText=addCommas(standardToScientific(ans));
      right = '0';
      rightUsed=false;
    }
    currentOperator = operator;
    left = trimTrailingZeros(left);
    expression = '${standardToScientific(left)} $currentOperator';
    notify();
  }
  void posNeg() {
    if(calculated) {
      reset();
    }
    if(!rightUsed && currentOperator.isNotEmpty) {
      right = left;
      rightUsed = true;
    }
    if(currentOperator.isEmpty) {
      if(left == "0") {
        return;
      }
      left = left.startsWith("-")?left.substring(1,left.length):"-$left";
      screenText=addCommas(left);
    }
    else {
      if(right == "0") {
        return;
      }
      right = right.startsWith("-")?right.substring(1,right.length):"-$right";
      screenText=addCommas(right);
    }
    notify();
  }
  void clearEntry(bool clearAll) {
    if(calculated || clearAll || errorOccurred) {
      reset(resetLeft: true);
    }
    else if(currentOperator.isEmpty) {
      left = "0";
    }
    else {
      right = "0";
    }
    screenText = "0";
    notify();
  }
  void del() {
    if(calculated || errorOccurred) {
      reset(resetLeft: true,resetScreenText: errorOccurred);
    }
    else if(currentOperator.isEmpty) {
      left = left.length<=1?"0":left.substring(0,left.length-1);
      screenText = addCommas(left);
    }
    else {
      if(!rightUsed) {
        right=left;
        rightUsed = true;
      }
      right = right.length<=1?"0":right.substring(0,right.length-1);
      screenText = addCommas(right);
    }
    notify();
  }
  void calc(String exp) {
    final String result = evaluateExpression(exp);
    if(result == "E") {
      return;
    }
    if(currentOperator.isEmpty) {
      left = result;
    }
    else {
      right = result;
    }
    screenText = addCommas(standardToScientific(result));
    notify();
  }

  void eql(Function? add) {
    if(errorOccurred) {
      reset(resetLeft: true,resetScreenText: true);
      notify();
      return;
    }
    if(!rightUsed && currentOperator.isNotEmpty) {
      right=left;
      rightUsed = true;
    }
    else if(currentOperator.isEmpty) {
      right = '';
    }
    left = trimTrailingZeros(left);
    right = trimTrailingZeros(right);
    expression = currentOperator.isEmpty?standardToScientific(left):
    "${standardToScientific(left)} $currentOperator ${standardToScientific(right)}";

    final String ans = evaluateExpression(left+currentOperator+right);
    if(ans=='E') {
      return;
    }
    left = ans;
    screenText = addCommas(standardToScientific(ans));
    if(add!=null) {
      add("$expression:$screenText");
    }
    expression+=' = ';
    calculated = true;
    notify();
  }
  void notify(){
    notifyListeners();
  }
}


