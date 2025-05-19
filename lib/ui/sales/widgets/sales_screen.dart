import 'package:flutter/material.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/core/ui/base_layout.dart';
import 'package:stockly/ui/core/ui/error_indicator.dart';
import 'package:stockly/ui/sales/viewmodel/sales_viewmodel.dart';
import 'package:stockly/ui/sales/widgets/sales_info.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key, required this.viewModel});

  final SalesViewmodel viewModel;

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Gestão de Vendas',
      addButonOnPressed: () {},
      addButtonText: 'Nova Venda',
      columns: [
        Expanded(child: Text('Produtos')),
        Expanded(child: Text('Qtd. Produto')),
        Expanded(child: Text('Vlr. Total')),
        Expanded(child: Text('Data')),
        Expanded(child: Text('Ações')),
      ],
      listenable: widget.viewModel.load,
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
          itemCount: widget.viewModel.sales!.value.length,
          itemBuilder: (context, index) {
            Sale? sale = widget.viewModel.sales?.value[index];

            return SaleInfo(
              sale: sale,
              viewModel: widget.viewModel,
            );
          },
        );
      },
    );
  }
}
