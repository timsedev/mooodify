import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:mooodify/ui/common/app_colors.dart';
import 'package:mooodify/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              verticalSpaceMassive,
              _buildDate(),
              verticalSpaceLarge,
              SizedBox(
                height: 300,
                child: _buildMoodSlider(viewModel),
              ),
              verticalSpaceLarge,
              _buildSelectMoodButton(viewModel),
              verticalSpaceLarge,
              Text(viewModel.selectedMood.name),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  Widget _buildDate() {
    return const Text('Today, 11 Nov 2023');
  }

  Widget _buildMoodSlider(HomeViewModel viewModel) {
    return PageView(
      controller: PageController(viewportFraction: 0.8, initialPage: 1),
      onPageChanged: viewModel.onMoodSliderChanged,
      children: viewModel.moods
          .map((mood) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    mood.name,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildSelectMoodButton(HomeViewModel viewModel) {
    return ElevatedButton(
      onPressed: viewModel.selectMood,
      child: const Text('Select Mood'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
