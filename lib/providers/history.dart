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
      scientificHistory.removeAt(index);
    }
    notifyListeners();
  }
  void clearHistory({bool standard=true}){
    if(standard && standardHistory.isNotEmpty){
      standardHistory.clear();
    }
    else if(!standard&&scientificHistory.isNotEmpty){
      scientificHistory.clear();
    }
    notifyListeners();
  }
}