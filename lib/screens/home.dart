import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/calculators/calculators.dart';
import '../pages/converter.dart';
import '../providers/drawer_dialog_unit.dart';
import '../widgets/history/history_list.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/drawer/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final DrawerProvider drawerProv =
        Provider.of<DrawerProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(32, 32, 32, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Consumer<DrawerProvider>(
            builder: (context, drawerProv, _) => Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500)),
          ),
          actions: [
            Consumer<DrawerProvider>(
              builder: (context, drawerProv, _) => Visibility(
                visible: selectedCategory < 2,
                child: TextButton(
                    onPressed: () => showSheet(context,
                        HistoryList(isStandard: selectedCategory == 0)),
                    style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll<Color>(
                            Colors.transparent)),
                    child: const Icon(Icons.history_outlined,
                        color: Colors.white, size: 32)),
              ),
            )
          ],
        ),
        body: PageView(
          controller: drawerProv.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            StandardCalculator(),
            ScientificCalculator(),
            DateCalculator(),
            ConverterPage()
          ],
        ),
        drawer: const CustomDrawer());
  }
}
