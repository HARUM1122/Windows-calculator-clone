import 'package:flutter/foundation.dart';
import '../../eval_ex(modified)/expression.dart';
import '../../utils/utils.dart';
class ScientificCalcProvider extends ChangeNotifier{
  bool trigSecond=false;
  bool hyperbolic = false;
  bool second=false;
  List<String> currentAngleUnit =['DEG','₀'];
  String screenText = '0';
  String expression = '';
  int parenthesesCount = 0;
  bool opUsed=false;
  bool parenthesisUsed=false;
  bool typed=false;
  bool clearAll = true;
  bool calculated=false;
  bool errorOccurred=false;
  List<int> openingParenthesesStack = [-1];
  bool _isDigit(String s)=> int.tryParse(s)!=null;

  String _getLast(String s)=> s.isEmpty?'':s.substring(s.length-1);
  
  bool _containDigits(String s) {
    for(int i=0;i<s.length;i++){
      if(s[i].codeUnitAt(0)>47&&s[i].codeUnitAt(0)<58){
        return true;
      }
    }
    return false;
  }

  int count(String s){
    int c = 0;
    for(int i=0;i<expression.length;i++){
      if(expression[i]==s){
        c++;
      }
    }
    return c;
  }

  String parseExpression(String exp){
    if(_getLast(exp)!=')'&&!_isDigit(_getLast(exp))){
      final List<String> e = exp.split(' ');
      e.removeLast();
      exp = e.join(' ');
    }
    if(!exp.contains('(')){
      return exp;
    }
    else{
      exp = exp.substring(openingParenthesesStack.last);
      if((count('(')-count(')'))!=0&&_getLast(exp)!=')'){
        exp+=')';
      }
      return exp;
    }
  }
  int _getLastMostOpeningParenthesis(String exp){
    int index = 0;
    for(int i=exp.length-1;i>=0;i--){
      if(exp[i]=='('){
        index=i;
        break;
      }
    }
    return index;
  }
  void throwError({String msg = 'Invalid input'}){
    screenText = msg;
    expression = '';
    clearAll = true;
    errorOccurred=true;
    notify();
  }
  String evaluateExpression(String exp, {bool ignoreErrors = false}){
    const Map<String,String> textToReplaceWith = {
      '⁻¹':'_',
      '/':'÷',
      'e+':'e',
      '₀':'D',
      'ᵣ':'R',
      '₉':'G',
    };
    for(final String text in textToReplaceWith.keys){
      exp = exp.replaceAll(text,textToReplaceWith[text]!);
    }
    try{
      String ans = trimTrailingZeros(Expression(exp).eval()!.toStringAsFixed(12));
      return ans;
    }
    on ExpressionException catch(e){
      throwError(msg:e.msg=='Overflow' || e.msg=='Cannot divide by 0'?e.msg:'Invalid input');
      return 'E';
    }
  }                                                                                      
  void changeBool(int op){
    switch(op){
      case 0:
        trigSecond=!trigSecond;
      case 1:
        hyperbolic=!hyperbolic;
      case 2:
        second=!second;
    }
    notify();
  }
  void changeAngleUnit(){
    switch(currentAngleUnit.first){
      case 'DEG':
        currentAngleUnit = ['RAD','ᵣ'];
      case 'RAD':
        currentAngleUnit = ['GRAD','₉'];
      default:
        currentAngleUnit = ['DEG','₀'];
    }
    notify();
  }
  void addToScreen(String value){
    if(calculated || errorOccurred) {
      clear(reset:true,sc: errorOccurred || value != '.');
    }
    typed=true;
    clearAll=false;
    if(opUsed||parenthesisUsed){
      parenthesisUsed=false;
      opUsed=false;
      screenText=value=='.'?'0':'';
    }
    if(screenText.contains('e')){
      if((screenText.contains('e+')&&screenText.split('e+').last.length>=2)||(screenText.contains('e-')&&screenText.split('e-').last.length>=2)){
        return;
      }
      if(screenText.endsWith('0')){
        screenText = screenText.substring(0,screenText.length-1);
      }
      screenText+=value;
      notify();
      return;
    }
    if((screenText.contains('.')&&value=='.')||screenText.replaceAll('.','').replaceAll(',','').length==20){
      return;
    }
    
    screenText = screenText == '0' && value != '.'?value:screenText+value;
    screenText = addCommas(screenText);
    notify();
  }

  void replaceScreenTextWith(String value){
    if(calculated){
      clear(reset:true,sc: true);
    }
    typed = true;
    clearAll=false;
    screenText = value;
    notify();
  }

  void posNeg(){
    if(calculated){
      clear(reset:true,sc: true);
    }
    if(screenText=="0"){
      return;
    }
    if(screenText.contains('e')){
      if(screenText.contains('e+')){
        screenText = screenText.replaceAll('+','-');
      }
      else{
        screenText = screenText.replaceAll('-','+');
      }
    }
    else{
      screenText = screenText.startsWith('-')?screenText.substring(1):'-$screenText';
    }
    
    notify();
  }

