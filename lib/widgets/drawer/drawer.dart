import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_tile.dart';
import '../../providers/drawer_dialog_unit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final UnitProvider textProv =
        Provider.of<UnitProvider>(context, listen: false);
    final DialogProvider dialogProv =
        Provider.of<DialogProvider>(context, listen: false);
    final DrawerProvider drawerProv =
        Provider.of<DrawerProvider>(context, listen: false);
    return SafeArea(
        child: Drawer(
      width: 260,
      backgroundColor: const Color.fromRGBO(45, 45, 45, 1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 10, top: 20),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          const Text("Calculator",
              style: TextStyle(
                  color: Color.fromRGBO(175, 175, 175, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          DrawerTile(
            id: 0,
            icon: Icons.calculate_outlined,
            currentName: "Standard",
            drawerProv: drawerProv,
          ),
          DrawerTile(
              id: 1,
              icon: Icons.science_outlined,
              currentName: "Scientific",
              drawerProv: drawerProv),
          DrawerTile(
              id: 2,
              icon: Icons.date_range_outlined,
              currentName: "Date calculation",
              drawerProv: drawerProv),
          const SizedBox(height: 10),
          const Text("Converter",
              style: TextStyle(
                  color: Color.fromRGBO(175, 175, 175, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          DrawerTile(
            id: 3,
            icon: Icons.free_breakfast_outlined,
            currentName: "Volume",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 4,
            icon: Icons.straighten_outlined,
            currentName: "Length",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 5,
            icon: Icons.speed_outlined,
            currentName: "Pressure",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 6,
            icon: Icons.sd_outlined,
            currentName: "Data",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 7,
            icon: Icons.run_circle_outlined,
            currentName: "Speed",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 8,
            icon: Icons.scale_outlined,
            currentName: "Mass",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 9,
            icon: Icons.watch_later_outlined,
            currentName: "Time",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 10,
            icon: Icons.whatshot_outlined,
            currentName: "Energy",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 11,
            icon: Icons.rectangle_outlined,
            currentName: "Area",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 12,
            icon: Icons.thermostat_outlined,
            currentName: "Temperature",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 13,
            icon: Icons.power_outlined,
            currentName: "Power",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
          DrawerTile(
            id: 14,
            icon: Icons.architecture_outlined,
            currentName: "Angle",
            drawerProv: drawerProv,
            textProv: textProv,
            dialogProv: dialogProv,
          ),
        ]),
      ),
    ));
  }
}
