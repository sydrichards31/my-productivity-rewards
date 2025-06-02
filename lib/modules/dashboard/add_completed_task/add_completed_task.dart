import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/modules/dashboard/add_completed_task/cubit/add_completed_task_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class AddCompletedTask extends StatelessWidget {
  final AddCompletedTaskType addCompletedTaskType;
  final String? description;
  final int? points;

  const AddCompletedTask._({
    required this.addCompletedTaskType,
    this.description,
    this.points,
  });

  factory AddCompletedTask.normal({
    required String description,
    required int points,
  }) =>
      AddCompletedTask._(
        addCompletedTaskType: AddCompletedTaskType.normal,
        description: description,
        points: points,
      );

  factory AddCompletedTask.custom() => AddCompletedTask._(
        addCompletedTaskType: AddCompletedTaskType.custom,
      );

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
                height: state.status == AddCompletedTaskStatus.failure
                    ? (addCompletedTaskType == AddCompletedTaskType.normal
                        ? 300
                        : 360)
                    : (addCompletedTaskType == AddCompletedTaskType.normal
                        ? 285
                        : 330),
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
                      Text(
                        addCompletedTaskType == AddCompletedTaskType.normal
                            ? 'Add Completed Task'
                            : 'Add Custom Completed Task',
                        style: MPRTextStyles.extraLargeSemiBold,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (addCompletedTaskType == AddCompletedTaskType.normal)
                        _ReadOnlyDescriptionAndPoints(
                          description: description!,
                          points: points!,
                        )
                      else
                        _AddDescriptionAndPoints(),
                      const SizedBox(
                        height: 22,
                      ),
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
        suffixIconType: SuffixIconType.calendar,
        disabledFillColor: ColorPalette.platinum.shade200,
        borderColor: ColorPalette.platinum.shade600,
      ),
    );
  }
}

class _ReadOnlyDescriptionAndPoints extends StatelessWidget {
  final String description;
  final int points;
  const _ReadOnlyDescriptionAndPoints({
    required this.description,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    );
  }
}

class _AddDescriptionAndPoints extends StatelessWidget {
  const _AddDescriptionAndPoints();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddCompletedTaskCubit>();
    return Column(
      children: [
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
      ],
    );
  }
}

enum AddCompletedTaskType {
  normal,
  custom,
}
