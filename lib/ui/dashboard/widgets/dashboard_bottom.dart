import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockly/data/repositories/dashboard/dashboard_repository.dart';
import 'package:stockly/ui/core/themes/colors.dart';
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
            Text(
              'Receita',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            Text(
              'Últimos 14 dias',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.grey3,
              ),
            ),
            Expanded(
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
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    DateTime dateTime = data.x;
                    String date =
                        '${dateTime.day < 10 ? '0' : ''}${dateTime.day}/${dateTime.month < 10 ? '0' : ''}${dateTime.month}';
                    return Container(
                      color: Colors.white,
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
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.grey3,
                                  ),
                                ),
                              ),
                              Text(
                                data.y.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
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
                    color: Colors.black,
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
