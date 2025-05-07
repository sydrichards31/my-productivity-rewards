import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/task.dart';
import 'package:my_productive_rewards/modules/dashboard/edit_task/cubit/edit_task_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class EditTask extends StatelessWidget {
  final Task task;
  const EditTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditTaskCubit>(
      create: (_) => EditTaskCubit(task: task),
      child: BlocBuilder<EditTaskCubit, EditTaskState>(
        builder: (context, state) {
          final cubit = context.read<EditTaskCubit>();
          return Dialog(
            insetPadding: const EdgeInsets.all(38),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height: state.status == EditTaskStatus.failure ? 380 : 360,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 14,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit Task',
                        style: MPRTextStyles.largeSemiBold,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Enter the name of the task and its point value below.',
                        style: MPRTextStyles.regular,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        height: 42,
                        child: MPRTextField.filledSmall(
                          label: 'Description',
                          controller: cubit.descriptionTextController,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          onChanged: (value) => cubit.descriptionChanged(value),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        height: 42,
                        child: MPRTextField.filledSmall(
                          label: 'Points',
                          controller: cubit.pointsTextController,
                          keyboardType: TextInputType.number,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          onChanged: (value) => cubit.pointsChanged(value),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: MPRButton.primary(
                          height: 42,
                          text: 'Save and Close',
                          onPressed:
                              (state.updateEnabled && task.taskId != null)
                                  ? () async {
                                      final result =
                                          await cubit.updateTask(task.taskId!);
                                      if (context.mounted && result) {
                                        Navigator.pop(context, true);
                                      }
                                    }
                                  : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: MPRButton.secondary(
                          borderColor: ColorPalette.gunmetal.shade100,
                          height: 42,
                          hasHorizontalPadding: false,
                          text: 'Delete Task',
                          onPressed: () async {
                            cubit.deleteTask(task.taskId!);
                            Navigator.pop(context, false);
                          },
                        ),
                      ),
                      if (state.status == EditTaskStatus.failure)
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Failed to update task',
                            style: MPRTextStyles.regular
                                .copyWith(color: ColorPalette.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
