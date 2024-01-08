import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../keypad/keypad_button.dart';
import '../../../providers/calc/scientific.dart';

class TrigonometryDialog extends StatefulWidget {
  const TrigonometryDialog({super.key});

  @override
  State<TrigonometryDialog> createState() => _TrigonometryDialogState();
}

class _TrigonometryDialogState extends State<TrigonometryDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(45, 45, 45, 1),
            borderRadius: BorderRadius.circular(4)),
        height: 140,
        child: Consumer<ScientificCalcProvider>(
          builder: (context, scientificProv, _) => Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    KeyPadButton(
                        color: scientificProv.trigSecond
                            ? const Color.fromRGBO(118, 185, 237, 1)
                            : const Color.fromRGBO(60, 60, 60, 1),
                        onPressed: () => scientificProv.changeBool(0),
                        child: Text("INV",
                            style: TextStyle(
                              fontSize: 18,
                              color: scientificProv.trigSecond
                                  ? Colors.black
                                  : Colors.white,
                            ))),
                    KeyPadButton(
                        color: scientificProv.hyperbolic
                            ? const Color.fromRGBO(118, 185, 237, 1)
                            : const Color.fromRGBO(60, 60, 60, 1),
                        onPressed: () => scientificProv.changeBool(1),
                        child: Text("hyp",
                            style: TextStyle(
                              fontSize: 20,
                              color: scientificProv.hyperbolic
                                  ? Colors.black
                                  : Colors.white,
                            ))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    KeyPadButton(
                        color: const Color.fromRGBO(60, 60, 60, 1),
                        activeColor: const Color.fromRGBO(70, 70, 70, 1),
                        onPressed: () {
                          String function = "";
                          if (scientificProv.hyperbolic) {
                            function =
                                'sinh${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          } else {
                            function =
                                'sin${scientificProv.currentAngleUnit.last}${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          }
                          scientificProv.useFunc(function);
                          Navigator.pop(context);
                        },
                        child: Text(
                            "sin${scientificProv.hyperbolic ? 'h' : ''}${scientificProv.trigSecond ? '⁻¹' : ''}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                    KeyPadButton(
                        color: const Color.fromRGBO(60, 60, 60, 1),
                        activeColor: const Color.fromRGBO(70, 70, 70, 1),
                        onPressed: () {
                          String function = "";
                          if (scientificProv.hyperbolic) {
                            function =
                                'sech${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          } else {
                            function =
                                'sec${scientificProv.currentAngleUnit.last}${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          }
                          scientificProv.useFunc(function);
                          Navigator.pop(context);
                        },
                        child: Text(
                            "sec${scientificProv.hyperbolic ? 'h' : ''}${scientificProv.trigSecond ? '⁻¹' : ''}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    KeyPadButton(
                        color: const Color.fromRGBO(60, 60, 60, 1),
                        activeColor: const Color.fromRGBO(70, 70, 70, 1),
                        onPressed: () {
                          String function = "";
                          if (scientificProv.hyperbolic) {
                            function =
                                'cosh${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          } else {
                            function =
                                'cos${scientificProv.currentAngleUnit.last}${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          }
                          scientificProv.useFunc(function);
                          Navigator.pop(context);
                        },
                        child: Text(
                            "cos${scientificProv.hyperbolic ? 'h' : ''}${scientificProv.trigSecond ? '⁻¹' : ''}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                    KeyPadButton(
                        color: const Color.fromRGBO(60, 60, 60, 1),
                        activeColor: const Color.fromRGBO(70, 70, 70, 1),
                        onPressed: () {
                          String function = "";
                          if (scientificProv.hyperbolic) {
                            function =
                                'csch${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          } else {
                            function =
                                'csc${scientificProv.currentAngleUnit.last}${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          }
                          scientificProv.useFunc(function);
                          Navigator.pop(context);
                        },
                        child: Text(
                            "csc${scientificProv.hyperbolic ? 'h' : ''}${scientificProv.trigSecond ? '⁻¹' : ''}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    KeyPadButton(
                        color: const Color.fromRGBO(60, 60, 60, 1),
                        activeColor: const Color.fromRGBO(70, 70, 70, 1),
                        onPressed: () {
                          String function = "";
                          if (scientificProv.hyperbolic) {
                            function =
                                'tanh${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          } else {
                            function =
                                'tan${scientificProv.currentAngleUnit.last}${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          }
                          scientificProv.useFunc(function);
                          Navigator.pop(context);
                        },
                        child: Text(
                            "tan${scientificProv.hyperbolic ? 'h' : ''}${scientificProv.trigSecond ? '⁻¹' : ''}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                    KeyPadButton(
                        color: const Color.fromRGBO(60, 60, 60, 1),
                        activeColor: const Color.fromRGBO(70, 70, 70, 1),
                        onPressed: () {
                          String function = "";
                          if (scientificProv.hyperbolic) {
                            function =
                                'coth${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          } else {
                            function =
                                'cot${scientificProv.currentAngleUnit.last}${scientificProv.trigSecond ? '⁻¹' : ''}(';
                          }
                          scientificProv.useFunc(function);
                          Navigator.pop(context);
                        },
                        child: Text(
                            "cot${scientificProv.hyperbolic ? 'h' : ''}${scientificProv.trigSecond ? '⁻¹' : ''}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

// 60 active:70⁻¹
