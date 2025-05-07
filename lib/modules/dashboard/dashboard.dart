import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/task.dart';
import 'package:my_productive_rewards/modules/dashboard/add_completed_task/add_completed_task.dart';
import 'package:my_productive_rewards/modules/dashboard/add_new_task/add_new_task.dart';
import 'package:my_productive_rewards/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:my_productive_rewards/modules/dashboard/edit_task/edit_task.dart';
import 'package:my_productive_rewards/modules/settings/settings.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (_) => DashboardCubit()..initializeDashboard(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          Widget bodyWidget = const SizedBox.shrink();
          if (state.status == DashboardStatus.loading) {
            bodyWidget = Center(child: MPRLoader.circular());
          } else if (state.status == DashboardStatus.failure) {
            bodyWidget = Center(child: Text('Unable to load data'));
          } else if ((state.status == DashboardStatus.loaded ||
                  state.status == DashboardStatus.tasksUpdated ||
                  state.status == DashboardStatus.pointsUpdated) &&
              state.tasks.isEmpty) {
            bodyWidget = Center(child: Text('No tasks saved'));
          } else if ((state.status == DashboardStatus.loaded ||
                  state.status == DashboardStatus.tasksUpdated ||
                  state.status == DashboardStatus.pointsUpdated) &&
              state.tasks.isNotNullOrEmpty) {
            bodyWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.points.isNotEmpty)
                  _Points(
                    points: state.points,
                    goalPoints: state.goalPoints,
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12,
                    bottom: int.tryParse(state.goalPoints) == null ? 12 : 8,
                    top: int.tryParse(state.goalPoints) == null ? 12 : 2,
                  ),
                  child: Text(
                    'My Tasks',
                    style: MPRTextStyles.extraLargeSemiBold,
                  ),
                ),
                _MyTasks(tasks: state.tasks),
              ],
            );
          }
          return Scaffold(
            appBar: MPRAppBar(
              title: 'Dashboard',
              trailingActions: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () =>
                        context.read<DashboardCubit>().initializeDashboard(),
                    icon: Icon(Icons.refresh),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 16,
                  ),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Settings(),
                        ),
                      ).then((_) {
                        if (context.mounted) {
                          context.read<DashboardCubit>().initializeDashboard();
                        }
                      }),
                      icon: Icon(Icons.settings),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: ColorPalette.gunmetal.shade50,
            body: bodyWidget,
            floatingActionButton: FloatingActionButton(
              heroTag: 'dashboard',
              backgroundColor: ColorPalette.green,
              child: const Icon(Icons.add),
              onPressed: () async {
                final result = await showDialog<bool?>(
                  context: context,
                  builder: (context) => AddNewTask(),
                );
                if (context.mounted && result != null) {
                  await context.read<DashboardCubit>().getTasks();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _Points extends StatelessWidget {
  final String points;
  final String goalPoints;
  const _Points({
    required this.points,
    required this.goalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: ColorPalette.green.shade100,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        points,
                        style: MPRTextStyles.extraLargeSemiBold.copyWith(
                          fontSize: 65,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child:
                              Text('TOTAL', style: MPRTextStyles.regularBold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child:
                              Text('POINTS', style: MPRTextStyles.regularBold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MPRDivider(),
            ],
          ),
        ),
        if (int.tryParse(goalPoints) != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: int.parse(points) / int.parse(goalPoints),
                    minHeight: 16,
                    backgroundColor: ColorPalette.platinum.shade600,
                    color: ColorPalette.green,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    '$points of $goalPoints pts',
                    style: MPRTextStyles.regularSemiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MyTasks extends StatelessWidget {
  final List<Task> tasks;
  const _MyTasks({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 50),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ColoredBox(
            color: Colors.white,
            child: Column(
              children: [
                const MPRDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.description,
                              style: MPRTextStyles.largeSemiBold,
                            ),
                            Text(
                              '${task.points} points',
                              style: MPRTextStyles.regular,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 22,
                        width: 22,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            final result = await showDialog<bool?>(
                              context: context,
                              builder: (context) => EditTask(
                                task: task,
                              ),
                            );
                            if (context.mounted && result != null) {
                              await context.read<DashboardCubit>().getTasks();
                              if (context.mounted) {
                                MPRSnackBar(
                                  text:
                                      result ? 'Task updated' : 'Task deleted',
                                  actionLabel: 'Close',
                                  actionOnPressed: () =>
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar(),
                                ).show(context);
                              }
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 22,
                            color: ColorPalette.gunmetal,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 22,
                        width: 22,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            final result = await showDialog<bool?>(
                              context: context,
                              builder: (context) => AddCompletedTask(
                                description: task.description,
                                points: task.points,
                              ),
                            );
                            if (context.mounted && result != null && result) {
                              await context
                                  .read<DashboardCubit>()
                                  .initializeDashboard();
                            }
                          },
                          icon: Icon(
                            Icons.add_circle_sharp,
                            size: 22,
                            color: ColorPalette.green,
                          ),
                        ),
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
