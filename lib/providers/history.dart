import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  List<String> standardHistory = []; // expression:answer
  List<String> scientificHistory = []; // expression:answer
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  HistoryProvider() {
    _prefs.then((SharedPreferences prefs) {
      standardHistory = prefs.getStringList('standardCalcHistory') ?? [];
      scientificHistory = prefs.getStringList('scientificCalcHistory') ?? [];
    });
  }
  void addToHistory(String ans, {bool standard = true}) {
    if (standard) {
      if (standardHistory.length == 100) {
        standardHistory.removeLast();
      }
      standardHistory.insert(0, ans);
    } else {
      if (scientificHistory.length == 100) {
        scientificHistory.removeLast();
      }
      scientificHistory.insert(0, ans);
    }
    saveHistory(standard: standard);
  }

  void removeFromHistory(int index, {bool standard = true}) {
    if (standard) {
      standardHistory.removeAt(index);
    } else {
      scientificHistory.removeAt(index);
    }
    saveHistory(standard: standard);
  }

  void clearHistory({bool standard = true}) {
    if (standard && standardHistory.isNotEmpty) {
      standardHistory.clear();
    } else if (!standard && scientificHistory.isNotEmpty) {
      scientificHistory.clear();
    }
    saveHistory(standard: standard);
  }

  void saveHistory({bool standard = true}) async {
    final SharedPreferences prefs = await _prefs;
    if (standard) {
      prefs.setStringList('standardCalcHistory', standardHistory);
    } else {
      prefs.setStringList('scientificCalcHistory', scientificHistory);
    }
    notifyListeners();
  }
}
