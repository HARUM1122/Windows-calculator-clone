import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../memory_button.dart';
import 'memory_list.dart';
import '../../../utils/utils.dart';
import '../../../providers/memory/standard_calc.dart';
import '../../../providers/calc/standard.dart';
import '../../bottom_sheet.dart';

class MemoryPad extends StatelessWidget {
  const MemoryPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<StandardCalcProvider, StandardMemoryProvider>(
      builder: (context, standardProv, memoryProv, _) =>
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        MemoryButton(
            text: "MC",
            onPressed: memoryProv.clearMemory,
            disable: memoryProv.memory.isEmpty || standardProv.errorOccurred),
        MemoryButton(
            text: "MR",
            onPressed: () {
              if (standardProv.calculated) {
                standardProv
                  ..reset(resetLeft: true, resetScreenText: true)
                  ..left = memoryProv.memory[0].toString();
              } else if (standardProv.currentOperator.isEmpty) {
                standardProv.left = memoryProv.memory[0].toString();
              } else {
                standardProv
                  ..right = memoryProv.memory[0].toString()
                  ..rightUsed = true;
              }
              standardProv
                ..screenText = addCommas(
                    standardToScientific(memoryProv.memory[0].toString()))
                ..notify();
            },
            disable: memoryProv.memory.isEmpty || standardProv.errorOccurred),
        MemoryButton(
            text: "M+",
            onPressed: () => memoryProv.updateMemory(0, standardProv, true),
            disable: standardProv.errorOccurred),
        MemoryButton(
            text: "M-",
            onPressed: () => memoryProv.updateMemory(0, standardProv, false),
            disable: standardProv.errorOccurred),
        MemoryButton(
            text: "MS",
            onPressed: () {
              if (standardProv.calculated) {
                standardProv.reset();
              }
              if (!standardProv.rightUsed &&
                  standardProv.currentOperator.isNotEmpty) {
                standardProv.right = standardProv.left;
              }
              memoryProv.addToMemory(
                  num.parse(trimTrailingZeros(standardProv.screenText)));
            },
            disable: standardProv.errorOccurred),
        MemoryButton(
            text: "M",
            onPressed: () {
              showSheet(context, const MemoryList());
            },
            disable: memoryProv.memory.isEmpty || standardProv.errorOccurred),
      ]),
    );
  }
}
