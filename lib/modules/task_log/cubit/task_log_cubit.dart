import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';

part 'task_log_state.dart';

DateFormat format = DateFormat("dd-MM-yyyy");

class TaskLogCubit extends Cubit<TaskLogState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  TaskLogCubit()
      : super(
          TaskLogState(
            status: TaskLogStatus.loading,
            tasks: [],
            filterBy: 'Date',
            sortDirection: SortDirection.desc,
          ),
        );

  Future<void> initializeTaskLog() async {
    try {
      final tasks = await _databaseService.getCompletedTasks();
      if (tasks == null) {
        emit(state.copyWith(status: TaskLogStatus.failure));
      } else {
        if (state.filterBy == 'A to Z') {
          if (state.sortDirection == SortDirection.desc) {
            tasks.sort((a, b) => a.description.compareTo(b.description));
          } else {
            tasks.sort((a, b) => b.description.compareTo(a.description));
          }
        } else {
          if (state.sortDirection == SortDirection.desc) {
            tasks.sort(
              (a, b) => _getDateTime(b.date).compareTo(_getDateTime(a.date)),
            );
          } else {
            tasks.sort(
              (a, b) => _getDateTime(a.date).compareTo(_getDateTime(b.date)),
            );
          }
        }
      }
      emit(state.copyWith(status: TaskLogStatus.loaded, tasks: tasks));
    } catch (_) {
      emit(state.copyWith(status: TaskLogStatus.failure));
    }
  }

  void filterByChanged(String? filter) {
    final List<CompletedTask> sortedTasks = List.from(state.tasks);
    if (state.filterBy == 'Date') {
      if (state.sortDirection == SortDirection.desc) {
        sortedTasks.sort((a, b) => a.description.compareTo(b.description));
      } else {
        sortedTasks.sort((a, b) => b.description.compareTo(a.description));
      }
    } else {
      if (state.sortDirection == SortDirection.desc) {
        sortedTasks.sort(
          (a, b) => _getDateTime(b.date).compareTo(_getDateTime(a.date)),
        );
      } else {
        sortedTasks.sort(
          (a, b) => _getDateTime(a.date).compareTo(_getDateTime(b.date)),
        );
      }
    }
    emit(
      state.copyWith(
        filterBy: filter,
        tasks: sortedTasks,
        status: TaskLogStatus.filterByUpdated,
      ),
    );
  }

  void sortDirectionChanged() {
    final List<CompletedTask> sortedTasks = List.from(state.tasks);
    if (state.filterBy == 'A to Z') {
      if (state.sortDirection == SortDirection.asc) {
        sortedTasks.sort((a, b) => a.description.compareTo(b.description));
      } else {
        sortedTasks.sort((a, b) => b.description.compareTo(a.description));
      }
    } else {
      if (state.sortDirection == SortDirection.asc) {
        sortedTasks.sort(
          (a, b) => _getDateTime(b.date).compareTo(_getDateTime(a.date)),
        );
      } else {
        sortedTasks.sort(
          (a, b) => _getDateTime(a.date).compareTo(_getDateTime(b.date)),
        );
      }
    }
    emit(
      state.copyWith(
        sortDirection: state.sortDirection == SortDirection.desc
            ? SortDirection.asc
            : SortDirection.desc,
        status: TaskLogStatus.sortDirectionChanged,
        tasks: sortedTasks,
      ),
    );
  }

  DateTime _getDateTime(String date) {
    final split = date.split(' ');
    final month = split[1];
    final day = int.parse(split[2].substring(0, split[2].indexOf(',')));
    final year = int.parse(split[3]);
    return DateTime(year, _getMonth(month), day);
  }

  int _getMonth(String month) {
    switch (month) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        return -1;
    }
  }
}
