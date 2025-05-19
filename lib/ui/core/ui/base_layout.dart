import 'package:flutter/material.dart';
import 'package:stockly/ui/core/themes/colors.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({
    super.key,
    required this.title,
    required this.addButonOnPressed,
    required this.addButtonText,
    required this.listenable,
    required this.listenableBuilder,
    required this.columns,
  });

  final String title;
  final Function() addButonOnPressed;
  final String addButtonText;
  final Listenable listenable;
  final Widget Function(BuildContext context, Widget? child) listenableBuilder;
  final List<Widget> columns;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextTheme.of(context).titleLarge,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: addButonOnPressed,
                label: Text(
                  addButtonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 30,
            children: columns,
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: listenable,
              builder: listenableBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
