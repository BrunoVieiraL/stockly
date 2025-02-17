import 'package:flutter/material.dart';
import 'package:stockly/data/repositories/dashboard/dashboard_respository_dev.dart';
import 'package:stockly/data/repositories/products/products_repository_remote.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_screen.dart';
import 'package:stockly/ui/products/viewmodel/produtcs_viewmodel.dart';
import 'package:stockly/ui/products/widgets/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashboardViewModel dashboardViewModel = DashboardViewModel(
    dashboardRepository: DashboardRespositoryDev(),
  );
  ProdutcsViewmodel productsViewmodel = ProdutcsViewmodel(
    productsRepository: ProductsRepositoryRemote(),
  );
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) async {
          if (value == 0) {
            await dashboardViewModel.load.execute();
          }
          setState(() {
            currentPageIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.grid_view_outlined,
            ),
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
        DashboardScreen(
          viewModel: dashboardViewModel,
        ),
        ProductsScreen(
          viewModel: productsViewmodel,
        ),
        Container(),
        Container(),
      ][currentPageIndex],
    );
  }
}
