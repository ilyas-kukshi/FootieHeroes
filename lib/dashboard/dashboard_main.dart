import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:footie_heroes/dashboard/dashboard_drawer.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: DashboardDrawer(),
        appBar: AppThemeShared.appBar(
            title: "Dashboard",
            context: context,
            leading: GestureDetector(
                onTap: () => scaffoldKey.currentState!.openDrawer(),
                child: Icon(Icons.menu_outlined, color: Colors.white))));
  }
}
