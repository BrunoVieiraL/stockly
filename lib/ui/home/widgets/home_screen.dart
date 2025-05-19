import 'package:flutter/material.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_screen.dart';
import 'package:stockly/ui/products/viewmodel/produtcs_viewmodel.dart';
import 'package:stockly/ui/products/widgets/products_screen.dart';
import 'package:stockly/ui/sales/viewmodel/sales_viewmodel.dart';
import 'package:stockly/ui/sales/widgets/sales_screen.dart';
import 'package:stockly/ui/settings/viewmodel/settings_viewmodel.dart';
import 'package:stockly/ui/settings/widgets/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.settingsViewmodel,
    required this.salesViewmodel,
    required this.dashboardViewmodel,
    required this.productsViewmodel,
  });
  final DashboardViewmodel dashboardViewmodel;
  final ProdutcsViewmodel productsViewmodel;
  final SalesViewmodel salesViewmodel;
  final SettingsViewmodel settingsViewmodel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: NavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) async {
          if (value == 0) {
            await widget.dashboardViewmodel.load.execute();
          }
          setState(() {
            currentPageIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Produtos',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Vendas',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Configurações',
          ),
        ],
      ),
      body: <Widget>[
        DashboardScreen(viewModel: widget.dashboardViewmodel),
        ProductsScreen(viewModel: widget.productsViewmodel),
        SalesScreen(viewModel: widget.salesViewmodel),
        SettingsScreen(viewmodel: widget.settingsViewmodel),
      ][currentPageIndex],
    );
  }
}
