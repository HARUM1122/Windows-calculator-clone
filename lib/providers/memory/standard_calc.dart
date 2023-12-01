import 'package:flutter/foundation.dart';
import '../calc/standard.dart';
import '../../utils/utils.dart';
class StandardMemoryProvider extends ChangeNotifier{
  final List<num> memory = [];
  void addToMemory(num number){
    memory.insert(0, number);
    notifyListeners();
  }
  void updateMemory(int index,StandardCalcProvider sp,bool increment){
    if(sp.calculated){
      sp.reset();
    }
    final num number = num.parse(sp.screenText.replaceAll(',', ''));
    if(memory.isEmpty){
      memory.add(number);
    }
    else{
      memory[index] = increment?memory[index]+number:memory[index]-number;
    }
    notifyListeners();
  }
  void recallMemory(int index,StandardCalcProvider sp){
    if(sp.calculated){
      sp
      ..reset(resetLeft: true)
      ..left = memory[index].toString();
    }
    else if(sp.currentOperator.isEmpty){
      sp.left = memory[index].toString();
    }
    else{
      sp
      ..right = memory[index].toString()
      ..rightUsed=true;
    }
    sp
    ..screenText = addCommas(standardToScientific((memory[index].toString())))
    ..notify();
  }
  void removeMemory(int index){
    memory.removeAt(index);
    notifyListeners();
  }
  void clearMemory(){
    memory.clear();
    notifyListeners();
  }
}