import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockly/data/repositories/dashboard/dashboard_repository.dart';
import 'package:stockly/ui/core/ui/error_indicator.dart';
import 'package:stockly/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_mid.dart';
import 'package:stockly/ui/dashboard/widgets/dashboard_top.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.viewModel,
  });

  final DashboardViewModel viewModel;

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
          spacing: 20,
          children: [
            DashboardTop(viewModel: widget.viewModel),
            DashboardMid(viewModel: widget.viewModel),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Receita'),
                    Text('Últimos 14 dias'),
                    Expanded(
                      child: SfCartesianChart(
                        primaryYAxis: NumericAxis(
                          isVisible: false,
                        ),
                        primaryXAxis: DateTimeAxis(
                          isVisible: true,
                          labelStyle: TextStyle(color: Colors.black),
                          maximumLabels: 5,
                          dateFormat: DateFormat('dd/MM'),
                        ),
                        series: [
                          ColumnSeries<DataChart, dynamic>(
                            dataSource: widget.viewModel.revenueChart,
                            xValueMapper: (DataChart datum, index) => datum.x,
                            yValueMapper: (DataChart datum, index) => datum.y,
                          ),
                        ],
                      ),
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
