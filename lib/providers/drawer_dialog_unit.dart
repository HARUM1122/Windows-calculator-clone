import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';
import '../utils/utils.dart';
const Map<int,List> categories={
  0:['Standard'],
  1:['Scientific'],
  2:['Date calculation'],
  3:["Volume",VOLUME.values],
  4:["Length",LENGTH.values],
  5:["Pressure",PRESSURE.values],
  6:["Data",DIGITAL_DATA.values],
  7:["Speed",SPEED.values],
  8:["Mass",MASS.values],
  9:["Time",TIME.values],
  10:["Energy",ENERGY.values],
  11:["Area",AREA.values],
  12:["Temperature",TEMPERATURE.values],
  13:["Power",POWER.values],
  14:["Angle",ANGLE.values],
};
int selectedCategory=0;
String title = categories[selectedCategory]![0];
int selectedUnitIndex = 0;
int selectedUnitIndex2= 1;
int selectedTextIndex=0;
String firstText = "0";
String secondText = "0";
bool selectedTextChanged = false;
List<Enum> unitList = categories[3]![1];

String _convert(String n,List<Enum> units,int from,int to) {
  n = n.replaceAll(",","");
  num convertedValue = num.parse(n).convertFromTo(units[from], units[to])!;
  return addCommas(standardToScientific(trimTrailingZeros(convertedValue.toString())));
}

class DrawerProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  void changeCategory(int index) {
    if(index<3) {
      pageController.jumpToPage(index);
    }
    else{
      unitList = categories[index]![1];
      if(pageController.page!=3) {
        pageController.jumpToPage(3);
      }
    }
    selectedCategory=index;
    title = categories[index]![0];
    notifyListeners();
  }
}

class DialogProvider extends ChangeNotifier{
  void changeUnit(int index,{bool second=false}) {
    if(!second && index!=selectedUnitIndex2) {
      selectedUnitIndex=index;
    }
    else if(index!=selectedUnitIndex) {
      selectedUnitIndex2=index; 
    }
    if(selectedTextIndex==0) {
      secondText = _convert(firstText,unitList,selectedUnitIndex,selectedUnitIndex2);
    }
    else {
      firstText = _convert(secondText,unitList,selectedUnitIndex2,selectedUnitIndex);
    }

    notifyListeners();
  }
  void resetUnitIndices() {
    selectedUnitIndex=0;
    selectedUnitIndex2= 1;
    notifyListeners();
  }

}

class UnitProvider extends ChangeNotifier {
  void plusMinus(){
    if(selectedTextChanged) {
      resetText();
      selectedTextChanged=false;
    }
    String currentText = selectedTextIndex==0?firstText:secondText;
    String otherText = selectedTextIndex==1?firstText:secondText;
    if(currentText=="0") {
      return;
    }
    currentText = currentText.startsWith("-")?currentText.substring(1):"-$currentText";
    otherText = _convert(
      currentText,
      unitList,
      selectedTextIndex==0?selectedUnitIndex:selectedUnitIndex2,
      selectedTextIndex==0?selectedUnitIndex2:selectedUnitIndex
    );
    firstText = selectedTextIndex==0?currentText:otherText;
    secondText = selectedTextIndex==1?currentText:otherText;
    notify();
  }
  void changeText(String value) {
    if(selectedTextChanged) {
      resetText();
      selectedTextChanged=false;
    }
    String currentText = selectedTextIndex==0?firstText:secondText;
    String otherText = selectedTextIndex==1?firstText:secondText;
    currentText = currentText.replaceAll(",", "");
    if((currentText.contains('.')&&value=='.')||currentText.replaceAll('.','').length==16) {
      return;
    }
    currentText = currentText == '0' && value != '.'?value:currentText+value;
    currentText = addCommas(currentText);
    if(!currentText.endsWith(".")) {
      otherText = _convert(
        currentText,
        unitList,
        selectedTextIndex==0?selectedUnitIndex:selectedUnitIndex2,
        selectedTextIndex==0?selectedUnitIndex2:selectedUnitIndex
      );
    }
    firstText = selectedTextIndex==0?currentText:otherText;
    secondText = selectedTextIndex==1?currentText:otherText;
    notify();
  }

  void del(){
    if(selectedTextChanged) {
      resetText();
      selectedTextChanged=false;
    }
    String currentText = selectedTextIndex==0?firstText:secondText;
    String otherText = selectedTextIndex==1?firstText:secondText;
    currentText = currentText.replaceAll(",", "");
    currentText = currentText.length==1 || (currentText.startsWith("-")&&currentText.length==2)?"0":addCommas(currentText.substring(0,currentText.length-1));
    if(!currentText.endsWith(".")) {
      otherText = _convert(
        currentText,
        unitList,
        selectedTextIndex==0?selectedUnitIndex:selectedUnitIndex2,
        selectedTextIndex==0?selectedUnitIndex2:selectedUnitIndex
      );
    }
    firstText = selectedTextIndex==0?currentText:otherText;
    secondText = selectedTextIndex==1?currentText:otherText; 
    notify();
  }
  void resetText() {
    firstText = "0";
    secondText = "0";
    if(selectedTextIndex==0) {
      secondText = _convert(firstText,unitList,selectedUnitIndex,selectedUnitIndex2);
    }
    else {
      firstText = _convert(secondText,unitList,selectedUnitIndex2,selectedUnitIndex);
    }
    notify();
  }
  void changeIndex(int index) {
    if(index!=selectedTextIndex) {
      selectedTextChanged=true;
      selectedTextIndex=index;
      notify();
    }
  }
  void notify(){
    notifyListeners();
  }
}
