import 'package:flutter/material.dart';
import 'package:stockly/ui/core/themes/colors.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';

class DashboardMid extends StatefulWidget {
  const DashboardMid({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  State<DashboardMid> createState() => _DashboardMidState();
}

class _DashboardMidState extends State<DashboardMid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produtos mais vendidos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          Text(
            'Todo o tempo',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.grey3,
            ),
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
                    color: AppColors.white1,
                    thickness: 5,
                  ),
                  itemBuilder: (context, index) {
                    var sale = widget.viewModel.mostSalesProducts?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: sale?.stock != 0
                                ? Colors.black
                                : AppColors.pink1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            sale?.stock != 0 ? 'Em Estoque' : 'Esgotado',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${sale?.name}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${sale?.quantitySold} vendas',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'R\$ ${sale?.unitPrice}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grey3,
                          ),
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
