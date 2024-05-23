import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_entry_model.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/home/presentation/bloc/student_home/student_home_bloc.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';

class OnGoingClassWidget extends StatelessWidget {
  const OnGoingClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentHomeBloc, StudentHomeState>(
      builder: (context, state) {
        if (state is StudentHomeSuccessState) {
          final ongoingClass =
              _getCurrentClass(state.timeTableEntity, DateTime.now());
          return Container(
            margin: const EdgeInsets.only(left: 14, right: 14),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF6d61f3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _getGreetingMessage(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ongoingClass != null
                              ? ongoingClass.subjectName
                              : 'No ongoing class',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ongoingClass != null ? ongoingClass.time : '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Lottie.asset(
                  LocalResourcesConstants.studyLottie,
                  height: 110,
                  width: 120,
                ),
              ],
            ),
          );
        } else {
          return Container(); // Placeholder until timetable is loaded
        }
      },
    );
  }

  TimetableEntry? _getCurrentClass(
      TimeTableEntity? timetable, DateTime currentTime) {
    if (timetable == null || timetable.timetable.isEmpty) return null;

    final currentDay = _getDayOfWeek(currentTime.weekday);
    final currentTimeString =
        '${_formatTime(currentTime.hour)}:${_formatTime(currentTime.minute)}';

    final classesForCurrentDay = timetable.timetable[currentDay];
    if (classesForCurrentDay != null) {
      for (final timetableEntry in classesForCurrentDay) {
        final classTime = timetableEntry.time.split(' - ');
        if (classTime.length == 2) {
          final startTime = _formatTimeAsString(classTime[0]);
          final endTime = _formatTimeAsString(classTime[1]);
          if (currentTimeString.compareTo(startTime) >= 0 &&
              currentTimeString.compareTo(endTime) <= 0) {
            return timetableEntry;
          }
        }
      }
    }
    return null;
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  String _formatTimeAsString(String time) {
    final parts = time.split(':');
    final hour = _formatTime(int.parse(parts[0]));
    final minute = _formatTime(int.parse(parts[1].split(' ')[0]));
    final meridian = parts[1].split(' ')[1];
    return '$hour:$minute $meridian';
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
}
