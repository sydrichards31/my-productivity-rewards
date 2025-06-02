import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/modules/daily_checklist.dart/cubit/daily_checklist_cubit.dart';
import 'package:my_productive_rewards/modules/daily_checklist.dart/daily_checklist_item.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class DailyChecklist extends StatelessWidget {
  const DailyChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailyChecklistCubit>(
      create: (_) => DailyChecklistCubit(),
      child: BlocConsumer<DailyChecklistCubit, DailyChecklistState>(
        listener: (context, state) {
          if (state.status == DailyChecklistStatus.success) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final cubit = context.read<DailyChecklistCubit>();
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: MPRAppBar(title: 'Create Daily Checklist'),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 14,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Daily Checklist',
                        style: MPRTextStyles.extraLargeSemiBold,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Enter all the tasks you would like to complete. The point value is for all tasks combined and will only be rewarded when you have finished all the tasks on the selected date.',
                        style: MPRTextStyles.regular,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        height: 42,
                        child: MPRTextField.filledSmall(
                          label: 'Point Value',
                          controller: cubit.valueTextController,
                          keyboardType: TextInputType.number,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          onChanged: (value) => cubit.valueChanged(value),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _DatePicker(),
                      Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 12),
                        child: const Text(
                          'Checklist Tasks',
                          style: MPRTextStyles.largeSemiBold,
                        ),
                      ),
                      Column(
                        children: [
                          for (final task in cubit.tasks.asMap().entries) ...[
                            _TaskTextField(
                              task: task,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 3.0,
                            top: 3,
                            bottom: 6,
                          ),
                          child: Semantics(
                            button: true,
                            child: InkWell(
                              onTap: () => cubit.addChecklistItem(),
                              child: Text(
                                'Add checklist task',
                                style: MPRTextStyles.regularBold.copyWith(
                                  color: ColorPalette.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: MPRButton.primary(
                          height: 40,
                          text: 'Save',
                          onPressed: () async {
                            await cubit.addChecklist();
                          },
                        ),
                      ),
                      if (state.status == DailyChecklistStatus.failure)
                        MPRFailureText(text: 'Failed to create checklist'),
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
    final cubit = context.read<DailyChecklistCubit>();
    return GestureDetector(
      onTap: () {
        showMPRDatePicker(
          context: context,
          initialDate: cubit.state.selectedDate,
        ).then((value) {
          cubit.dateChanged(value);
        });
      },
      child: MPRTextField.filledSmall(
        label: 'Date',
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

class _TaskTextField extends StatelessWidget {
  final MapEntry<int, DailyChecklistItem> task;

  const _TaskTextField({
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MPRTextField.filledSmall(
            key: task.value.globalKey,
            contentPadding: EdgeInsets.only(left: 8),
            whiteFill: true,
            label: 'Task description',
            controller: task.value.controller,
            focusNode: task.value.focusNode,
            suffixIconType: SuffixIconType.trash,
            suffixIconOnPressed: () => context
                .read<DailyChecklistCubit>()
                .deleteChecklistItem(task.key),
          ),
        ),
      ],
    );
  }
}
