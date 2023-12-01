import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../memory_button.dart';
import '../scientific/memory_list.dart';
import '../../../utils/utils.dart';
import '../../../providers/calc/scientific.dart';
import '../../../providers/memory/memory.dart';
import '../../bottom_sheet.dart';
class ScientificMemoryPad extends StatelessWidget {
  const ScientificMemoryPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ScientificCalcProvider,ScientificMemoryProvider>(
      builder:(context,scientificProv,memoryProv,_)=>Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          MemoryButton(
            text:"MC",
            onPressed:memoryProv.clearMemory,
            disable: scientificProv.errorOccurred||memoryProv.memory.isEmpty,
          ),
          MemoryButton(
            text:"MR",
            onPressed: (){
              memoryProv.recallMemory(0, scientificProv);
            },
            disable: scientificProv.errorOccurred||memoryProv.memory.isEmpty,
          ),
          MemoryButton(
            text:"M+",
            onPressed: (){
              memoryProv.updateMemory(0, scientificProv,true);
            },
            disable: scientificProv.errorOccurred,
          ),
          MemoryButton(
            text:"M-",
            onPressed: (){
              memoryProv.updateMemory(0, scientificProv,false);
            },
            disable: scientificProv.errorOccurred,
          ),
          MemoryButton(
            text:"MS",
            onPressed: (){
              memoryProv.addToMemory(num.parse(trimTrailingZeros(scientificProv.screenText)));
            },
            disable: scientificProv.errorOccurred,
          ),
          MemoryButton(
            text:"M",
            onPressed: (){
              showSheet(
                context,
                const MemoryList()
              );
            },
            disable: scientificProv.errorOccurred||memoryProv.memory.isEmpty,
          ),
        ]  
      ),
    );
  }
}