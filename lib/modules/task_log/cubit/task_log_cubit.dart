import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/models/completed_task.dart';
import 'package:my_productive_rewards/services/database_service.dart';

part 'task_log_state.dart';

class TaskLogCubit extends Cubit<TaskLogState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  TaskLogCubit()
      : super(
          TaskLogState(
            status: TaskLogStatus.loading,
            tasks: [],
          ),
        );

  Future<void> initializeTaskLog() async {
    try {
      final tasks = await _databaseService.getCompletedTasks();
      if (tasks == null) {
        emit(state.copyWith(status: TaskLogStatus.failure));
      } else {
        tasks.sort((a, b) => b.date.compareTo(a.date));
      }
      emit(state.copyWith(status: TaskLogStatus.loaded, tasks: tasks));
    } catch (_) {
      emit(state.copyWith(status: TaskLogStatus.failure));
    }
  }
}
