import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mooodify/ui/common/ui_helpers.dart';
import 'package:mooodify/ui/views/stats/widgets/animated_orbit.dart';
import 'package:stacked/stacked.dart';

import 'stats_viewmodel.dart';

class StatsView extends StackedView<StatsViewModel> {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StatsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: _buildAppBar(context, viewModel),
      body: SafeArea(
        child: !viewModel.isBusy
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 500,
                        width: 500,
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100],
                        child: AnimatedOrbit(),
                      ),
                      verticalSpaceLarge,
                      Expanded(child: _buildChart(context, viewModel)),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  StatsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StatsViewModel();

  @override
  void onViewModelReady(StatsViewModel viewModel) {
    viewModel.init();
  }

  @override
  void onDispose(StatsViewModel viewModel) {
    viewModel.disposeAnimationController();
    super.onDispose(viewModel);
  }

  AppBar _buildAppBar(BuildContext context, StatsViewModel viewModel) {
    return AppBar(
      leadingWidth: 100,
      leading: GestureDetector(
        onTap: viewModel.navBack,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              'Go Back',
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildChart(BuildContext context, StatsViewModel viewModel) {
    return Column(
      children: [
        _buildTabBar(viewModel),
        verticalSpaceMedium,
        SizedBox(
          height: 250,
          width: screenWidth(context) * 0.8,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, metadata) {
                        switch (value.toInt()) {
                          case 0:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Mon'),
                            );
                          case 1:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Tue'),
                            );
                          case 2:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Wed'),
                            );
                          case 3:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Thu'),
                            );
                          case 4:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Fri'),
                            );
                          case 5:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Sat'),
                            );
                          case 6:
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Sun'),
                            );
                          default:
                            throw Exception('Invalid value: $value');
                        }
                      },
                      reservedSize: 50),
                ),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, metadata) {
                    log('value: $value');
                    switch (value.toInt()) {
                      case -2:
                        return const Text('-2');
                      case 0:
                        return const Text('0');
                      case 2:
                        return const Text('2');
                      default:
                        return Container();
                    }
                  },
                  interval: 2,
                  reservedSize: 40,
                )),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black, width: 0.1),
                  bottom: BorderSide(color: Colors.black, width: 0.1),
                ),
              ),
              maxY: 2,
              minY: -2,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.black,
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((barSpot) {
                      return LineTooltipItem(
                        '${barSpot.y}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: viewModel.chartAverageSpots,
                  color: Colors.black,
                  isCurved: true,
                  barWidth: 2,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 6, // Change this value as needed
                      color: Colors.black, // This is the dot color
                      strokeWidth: 1,
                      strokeColor: Colors.white, // This is the stroke color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(StatsViewModel viewModel) {
    return SizedBox(
      height: 75,
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem(viewModel, 'Week', 0),
          _buildTabItem(viewModel, 'Month', 1),
          _buildTabItem(viewModel, 'Year', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(StatsViewModel viewModel, String title, int index) {
    final isSelected = viewModel.selectedTabIndex == index;
    return GestureDetector(
      onTap: () => viewModel.onTabTapped(index),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(title),
            ),
            verticalSpaceSmall,
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: isSelected ? 2 : 0,
              width: isSelected ? 20 : 0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
