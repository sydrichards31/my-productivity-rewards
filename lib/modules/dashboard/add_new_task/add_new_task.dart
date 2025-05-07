import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/modules/dashboard/add_new_task/cubit/add_new_task_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class AddNewTask extends StatelessWidget {
  const AddNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddNewTaskCubit>(
      create: (_) => AddNewTaskCubit(),
      child: BlocBuilder<AddNewTaskCubit, AddNewTaskState>(
        builder: (context, state) {
          final cubit = context.read<AddNewTaskCubit>();
          return Dialog(
            insetPadding: const EdgeInsets.all(38),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height: state.status == AddNewTaskStatus.failure ? 320 : 300,
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
                        'Add Task',
                        style: MPRTextStyles.largeSemiBold,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Enter the name of the task you would like to add along with its point value.',
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
                          height: 40,
                          text: 'Save and Close',
                          onPressed: state.addEnabled
                              ? () async {
                                  final result = await cubit.addTask();
                                  if (context.mounted && result) {
                                    Navigator.pop(context, true);
                                  }
                                }
                              : null,
                        ),
                      ),
                      if (state.status == AddNewTaskStatus.failure)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Failed to add task',
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
