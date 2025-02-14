import 'package:flutter/material.dart';
import 'package:stockly/data/repositories/dashboard/dashboard_respository_dev.dart';
import 'package:stockly/data/repositories/products/products_repository_remote.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_screen.dart';
import 'package:stockly/ui/products/viewmodel/produtcs_viewmodel.dart';
import 'package:stockly/ui/products/widgets/product_dialog.dart';
import 'package:stockly/ui/products/widgets/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProdutcsViewmodel productsViewmodel = ProdutcsViewmodel(
    productsRepository: ProductsRepositoryRemote(),
  );
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
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
          viewModel: DashboardViewModel(
            dashboardRepository: DashboardRespositoryDev(),
          ),
        ),
        ProductsScreen(
          viewModel: productsViewmodel,
        ),
        Container(),
        Container(),
      ][currentPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeFAB.getFab(
        currentPageIndex,
        context,
        productsViewmodel,
      ),
    );
  }
}

class HomeFAB {
  static FloatingActionButton? getFab(
    index,
    context,
    ProdutcsViewmodel productsViewModel,
  ) {
    switch (index) {
      case 1:
        return FloatingActionButton.small(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => ProductDialog(
                onPressed: (name, price, stock) async =>
                    await productsViewModel.addProduct(
                  Product(
                    name: name,
                    price: price,
                    stock: stock,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                ),
              ),
            );
          },
          backgroundColor: AppColors.blue1,
          tooltip: 'Adicionar um novo produto',
          child: Icon(
            Icons.add,
            color: AppColors.grey2,
          ),
        );
      case 2:
        return FloatingActionButton.small(
          onPressed: () {},
          backgroundColor: AppColors.blue1,
          tooltip: 'Realizar nova venda',
          child: Icon(
            Icons.add,
            color: AppColors.grey2,
          ),
        );
      default:
        return null;
    }
  }
}
