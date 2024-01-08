import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/calc/date_calc.dart';
import 'package:intl/intl.dart';

class DateDifference extends StatelessWidget {
  const DateDifference({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Consumer<DateCalcProvider>(
        builder: (context, dateProv, _) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("From",
                style: TextStyle(
                    color: Color.fromARGB(255, 176, 176, 176), fontSize: 14)),
            TextButton(
                style: const ButtonStyle(
                  overlayColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                ),
                onPressed: () => dateProv.setDate(context, true),
                child: Row(
                  children: [
                    Text(DateFormat("MMMM d, y").format(dateProv.from),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(width: 10),
                    const Icon(Icons.calendar_month_outlined,
                        color: Colors.white)
                  ],
                )),
            const SizedBox(height: 30),
            const Text("To",
                style: TextStyle(
                    color: Color.fromARGB(255, 176, 176, 176), fontSize: 14)),
            TextButton(
                style: const ButtonStyle(
                  overlayColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                ),
                onPressed: () => dateProv.setDate(context, false),
                child: Row(
                  children: [
                    Text(DateFormat("MMMM d, y").format(dateProv.to),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(width: 10),
                    const Icon(Icons.calendar_month_outlined,
                        color: Colors.white)
                  ],
                )),
            const SizedBox(height: 30),
            const Text("Difference",
                style: TextStyle(
                    color: Color.fromARGB(255, 176, 176, 176), fontSize: 14)),
            const SizedBox(height: 10),
            Text(dateProv.difference,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 10),
            Text(
                dateProv.differenceInDays.isNotEmpty
                    ? "${dateProv.differenceInDays} ${dateProv.differenceInDays != "1" ? 'days' : 'day'}"
                    : '',
                style: const TextStyle(
                    color: Color.fromARGB(255, 176, 176, 176), fontSize: 14))
          ],
        ),
      ),
    );
  }
}
