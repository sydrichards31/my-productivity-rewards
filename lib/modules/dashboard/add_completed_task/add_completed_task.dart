import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/modules/dashboard/add_completed_task/cubit/add_completed_task_cubit.dart';
import 'package:my_productive_rewards/modules/tabs/cubit/bottom_tabs_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class AddCompletedTask extends StatelessWidget {
  final String description;
  final int points;
  const AddCompletedTask({
    super.key,
    required this.description,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCompletedTaskCubit>(
      create: (_) => AddCompletedTaskCubit(
        description: description,
        points: points,
      ),
      child: BlocConsumer<AddCompletedTaskCubit, AddCompletedTaskState>(
        listener: (context, state) {
          if (state.status == AddCompletedTaskStatus.success) {
            Navigator.pop(context, state.totalPoints);
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
          final cubit = context.read<AddCompletedTaskCubit>();
          return Dialog(
            insetPadding: const EdgeInsets.all(38),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height:
                    state.status == AddCompletedTaskStatus.failure ? 310 : 285,
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
                        'Add Completed Task',
                        style: MPRTextStyles.extraLargeSemiBold,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorPalette.platinum.shade500,
                          border: Border.all(
                            color: ColorPalette.gunmetal.shade100,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                description,
                                style: MPRTextStyles.regularSemiBold,
                              ),
                              Text(
                                '${points}pts',
                                style: MPRTextStyles.regularSemiBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Date',
                        style:
                            MPRTextStyles.largeSemiBold.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 2),
                      _DatePicker(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: MPRButton.primary(
                          height: 40,
                          text: 'Save and Close',
                          onPressed: () async {
                            await cubit.addCompletedTask();
                          },
                        ),
                      ),
                      if (state.status == AddCompletedTaskStatus.failure)
                        MPRFailureText(text: 'Failed to add completed task'),
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

class _DatePicker extends StatelessWidget with MPRDatePickerMixin {
  const _DatePicker();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddCompletedTaskCubit>();
    return GestureDetector(
      onTap: () {
        showMPRDatePicker(
          context: context,
          initialDate: cubit.state.selectedDate ?? DateTime.now(),
          lastDate: DateTime.now(),
        ).then((value) {
          cubit.dateChanged(value);
        });
      },
      child: MPRTextField.filledSmall(
        contentPadding: EdgeInsets.only(left: 8),
        controller: cubit.dateTextController,
        isEnabled: false,
        whiteFill: true,
        suffixIconType: SuffixIconType.calendar,
      ),
    );
  }
}
