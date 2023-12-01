import 'package:flutter/foundation.dart';

class HistoryProvider extends ChangeNotifier{
  final List<String> standardHistory = []; // expression:answer
  final List<String> scientificHistory = []; // expression:answer
  void addToHistory(String ans,{bool standard=true}){
    if(standard){
      standardHistory.insert(0,ans);
    }
    else{
      scientificHistory.insert(0,ans);
    }
    notifyListeners();
  }
  void removeFromHistory(int index,{bool standard=true}){
    if(standard){
      standardHistory.removeAt(index);
    }
    else{
      standardHistory.removeAt(index);
    }
    notifyListeners();
  }
  void clearHistory({bool standard=true}){
    if(standard){
      if(standardHistory.isEmpty){
        return;
      }
      standardHistory.clear();
    }
    else{
      if(scientificHistory.isEmpty){
        return;
      }
      scientificHistory.clear();
    }
    notifyListeners();
  }
}