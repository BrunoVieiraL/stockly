import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';

class DashboardTop extends StatefulWidget {
  const DashboardTop({super.key, required this.viewModel});

  final DashboardViewModel viewModel;
  @override
  State<DashboardTop> createState() => _DashboardTopState();
}

class _DashboardTopState extends State<DashboardTop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 15,
          children: [
            DashboardCard(
              text: 'Receita Total',
              value: NumberFormat.simpleCurrency(
                locale: 'pt_BR',
                name: 'BRL',
                decimalDigits: 2,
              ).format(widget.viewModel.dashboard!.totalRecipe),
              icon: Icons.attach_money,
            ),
            DashboardCard(
              text: 'Receita Hoje',
              value: NumberFormat.simpleCurrency(
                locale: 'pt_BR',
                name: 'BRL',
                decimalDigits: 2,
              ).format(widget.viewModel.dashboard!.todayRecipe),
              icon: Icons.attach_money,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          spacing: 15,
          children: [
            DashboardCard(
              text: 'Vendas Totais',
              value: widget.viewModel.dashboard!.totalSales.toString(),
              icon: Icons.monetization_on_outlined,
            ),
            DashboardCard(
              text: 'Total em Estoque',
              value: widget.viewModel.dashboard!.stock.toString(),
              icon: Icons.inventory_2,
            ),
            DashboardCard(
              text: 'Produtos',
              value: widget.viewModel.dashboard!.products.toString(),
              icon: Icons.shopping_basket_outlined,
            ),
          ],
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.text,
    required this.value,
    required this.icon,
  });

  final String text;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.125,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.green2,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(icon),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
