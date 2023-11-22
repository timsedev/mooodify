import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mooodify/core/models/mood.dart';
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMoodOrbit(
                context, viewModel, Mood.happy), // temporarily happy ;)
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
                  mood.moodName,
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
}
