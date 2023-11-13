import 'package:flutter/material.dart';
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
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2050, 31, 12),
          focusedDay: DateTime.now(),
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
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, day, focusedDay) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
}
