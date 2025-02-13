import 'package:flutter/material.dart';
import 'package:stockly/ui/core/themes/colors.dart';

class StockStatusComponent extends StatelessWidget {
  const StockStatusComponent({
    super.key,
    required this.stock,
  });

  final int stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: stock != 0 ? Colors.black : AppColors.pink1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        stock != 0 ? 'Em Estoque' : 'Esgotado',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
