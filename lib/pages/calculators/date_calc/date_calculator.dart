import 'package:flutter/material.dart';
import 'add_or_subtract.dart';
import 'difference.dart';

class DateCalculator extends StatelessWidget {
  const DateCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Material(
          color: Color.fromRGBO(32, 32, 32, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: 40),
                indicatorColor: Color.fromRGBO(118, 185, 237, 1),
                overlayColor:
                    MaterialStatePropertyAll<Color>(Colors.transparent),
                tabs: [
                  Tab(text: "Date difference"),
                  Tab(text: "Add or Subtract days"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    DateDifference(),
                    AddOrSubtract(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
