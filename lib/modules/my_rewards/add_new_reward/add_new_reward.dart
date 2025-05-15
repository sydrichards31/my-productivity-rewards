import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/modules/my_rewards/add_new_reward/cubit/add_new_reward_cubit.dart';
import 'package:my_productive_rewards/services/navigation_service.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class AddNewReward extends StatelessWidget {
  const AddNewReward({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddNewRewardCubit>(
      create: (_) => AddNewRewardCubit(),
      child: BlocConsumer<AddNewRewardCubit, AddNewRewardState>(
        listener: (context, state) {
          if (state.status == AddNewRewardStatus.success) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddNewRewardCubit>();
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: MPRAppBar(title: 'New Reward'),
              backgroundColor: Colors.white,
              body: Padding(
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
                      'Add Reward',
                      style: MPRTextStyles.largeSemiBold,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Enter the description of the reward you would like to add along with its point value.',
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
                        autoCorrect: false,
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
                        label: 'Value',
                        controller: cubit.valueTextController,
                        keyboardType: TextInputType.number,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        onChanged: (value) => cubit.valueChanged(value),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      height: 42,
                      child: MPRTextField.filledSmall(
                        label: 'Image Link',
                        autoCorrect: false,
                        controller: cubit.linkTextController,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        onChanged: (value) => cubit.linkChanged(value),
                      ),
                    ),
                    const SizedBox(height: 8),
                    MPRCheckboxLine(
                      value: state.isGoal == 1,
                      text: 'Current goal',
                      onChanged: (isGoal) => cubit.setIsGoal(isGoal),
                      infoIcon: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: IconButton(
                            onPressed: () {
                              _showCurrentGoalInfo(context);
                            },
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.info,
                              color: ColorPalette.gunmetal.shade300,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: MPRButton.primary(
                        height: 40,
                        text: 'Save and Close',
                        onPressed: state.addEnabled
                            ? () async {
                                await cubit.addReward();
                              }
                            : null,
                      ),
                    ),
                    if (state.status == AddNewRewardStatus.failure)
                      MPRFailureText(text: 'Failed to add reward'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCurrentGoalInfo(BuildContext context) {
    MPRAlertDialog.customChild(
      title: 'Current Goal',
      actions: [
        MPRButton.tertiaryCompact(
          text: 'Close',
          onPressed: () {
            GetIt.I<NavigationService>().pop();
          },
        ),
      ],
      contentPadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
      child: SizedBox(
        width: double.maxFinite,
        child: Text(
          'This will set your current goal to this reward. You can only have one goal at a time. If you have another reward set as the goal it will be switched to this one.',
          style: MPRTextStyles.regular,
        ),
      ),
    ).show(context: context);
  }
}
