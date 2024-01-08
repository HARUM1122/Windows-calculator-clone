import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawer_dialog_unit.dart';
import 'package:flutter/services.dart';
import '../widgets/dialog/dialog.dart';
import '../widgets/keypad/keypad.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UnitProvider textProvider =
        Provider.of<UnitProvider>(context, listen: false);
    return Material(
        color: const Color.fromRGBO(32, 32, 32, 1),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => textProvider.changeIndex(0),
                    onLongPress: () =>
                        Clipboard.setData(ClipboardData(text: firstText)),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Consumer<UnitProvider>(
                          builder: (context, textProv, child) => Text(firstText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: selectedTextIndex == 0
                                      ? FontWeight.w500
                                      : FontWeight.w300))),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () => showD(
                            context,
                            const UnitDialog(
                              isSecond: false,
                            )),
                        style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent)),
                        child: Consumer<DialogProvider>(
                            builder: (context, dialogProvider, child) => Text(
                                unitList[selectedUnitIndex].name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)))),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white)
                  ],
                ),
                GestureDetector(
                    onTap: () => textProvider.changeIndex(1),
                    onLongPress: () =>
                        Clipboard.setData(ClipboardData(text: secondText)),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Consumer<UnitProvider>(
                          builder: (context, textProv, child) => Text(
                              secondText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: selectedTextIndex == 1
                                      ? FontWeight.w500
                                      : FontWeight.w300))),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () => showD(
                            context,
                            const UnitDialog(
                              isSecond: true,
                            )),
                        style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent)),
                        child: Consumer<DialogProvider>(
                            builder: (context, dialogProvider, child) => Text(
                                unitList[selectedUnitIndex2].name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)))),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white)
                  ],
                ),
              ],
            ),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (final Widget widget in KeyPad.unitKeypad(context)) widget
            ],
          ))
        ]));
  }
}
