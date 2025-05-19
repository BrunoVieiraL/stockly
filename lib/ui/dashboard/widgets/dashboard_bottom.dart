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

  final DashboardViewmodel viewModel;

  @override
  State<DashboardBottom> createState() => _DashboardBottomState();
}

class _DashboardBottomState extends State<DashboardBottom> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: Container(
        color: theme.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receita',
              style: theme.textTheme.titleLarge,
            ),
            Text(
              'Últimos 14 dias',
              style: theme.textTheme.labelMedium,
            ),
            Expanded(
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(
                  isVisible: false,
                ),
                primaryXAxis: DateTimeAxis(
                  isVisible: true,
                  labelStyle: theme.textTheme.labelMedium,
                  dateFormat: DateFormat('dd/MM'),
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    DateTime dateTime = data.x;
                    String date =
                        '${dateTime.day < 10 ? '0' : ''}${dateTime.day}/${dateTime.month < 10 ? '0' : ''}${dateTime.month}';
                    return Container(
                      color: theme.cardColor,
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              top: 3,
                            ),
                            child: Text(
                              date,
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 3,
                                ),
                                child: Text(
                                  'Receita ',
                                  style: theme.textTheme.labelMedium,
                                ),
                              ),
                              Text(
                                data.y.toString(),
                                style: theme.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                series: <ColumnSeries<DataChart, DateTime>>[
                  ColumnSeries<DataChart, DateTime>(
                    dataSource: widget.viewModel.revenueChart,
                    xValueMapper: (DataChart datum, index) => datum.x,
                    yValueMapper: (DataChart datum, index) => datum.y,
                    color: theme.primaryColor,
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
