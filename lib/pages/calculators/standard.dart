import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../widgets/memory/memory.dart';
import '../../widgets/keypad/keypad.dart';
import '../../providers/calc/standard.dart';
import '../../widgets/custom_snackbar.dart';

class StandardCalculator extends StatelessWidget {
  const StandardCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromRGBO(32, 32, 32, 1),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Consumer<StandardCalcProvider>(
                            builder: (context, calcProv, _) => Text(
                                calcProv.expression.isEmpty
                                    ? " "
                                    : calcProv.expression,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Consumer<StandardCalcProvider>(
                            builder: (context, calcProv, _) => GestureDetector(
                              onLongPress: () {
                                Clipboard.setData(
                                    ClipboardData(text: calcProv.screenText));
                                showSnackBar_(context);
                              },
                              child: Text(calcProv.screenText,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 80,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                    ])),
            const Spacer(),
            const MemoryPad(),
            for (final Widget row in KeyPad.standardKeypad(context)) row
          ],
        ));
  }
}
