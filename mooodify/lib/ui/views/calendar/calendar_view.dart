import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_viewmodel.dart';

class CalendarView extends StackedView<CalendarViewModel> {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CalendarViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildCalendar(context, viewModel),
              verticalSpaceLarge,
              _buildTodayMood(context, viewModel),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CalendarViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CalendarViewModel();

  @override
  void onViewModelReady(CalendarViewModel viewModel) async {
    await viewModel.init();
  }

  Color _setDotColor(CalendarViewModel viewModel, DateTime datetime) {
    // compare datetime and focusedDay;
    final focusedDay = DateTime(viewModel.focusedDay.year,
        viewModel.focusedDay.month, viewModel.focusedDay.day);
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    if (date == focusedDay) {
      return Colors.white;
    }

    return Colors.black;
  }

  Widget _buildCalendar(BuildContext context, CalendarViewModel viewModel) {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2050, 31, 12),
      focusedDay: viewModel.focusedDay,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(
        headerMargin: EdgeInsets.symmetric(vertical: 15), // Add this line
        headerPadding: EdgeInsets.all(10),
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 15,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 15,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      selectedDayPredicate: (day) => day == viewModel.focusedDay,
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, day, focusedDay) {
          return day != focusedDay
              ? Center(
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              : _selectedDay(day);
        },
        selectedBuilder: (context, day, focusedDay) {
          return _selectedDay(day);
        },
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              bottom: 5,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _setDotColor(viewModel, date),
                ),
              ),
            );
          }
          return Container();
        },
      ),
      eventLoader: (day) {
        return viewModel.getMoodsForDay(day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        viewModel.onDaySelected(selectedDay);
      },
    );
  }

  Widget _buildTodayMood(BuildContext context, CalendarViewModel viewModel) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Text(
          viewModel.todayMood.moodName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _selectedDay(DateTime day) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Center(
        child: Text(
          day.day.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