  void useExp(){
    if(screenText.contains('e') || screenText=='0' || opUsed||parenthesisUsed){
      return;
    }
    if(screenText.startsWith('-')){
      screenText = screenText.substring(1);
      screenText+='e-0';
    }
    else{
      screenText+='e+0';
    }
    notify();
  }
  void del(){
    screenText = screenText.replaceAll(',','');
    if(calculated || errorOccurred){
      clear(reset:true,sc: errorOccurred);
    }
    else if(screenText.endsWith('e+0')||screenText.endsWith('e-0')){
      screenText = screenText.substring(0,screenText.length-3);
    }
    else if(screenText.length>1){
      screenText = screenText.substring(0,screenText.length-1);
    }
    else{
      screenText = '0';
    }
    if(screenText.endsWith('e+')||screenText.endsWith('e-')){
      screenText+='0';
    }
    screenText = addCommas(screenText);
    notify();
  }
  void useParenthesis(String parenthesis){
    if(calculated){
      clear(reset:true,sc: false);
    }
    screenText = trimTrailingZeros(screenText);
    final String sc = standardToScientific(screenText,pos:1e20,neg:-1e20);
    parenthesisUsed=true;
    if(parenthesis=="("&&parenthesesCount!=25){
      if(_isDigit(_getLast(expression))||expression.endsWith(")")) {
        expression+=" × $parenthesis";
      }
      else if(typed){
        expression+="${expression.isEmpty?'':' '}$sc × $parenthesis";
      }
      else {
        expression+="${expression.endsWith('(')||expression.isEmpty?'':' '}$parenthesis";
      }
      final int lastOpeningParenthesis = _getLastMostOpeningParenthesis(expression);
      openingParenthesesStack.removeLast();
      openingParenthesesStack.add(lastOpeningParenthesis);
      openingParenthesesStack.add(lastOpeningParenthesis);
      parenthesesCount++;
      typed=false;
      opUsed=false;
      screenText = addCommas(screenText);
    }
    else if(parenthesis==")"&&parenthesesCount!=0){
      if(!_isDigit(_getLast(expression)) &&!expression.endsWith(")")){
        expression+="${expression.endsWith('(')?'':' '}$sc";
      }
      openingParenthesesStack.removeLast();
      expression+=parenthesis;
      parenthesesCount--;
      typed=false;
      opUsed=false;
      final String ans = evaluateExpression(parseExpression(expression));
      if(ans=="E"){
        return;
      }
      screenText = addCommas(standardToScientific(ans,pos:1e20,neg:-1e20));
    }
    notify();
  }

  void useOperator(String op){
    if(calculated){
      clear(reset:true,sc: false);
    }
    screenText = trimTrailingZeros(screenText);
    final String sc = standardToScientific(screenText,pos:1e20,neg:-1e20);
    typed=false;
    if(!opUsed){
      opUsed=true;
      if(expression.endsWith(")")){
        expression+=" $op";
      }
      else{
        expression+="${expression.endsWith('(')||expression.isEmpty?'':' '}$sc $op";
      }
      final String ans = evaluateExpression(parseExpression(expression));
      if(ans=="E"){
        return;
      }
      screenText = addCommas(standardToScientific(ans,pos:1e20,neg:-1e20));
    }
    else{
      final List<String>exp = expression.split(' ');
      exp.last = op;
      expression = exp.join(' ');
      screenText = addCommas(screenText);
    }
    notify();
  }

  void useFunc(String func){
    if(calculated){
      clear(reset:true,sc: false);
    }
    screenText = trimTrailingZeros(screenText);
    final String sc = standardToScientific(screenText,pos:1e20,neg:-1e20);
    if(expression.endsWith(")")){
      expression+=" × $func";
    }
    else if(typed){
      expression+="${expression.isEmpty?'':' '}$sc × $func";
    }
    else{
      expression+="${expression.endsWith('(')||expression.isEmpty?'':' '}$func";
    }
    final int lastOpeningParenthesis = _getLastMostOpeningParenthesis(expression);
    openingParenthesesStack.removeLast();
    openingParenthesesStack.add(lastOpeningParenthesis);
    openingParenthesesStack.add(lastOpeningParenthesis);
    parenthesesCount++;
    parenthesisUsed=true;
    typed=false;
    opUsed=false;
    screenText = addCommas(screenText);
    notify();
  }

  void clear({bool reset=false,bool sc=true}){
    if(clearAll||reset||calculated){
      expression = '';
      parenthesesCount = 0;
      opUsed=false;
      parenthesisUsed=false;
      calculated=false;
      errorOccurred=false;
    }
    openingParenthesesStack=[-1];
    screenText = sc?'0':screenText;
    typed=false;
    clearAll=true;
    notify();
  }

  void eql(Function? add){
    if(errorOccurred){
      clear(sc: errorOccurred);
      return;
    }
    screenText = standardToScientific(trimTrailingZeros(screenText),pos:1e20,neg:-1e20);
    if(calculated){
      final List<String> exp = expression.split(' ');
      exp.first = screenText;
      exp.removeLast();
      expression = exp.join(' ');
    }
    else{
      if((typed||opUsed||!_containDigits(expression))&&parenthesesCount==0){
        if(expression.endsWith(")")){
          expression+=' × $screenText';
        }
        else{
          expression = ("$expression $screenText").trim();
        }
      }
      else if(parenthesesCount!=0){
        if(!expression.endsWith(')')){
          expression+="${expression.endsWith('(')?'':' '}$screenText";
        }
      }
      expression+=")"*parenthesesCount;
      parenthesesCount=0;
    }
    
    final String ans = evaluateExpression(expression);
    if(ans=="E"){
      return;
    }
    screenText = addCommas(standardToScientific(ans,pos:1e20,neg:-1e20));
    if(add!=null){
      add('$expression:$screenText',standard:false);
    }
    calculated=true;
    expression+=' =';
    notify();
  }
  void notify(){
    notifyListeners();
  }
}