String addCommas(String number){
  if(number.contains('e')) {
    return number;
  }
  if(number.contains(',')){
    number = number.replaceAll(',','');
  }
  bool isNegative = number.startsWith("-");
  if(number.startsWith('-')){
    number = number.substring(1);
  }
  int count=0;
  String res = "";
  final List<String> n = number.split('.');
  for(int i=n[0].length-1;i>=0;i--){
    res=n[0][i]+res;
    count++;
    if(count%3==0&& i!=0){
      res = ',$res';
    }
  }
  res = isNegative?"-$res":res;
  return n.length==2?"$res.${n[1]}":res;
}


String trimTrailingZeros(String number) {
  if(number.contains(',')){
    number = number.replaceAll(',', '');
  }
  if((!number.contains('.') || number.isEmpty) && !number.contains('e')) {
    return number;
  }
  final String n = num.parse(number).toString();
  return n.endsWith('.0')?n.substring(0,n.length-2):n;              
}

String standardToScientific(String number,{num pos = 1e16, num neg = -1e16}){
  if(number.isEmpty || number.contains('e')){
    return number;
  }
  if(number.contains(',')){
    number = number.replaceAll(',', '');
  }
  final num n = num.parse(number);
  if(pos == 0 && neg == 0){
    return n.toStringAsExponential(6);
  }
  if(n.toDouble()>pos||n.toDouble()<neg){
    return n.toStringAsExponential(6);
  }
  return number;
  
}
