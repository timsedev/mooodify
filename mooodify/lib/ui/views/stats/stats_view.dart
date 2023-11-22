import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  StatsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StatsViewModel();
}
