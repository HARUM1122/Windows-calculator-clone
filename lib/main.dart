import 'package:flutter/material.dart';
import 'package:ms_calculator/screens/splash.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'package:flutter/services.dart';

void main() => runApp(const Calculator());

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromRGBO(32, 32, 32, 1)));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HistoryProvider()),
          ChangeNotifierProvider(create: (_) => StandardMemoryProvider()),
          ChangeNotifierProvider(create: (_) => ScientificMemoryProvider()),
          ChangeNotifierProvider(create: (_) => StandardCalcProvider()),
          ChangeNotifierProvider(create: (_) => ScientificCalcProvider()),
          ChangeNotifierProvider(create: (_) => DateCalcProvider()),
          ChangeNotifierProvider(create: (_) => DrawerProvider()),
          ChangeNotifierProvider(create: (_) => DialogProvider()),
          ChangeNotifierProvider(create: (_) => UnitProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: false),
            home: const SplashScreen()));
  }
}
