import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/sales/viewmodel/sales_viewmodel.dart';

class SaleInfo extends StatelessWidget {
  const SaleInfo({
    super.key,
    required this.sale,
    required this.viewModel,
  });

  final Sale? sale;
  final SalesViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(sale?.name ?? ''),
        ),
        Expanded(
          child: Text(sale?.quantitySold.toString() ?? ''),
        ),
        Expanded(
          child: Text(
            NumberFormat.simpleCurrency(
              locale: 'pt_BR',
              name: 'BRL',
              decimalDigits: 2,
            ).format(sale!.unitPrice * sale!.quantitySold),
          ),
        ),
        Expanded(child: Text(sale?.createdAt.toString() ?? '')),
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
                  ClipboardData(text: sale!.id.toString()),
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
                onTap: () {},
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
                onTap: () async => await viewModel.deleteSale(sale!.id),
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
