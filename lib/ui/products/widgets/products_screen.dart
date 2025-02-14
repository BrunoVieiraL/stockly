import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/core/ui/error_indicator.dart';
import 'package:stockly/ui/core/widgets/stock_status_component.dart';
import 'package:stockly/ui/products/viewmodel/produtcs_viewmodel.dart';
import 'package:stockly/ui/products/widgets/product_dialog.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.viewModel});

  final ProdutcsViewmodel viewModel;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 30,
            children: [
              Expanded(child: Text('Produto')),
              Expanded(child: Text('Vlr. Unitário')),
              Expanded(child: Text('Estoque')),
              Expanded(child: Text('Status')),
              Expanded(child: Text('Ações')),
            ],
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
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
                    color: AppColors.grey3,
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
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.product,
    required this.viewModel,
  });

  final Product? product;
  final ProdutcsViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(product?.name ?? ''),
        ),
        Expanded(
          child: Text(
            NumberFormat.simpleCurrency(
              locale: 'pt_BR',
              name: 'BRL',
              decimalDigits: 2,
            ).format(product?.price ?? 0),
          ),
        ),
        Expanded(
          child: Text(product?.stock.toString() ?? ''),
        ),
        Expanded(
          child: StockStatusComponent(stock: product?.stock ?? 0),
        ),
        Expanded(
          child: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.copy,
                      color: AppColors.black2,
                    ),
                    Text('Copiar ID'),
                  ],
                ),
                onTap: () async => await Clipboard.setData(
                  ClipboardData(text: product!.id!),
                ),
              ),
              PopupMenuItem(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.black2,
                    ),
                    Text('Editar'),
                  ],
                ),
                onTap: () async => await showDialog(
                  context: context,
                  builder: (context) => ProductDialog(
                    product: product!,
                    onPressed: (name, price, stock) async =>
                        await viewModel.addProduct(
                      Product(
                        id: '0',
                        name: name,
                        price: price,
                        stock: stock,
                        createdAt: product!.createdAt,
                        updatedAt: DateTime.now(),
                      ),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: AppColors.black2,
                    ),
                    Text('Deletar'),
                  ],
                ),
                onTap: () async => await viewModel.deleteProduct(product!.id!),
              ),
            ],
            icon: Icon(
              Icons.more_horiz,
              color: AppColors.black1,
            ),
          ),
        ),
      ],
    );
  }
}
