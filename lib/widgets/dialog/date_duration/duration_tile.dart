import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/calc/date_calc.dart';

class DurationTile extends StatelessWidget {
  final int option;
  final int duration;
  const DurationTile({required this.option, required this.duration, super.key});
  @override
  Widget build(BuildContext context) {
    final DateCalcProvider datecalcProv =
        Provider.of<DateCalcProvider>(context, listen: false);
    bool selected = false;
    switch (option) {
      case 0:
        selected = datecalcProv.selectedYear == duration;
      case 1:
        selected = datecalcProv.selectedMonth == duration;
      case 2:
        selected = datecalcProv.selectedDay == duration;
    }
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
      decoration: BoxDecoration(
          color: selected
              ? const Color.fromRGBO(56, 56, 56, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8)),
      height: 40,
      child: TextButton(
          onPressed: () {
            datecalcProv.changeDuration(option, duration);
            Navigator.pop(context);
          },
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero),
              overlayColor:
                  MaterialStatePropertyAll<Color>(Colors.transparent)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 15,
                  width: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selected
                          ? const Color.fromRGBO(118, 185, 237, 1)
                          : Colors.transparent)),
              const SizedBox(width: 6),
              Text(duration.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 18))
            ],
          )),
    );
  }
}
