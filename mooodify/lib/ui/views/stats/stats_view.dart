import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/ui/common/ui_helpers.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceMedium,
            _buildMoodOrbit(
              context,
              viewModel,
              Mood(type: 'Happy', value: 1),
            ), // temporarily happy ;)
            verticalSpaceLarge,
            _buildChart(context, viewModel),
          ],
        ),
      ),
    );
  }

  @override
  StatsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StatsViewModel();

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

  Widget _buildMoodOrbit(
      BuildContext context, StatsViewModel viewModel, Mood mood) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.green[900]!, Colors.yellow],
            center: Alignment.center,
            radius: 0.8,
          ),
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  mood.type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context, StatsViewModel viewModel) {
    return SizedBox(
      height: 100,
      width: screenWidth(context) * 0.8,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [],
              isCurved: true,
              barWidth: 2,
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
