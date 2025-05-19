import 'package:flutter/material.dart';
import 'package:stockly/ui/home/widgets/home_screen.dart';
import 'package:stockly/ui/settings/viewmodel/settings_viewmodel.dart';

import 'data/repositories/dashboard/dashboard_respository_dev.dart';
import 'data/repositories/products/products_repository_remote.dart';
import 'data/repositories/sales/sales_repository_dev.dart';
import 'ui/dashboard/view_model/dashboard_view_model.dart';
import 'ui/products/viewmodel/produtcs_viewmodel.dart';
import 'ui/sales/viewmodel/sales_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DashboardViewmodel dashboardViewModel = DashboardViewmodel(
    dashboardRepository: DashboardRespositoryDev(),
  );
  ProdutcsViewmodel productsViewmodel = ProdutcsViewmodel(
    productsRepository: ProductsRepositoryRemote(),
  );
  SalesViewmodel salesViewmodel = SalesViewmodel(
    salesRepository: SalesRepositoryDev(),
  );
  SettingsViewmodel settingsViewmodel = SettingsViewmodel();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsViewmodel,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: settingsViewmodel.themeData,
        themeMode: ThemeMode.system,
        home: HomeScreen(
          dashboardViewmodel: dashboardViewModel,
          productsViewmodel: productsViewmodel,
          salesViewmodel: salesViewmodel,
          settingsViewmodel: settingsViewmodel,
        ),
      ),
    );
  }
}
