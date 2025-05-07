import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/completed_task.dart';
import 'package:my_productive_rewards/modules/settings/settings.dart';
import 'package:my_productive_rewards/modules/task_log/cubit/task_log_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class TaskLog extends StatelessWidget {
  const TaskLog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskLogCubit>(
      create: (_) => TaskLogCubit()..initializeTaskLog(),
      child: BlocBuilder<TaskLogCubit, TaskLogState>(
        builder: (context, state) {
          Widget bodyWidget = const SizedBox.shrink();
          if (state.status == TaskLogStatus.loading) {
            bodyWidget = Center(child: MPRLoader.circular());
          } else if (state.status == TaskLogStatus.failure) {
            bodyWidget = Center(child: Text('Unable to load data'));
          } else if ((state.status == TaskLogStatus.loaded ||
                  state.status == TaskLogStatus.tasksUpdated) &&
              state.tasks.isNotNullOrEmpty) {
            bodyWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12,
                    bottom: 12,
                    top: 20,
                  ),
                  child: Text(
                    'Task Log',
                    style: MPRTextStyles.extraLargeSemiBold,
                  ),
                ),
                _MyTasks(tasks: state.tasks),
              ],
            );
          }
          return Scaffold(
            appBar: MPRAppBar(
              title: 'Task Log',
              trailingActions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Settings(),
                    ),
                  ),
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            backgroundColor: ColorPalette.gunmetal.shade50,
            body: bodyWidget,
          );
        },
      ),
    );
  }
}

class _MyTasks extends StatelessWidget {
  final List<CompletedTask> tasks;
  const _MyTasks({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ColoredBox(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MPRDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.description,
                            style: MPRTextStyles.largeSemiBold,
                          ),
                          Text(
                            task.date,
                            style: MPRTextStyles.regular,
                          ),
                        ],
                      ),
                      Text(
                        '${task.points} pts',
                        style: MPRTextStyles.regularSemiBold,
                      ),
                    ],
                  ),
                ),
                if (index == tasks.length - 1) const MPRDivider(),
              ],
            ),
          );
        },
        itemCount: tasks.length,
      ),
    );
  }
}
