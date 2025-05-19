import 'package:flutter/material.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/core/ui/base_layout.dart';
import 'package:stockly/ui/core/ui/error_indicator.dart';
import 'package:stockly/ui/products/viewmodel/produtcs_viewmodel.dart';
import 'package:stockly/ui/products/widgets/product_dialog.dart';
import 'package:stockly/ui/products/widgets/product_info.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.viewModel});

  final ProdutcsViewmodel viewModel;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Gestão de produtos',
      addButtonText: 'Novo produto',
      addButonOnPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => ProductDialog(
            onPressed: (name, price, stock) async =>
                await widget.viewModel.addProduct(
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
      columns: [
        Expanded(child: Text('Produto')),
        Expanded(child: Text('Vlr. Unitário')),
        Expanded(child: Text('Estoque')),
        Expanded(child: Text('Status')),
        Expanded(child: Text('Ações')),
      ],
      listenable: widget.viewModel,
      listenableBuilder: (context, child) {
        if (widget.viewModel.load.running) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (widget.viewModel.load.error) {
          return ErrorIndicator(
            title: 'Error',
            label: 'Erro ao obter lista de produtos',
            onPressed: widget.viewModel.load.execute,
          );
        }

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            thickness: 2,
            height: 8,
            color: AppColors.white1,
          ),
          shrinkWrap: true,
          itemCount: widget.viewModel.products!.value.length,
          itemBuilder: (context, index) {
            Product? product = widget.viewModel.products?.value[index];
            return ProductInfo(
              product: product,
              viewModel: widget.viewModel,
            );
          },
        );
      },
    );
  }
}
