import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/utils/utils.dart';

part 'task_log_state.dart';

DateFormat format = DateFormat("dd-MM-yyyy");

class TaskLogCubit extends Cubit<TaskLogState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  TaskLogCubit()
      : super(
          TaskLogState(
            status: TaskLogStatus.loading,
            tasks: [],
            filterBy: 'Sort By:   Date',
            sortDirection: SortDirection.desc,
          ),
        );

  Future<void> initializeTaskLog() async {
    try {
      final tasks = await _databaseService.getCompletedTasks();
      if (tasks == null) {
        emit(state.copyWith(status: TaskLogStatus.failure));
      } else {
        if (state.filterBy == 'Sort By:   A to Z') {
          if (state.sortDirection == SortDirection.desc) {
            tasks.sort((a, b) => a.description.compareTo(b.description));
          } else {
            tasks.sort((a, b) => b.description.compareTo(a.description));
          }
        } else {
          if (state.sortDirection == SortDirection.desc) {
            tasks.sort(
              (a, b) => b.date.dateFromFormattedDateString
                  .compareTo(a.date.dateFromFormattedDateString),
            );
          } else {
            tasks.sort(
              (a, b) => a.date.dateFromFormattedDateString
                  .compareTo(b.date.dateFromFormattedDateString),
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
    if (state.filterBy == 'Sort By:   Date') {
      if (state.sortDirection == SortDirection.desc) {
        sortedTasks.sort((a, b) => a.description.compareTo(b.description));
      } else {
        sortedTasks.sort((a, b) => b.description.compareTo(a.description));
      }
    } else {
      if (state.sortDirection == SortDirection.desc) {
        sortedTasks.sort(
          (a, b) => b.date.dateFromFormattedDateString
              .compareTo(a.date.dateFromFormattedDateString),
        );
      } else {
        sortedTasks.sort(
          (a, b) => a.date.dateFromFormattedDateString
              .compareTo(b.date.dateFromFormattedDateString),
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
    if (state.filterBy == 'Sort By:   A to Z') {
      if (state.sortDirection == SortDirection.asc) {
        sortedTasks.sort((a, b) => a.description.compareTo(b.description));
      } else {
        sortedTasks.sort((a, b) => b.description.compareTo(a.description));
      }
    } else {
      if (state.sortDirection == SortDirection.asc) {
        sortedTasks.sort(
          (a, b) => b.date.dateFromFormattedDateString
              .compareTo(a.date.dateFromFormattedDateString),
        );
      } else {
        sortedTasks.sort(
          (a, b) => a.date.dateFromFormattedDateString
              .compareTo(b.date.dateFromFormattedDateString),
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
}
