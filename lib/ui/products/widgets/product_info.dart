import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/core/widgets/stock_status_component.dart';
import 'package:stockly/ui/products/viewmodel/produtcs_viewmodel.dart';
import 'package:stockly/ui/products/widgets/product_dialog.dart';

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
                      color: AppColors.blue1,
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
                      color: AppColors.blue1,
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
                      color: AppColors.blue1,
                    ),
                    Text('Deletar'),
                  ],
                ),
                onTap: () async => await viewModel.deleteProduct(product!.id!),
              ),
            ],
            icon: Icon(
              Icons.more_horiz,
              color: AppColors.blue1,
            ),
          ),
        ),
      ],
    );
  }
}
