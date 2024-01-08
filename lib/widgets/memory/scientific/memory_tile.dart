import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../../providers/memory/scientific_calc.dart';
import '../../../providers/calc/scientific.dart';
import '../../../utils/utils.dart';
import '../../custom_snackbar.dart';

class MemoryTile extends StatelessWidget {
  final num value;
  final int index;
  const MemoryTile({required this.value, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final ScientificMemoryProvider memoryProv =
        Provider.of<ScientificMemoryProvider>(context, listen: false);
    final ScientificCalcProvider scientificCalcProv =
        Provider.of<ScientificCalcProvider>(context, listen: false);
    final String val = addCommas(
        standardToScientific(value.toString(), pos: 1e20, neg: -1e20));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      child: TextButton(
          onPressed: () {
            memoryProv.recallMemory(index, scientificCalcProv);
            Navigator.pop(context);
          },
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: val));
            Navigator.pop(context);
            showSnackBar_(context);
          },
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            overlayColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      val,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(45, 45, 45, 1)),
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () => memoryProv.updateMemory(
                          index, scientificCalcProv, true),
                      child: const Text("M+"),
                    ),
                    const SizedBox(width: 4),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(45, 45, 45, 1)),
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent)),
                      onPressed: () => memoryProv.updateMemory(
                          index, scientificCalcProv, false),
                      child: const Text("M-"),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
