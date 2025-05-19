import 'package:flutter/material.dart';
import 'package:stockly/ui/core/ui/error_indicator.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_bottom.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_mid.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_top.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.viewModel,
  });

  final DashboardViewmodel viewModel;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(10),
      child: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.running) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (widget.viewModel.load.error) {
            return ErrorIndicator(
              title: '',
              label: '',
              onPressed: widget.viewModel.load.execute,
            );
          }
          return child!;
        },
        child: Column(
          spacing: 15,
          children: [
            DashboardTop(viewModel: widget.viewModel),
            DashboardMid(viewModel: widget.viewModel),
            DashboardBottom(viewModel: widget.viewModel),
          ],
        ),
      ),
    );
  }
}
