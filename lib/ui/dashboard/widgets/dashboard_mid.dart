import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockly/ui/core/widgets/stock_status_component.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';

class DashboardMid extends StatefulWidget {
  const DashboardMid({super.key, required this.viewModel});

  final DashboardViewmodel viewModel;

  @override
  State<DashboardMid> createState() => _DashboardMidState();
}

class _DashboardMidState extends State<DashboardMid> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produtos mais vendidos',
            style: theme.textTheme.titleLarge,
          ),
          Text(
            'Todo o tempo',
            style: theme.textTheme.labelMedium,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Scrollbar(
              interactive: true,
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: ListView.separated(
                  itemCount: widget.viewModel.mostSalesProducts!.length,
                  separatorBuilder: (context, index) => Divider(
                    color: theme.scaffoldBackgroundColor,
                    thickness: 5,
                  ),
                  itemBuilder: (context, index) {
                    var sale = widget.viewModel.mostSalesProducts?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StockStatusComponent(stock: sale?.stock ?? 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${sale?.name}',
                              textAlign: TextAlign.left,
                              style: theme.textTheme.labelLarge,
                            ),
                            Text(
                              '${sale?.quantitySold} vendas',
                              textAlign: TextAlign.right,
                              style: theme.textTheme.labelLarge,
                            ),
                          ],
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                            locale: 'pt_BR',
                            name: 'BRL',
                            decimalDigits: 2,
                          ).format(sale?.unitPrice ?? 0),
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
