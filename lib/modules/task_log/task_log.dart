import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/modules/settings/settings.dart';
import 'package:my_productive_rewards/modules/tabs/cubit/bottom_tabs_cubit.dart';
import 'package:my_productive_rewards/modules/task_log/cubit/task_log_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';

const List<String> sortByValues = ['Sort By:   Date', 'Sort By:   A to Z'];

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
          } else if (state.tasks.isEmpty) {
            bodyWidget = Center(
              child: Text(
                'No tasks recorded',
                style: MPRTextStyles.large,
              ),
            );
          } else {
            bodyWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(state: state),
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
                      builder: (_) =>
                          Settings(tabsCubit: context.read<BottomTabsCubit>()),
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

class _Header extends StatelessWidget {
  final TaskLogState state;
  const _Header({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskLogCubit>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Task Log',
            style: MPRTextStyles.extraLargeSemiBold,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorPalette.gunmetal.shade100),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 32,
                  width: 32,
                  child: Center(
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      onPressed: () => cubit.sortDirectionChanged(),
                      icon: Icon(
                        state.sortDirection == SortDirection.desc
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 148,
                  height: 42,
                  child: MPRDropdown(
                    value: state.filterBy,
                    values: sortByValues,
                    onValueChanged: (filter) => cubit.filterByChanged(filter),
                  ),
                ),
              ],
            ),
          ),
        ],
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
      child: RefreshIndicator(
        color: ColorPalette.green,
        onRefresh: () => context.read<TaskLogCubit>().initializeTaskLog(),
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
      ),
    );
  }
}
