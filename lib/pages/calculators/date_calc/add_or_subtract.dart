import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '/providers/calc/date_calc.dart';
import '/widgets/dialog/date_duration/date_duration.dart';
import '/widgets/dialog/dialog.dart';
import '/widgets/custom_radio_button.dart';

class AddOrSubtract extends StatelessWidget {
  const AddOrSubtract({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right:20,top: 40),
      child: Consumer<DateCalcProvider>(
        builder:(context,dateProv,_)=>Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "From",
              style:TextStyle(
                color:Color.fromARGB(255, 176, 176, 176),
                fontSize:14
              )
            ),
            const SizedBox(height:10),
            TextButton(
              style:const ButtonStyle(
                overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
              ),
              onPressed: ()=>dateProv.setDate(context, true),
              child:Row(
                children: [
                  Text(
                    DateFormat("MMMM d, y").format(dateProv.from),
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:18
                    )
                  ),
                  const SizedBox(width:10),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color:Colors.white
                  )
                ],
              )
            ),
            const SizedBox(height:20),
            Row(
              children: [
                CustomRadio(title: "Add", 
                pressed: (){
                  dateProv
                  ..add=true
                  ..addOrSubtract()
                  ..notify();
                },
                selected: dateProv.add),
                const SizedBox(width:50),
                CustomRadio(title: "Subtract",
                pressed: (){
                  dateProv
                  ..add=false
                  ..addOrSubtract()
                  ..notify();
                }, 
                selected: !dateProv.add),
              ],
            ),
            const SizedBox(height:40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SelectDurationButton(
                  dateProv: dateProv,
                  option:0
                ),
                const SizedBox(width:10),
                SelectDurationButton(
                  dateProv: dateProv,
                  option:1
                ),
                const SizedBox(width:10),
                SelectDurationButton(
                  dateProv: dateProv,
                  option:2
                )
              ],
            ),
            const SizedBox(height:40),
            const Text(
              "Date",
              style:TextStyle(
                color:Color.fromARGB(255, 176, 176, 176),
                fontSize:14
              )
            ),
            const SizedBox(height:10),
            Text(
              DateFormat("EEEE, MMMM d, y").format(dateProv.date??dateProv.from),
                style:const TextStyle(
                  color:Colors.white,
                  fontSize:18
              )
            ),
          ],
        ),
      ),
    );
  }
}

class SelectDurationButton extends StatelessWidget {
  final DateCalcProvider dateProv;
  final int option;
  const SelectDurationButton({
    required this.dateProv,
    required this.option,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<int,List<String>> map ={
      0:["Years",dateProv.selectedYear.toString()],
      1:["Months",dateProv.selectedMonth.toString()],
      2:["Days",dateProv.selectedDay.toString()]
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          map[option]![0],
          style:const TextStyle(
            color:Color.fromARGB(255, 176, 176, 176),
            fontSize:14
          )
        ),
        const SizedBox(height:5),
        ElevatedButton(
          onPressed: ()=>showD(context, DurationDialog(option:option)),
          style:const ButtonStyle(
            backgroundColor:MaterialStatePropertyAll<Color>(Color.fromRGBO(45,45,45,1)),
            overlayColor:MaterialStatePropertyAll<Color>(Colors.transparent)
          ),
          child:Row(
            children: [
              Text(
                map[option]![1],
                style:const TextStyle(
                  fontSize:18
                )
              ),
              const SizedBox(width:20),
              const Icon(Icons.keyboard_arrow_down)
            ],
          )
        )
      ],
    );
  }
}