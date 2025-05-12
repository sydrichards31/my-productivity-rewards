import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/modules/rewards/edit_reward/cubit/edit_reward_cubit.dart';
import 'package:my_productive_rewards/services/navigation_service.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class EditReward extends StatelessWidget {
  final Reward reward;
  const EditReward({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditRewardCubit>(
      create: (_) => EditRewardCubit(reward: reward),
      child: BlocConsumer<EditRewardCubit, EditRewardState>(
        listener: (context, state) {
          if (state.status == EditRewardStatus.success) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final cubit = context.read<EditRewardCubit>();
          return Dialog(
            insetPadding: const EdgeInsets.all(30),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height: state.status == EditRewardStatus.failure ? 425 : 405,
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
                        'Edit Reward',
                        style: MPRTextStyles.largeSemiBold,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Enter the description, point value, and photo link of the reward.',
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
                          label: 'Link',
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
                          height: 42,
                          text: 'Save and Close',
                          onPressed: (state.updateEnabled &&
                                  reward.rewardId != null)
                              ? () async {
                                  await cubit.updateReward(reward.rewardId!);
                                  if (context.mounted) {
                                    Navigator.pop(context, true);
                                  }
                                }
                              : null,
                        ),
                      ),
                      if (state.status == EditRewardStatus.failure)
                        MPRFailureText(text: 'Failed to update reward'),
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
