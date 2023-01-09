
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footie_heroes/dashboard/dashboard_drawer.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DialogShared.doubleButtonDialog(context, "Do you want to exit?", () {
          SystemNavigator.pop();
        }, () {
          Navigator.pop(context);
        });

        return Future.value(false);
      },
      child: Scaffold(
          key: scaffoldKey,
          drawer: const DashboardDrawer(),
          appBar: AppThemeShared.appBar(
              title: "Dashboard",
              context: context,
              leading: GestureDetector(
                  onTap: () => scaffoldKey.currentState!.openDrawer(),
                  child:
                      const Icon(Icons.menu_outlined, color: Colors.white)))),
    );
  }
}
