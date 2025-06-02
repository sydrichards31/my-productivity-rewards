import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/modules/daily_checklist.dart/daily_checklist.dart';
import 'package:my_productive_rewards/modules/dashboard/add_completed_task/add_completed_task.dart';
import 'package:my_productive_rewards/modules/dashboard/add_new_task/add_new_task.dart';
import 'package:my_productive_rewards/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:my_productive_rewards/modules/dashboard/edit_task/edit_task.dart';
import 'package:my_productive_rewards/modules/settings/settings.dart';
import 'package:my_productive_rewards/modules/tabs/cubit/bottom_tabs_cubit.dart';
import 'package:my_productive_rewards/services/feature_flag_service.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final featureFlagService = GetIt.I<FeatureFlagService>();
    return BlocProvider<DashboardCubit>(
      create: (_) => DashboardCubit()..initializeDashboard(),
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state.status == DashboardStatus.completedTaskAdded) {
            context.read<BottomTabsCubit>().resetAllTabs();
            MPRSnackBar(
              text: 'Completed task saved',
              actionLabel: 'Close',
              actionOnPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ).show(context);
          }
        },
        builder: (context, state) {
          Widget bodyWidget = const SizedBox.shrink();
          if (state.status == DashboardStatus.loading) {
            bodyWidget = Center(child: MPRLoader.circular());
          } else if (state.status == DashboardStatus.failure) {
            bodyWidget = Center(child: Text('Unable to load data'));
          } else if (state.tasks.isEmpty) {
            bodyWidget = Center(child: Text('No tasks saved'));
          } else {
            bodyWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.points.isNotEmpty)
                  _Points(
                    points: state.points,
                    goalPoints: state.goalPoints,
                  ),
                if (featureFlagService
                    .isEnabled(FeatureFlag.dailyChecklist)) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      right: 12,
                      top: int.tryParse(state.goalPoints) == null ? 12 : 2,
                    ),
                    child: Text(
                      'Daily Checklist',
                      style: MPRTextStyles.extraLargeSemiBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 8,
                      bottom: 14,
                    ),
                    child: MPRButton.primary(
                      text: 'Add Daily Checklist',
                      onPressed: () => Navigator.push(
                        context,
                        MPRRoute(widget: DailyChecklist()),
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12,
                    top: int.tryParse(state.goalPoints) == null ? 12 : 2,
                  ),
                  child: Text(
                    'My Tasks',
                    style: MPRTextStyles.extraLargeSemiBold,
                  ),
                ),
                _SearchBar(),
                if (state.filteredTasks.isEmpty)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 22.0),
                        child: Text('No search results'),
                      ),
                    ),
                  )
                else
                  _MyTasks(tasks: state.filteredTasks),
              ],
            );
          }
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: MPRAppBar(
                title: 'Dashboard',
                trailingActions: [
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
                            builder: (_) => Settings(
                              tabsCubit: context.read<BottomTabsCubit>(),
                            ),
                          ),
                        ).then((_) {
                          if (context.mounted) {
                            context
                                .read<DashboardCubit>()
                                .initializeDashboard();
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
              resizeToAvoidBottomInset: false,
              floatingActionButton: SpeedDial(
                icon: Icons.add,
                activeIcon: Icons.close,
                spacing: 10,
                spaceBetweenChildren: 4,
                backgroundColor: ColorPalette.green,
                overlayColor: ColorPalette.platinum.shade200,
                children: [
                  SpeedDialChild(
                    onTap: () async {
                      final result = await showDialog<bool?>(
                        context: context,
                        builder: (context) => AddNewTask(),
                      );
                      if (context.mounted && result != null) {
                        await context.read<DashboardCubit>().getTasks();
                      }
                    },
                    child: Icon(Icons.list),
                    labelWidget: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Add New Task',
                        style: MPRTextStyles.regular,
                      ),
                    ),
                  ),
                  SpeedDialChild(
                    onTap: () async {
                      final result = await showDialog<String?>(
                        context: context,
                        builder: (context) => AddCompletedTask.custom(),
                      );
                      if (context.mounted && result != null) {
                        context
                            .read<DashboardCubit>()
                            .completedTaskAdded(result);
                      }
                    },
                    child: Icon(Icons.check),
                    labelWidget: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Add Custom Completed Task',
                        style: MPRTextStyles.regular,
                      ),
                    ),
                  ),
                  if (featureFlagService.isEnabled(FeatureFlag.dailyChecklist))
                    SpeedDialChild(
                      onTap: () => Navigator.push(
                        context,
                        MPRRoute(
                          widget: DailyChecklist(),
                        ),
                      ),
                      child: Icon(Icons.event),
                      labelWidget: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'Add Daily Checklist',
                          style: MPRTextStyles.regular,
                        ),
                      ),
                    ),
                ],
              ),
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
        MPRPointsHeader(points: points, topText: 'TOTAL', bottomText: 'POINTS'),
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
                            final result = await showDialog<String?>(
                              context: context,
                              builder: (context) => AddCompletedTask.normal(
                                description: task.description,
                                points: task.points,
                              ),
                            );
                            if (context.mounted && result != null) {
                              context
                                  .read<DashboardCubit>()
                                  .completedTaskAdded(result);
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: MPRSearchBar(
        searchLabel: 'Search tasks',
        onClear: () => cubit.searchCleared(),
        backgroundColor: Colors.white,
        searchController: cubit.searchBarTextField,
        cornerRadius: 4,
        onEditingComplete: () {
          cubit.taskSearched();
        },
        onQueryChanged: (_) {
          cubit.taskSearched();
        },
      ),
    );
  }
}
