import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockly/data/repositories/dashboard/dashboard_repository.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardBottom extends StatefulWidget {
  const DashboardBottom({
    super.key,
    required this.viewModel,
  });

  final DashboardViewModel viewModel;

  @override
  State<DashboardBottom> createState() => _DashboardBottomState();
}

class _DashboardBottomState extends State<DashboardBottom> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Receita'),
            Text('Últimos 14 dias'),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, child) => child!,
                child: SfCartesianChart(
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                  ),
                  primaryXAxis: DateTimeAxis(
                    isVisible: true,
                    labelStyle: TextStyle(color: Colors.black),
                    dateFormat: DateFormat('dd/MM'),
                  ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                  ),
                  series: <ColumnSeries<DataChart, DateTime>>[
                    ColumnSeries<DataChart, DateTime>(
                      dataSource: widget.viewModel.revenueChart,
                      xValueMapper: (DataChart datum, index) => datum.x,
                      yValueMapper: (DataChart datum, index) => datum.y,
                      color: Colors.black,
                      enableTooltip: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
