import 'package:flutter/foundation.dart';
import '../calc/scientific.dart';
import '../../utils/utils.dart';
class ScientificMemoryProvider extends ChangeNotifier{
  final List<num> memory = [];
  void addToMemory(num number){
    memory.insert(0,number);
    notifyListeners();
  }
  void updateMemory(int index,ScientificCalcProvider sp,bool increment){
    if(sp.calculated){
      sp.clear(reset:true,sc:false);
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
  void recallMemory(int index,ScientificCalcProvider sp){
    if(sp.calculated){
      sp.clear(reset: true);
    }
    sp
    ..screenText = addCommas(standardToScientific(memory[index].toString(),pos:1e20,neg:-1e20))
    ..typed=true
    ..clearAll=false
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