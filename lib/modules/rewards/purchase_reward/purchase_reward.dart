import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/modules/rewards/purchase_reward/cubit/purchase_reward_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class PurchaseReward extends StatelessWidget {
  final Reward reward;
  final String availablePoints;

  const PurchaseReward({
    super.key,
    required this.reward,
    required this.availablePoints,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PurchaseRewardCubit>(
      create: (_) => PurchaseRewardCubit(
        reward: reward,
        availablePoints: availablePoints,
      ),
      child: BlocConsumer<PurchaseRewardCubit, PurchaseRewardState>(
        listener: (context, state) {
          if (state.status == PurchaseRewardStatus.success) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final cubit = context.read<PurchaseRewardCubit>();
          return Dialog(
            insetPadding: const EdgeInsets.all(38),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height:
                    state.status == PurchaseRewardStatus.failure ? 380 : 360,
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
                        'Purchase Reward',
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
                                reward.description,
                                style: MPRTextStyles.regularSemiBold,
                              ),
                              Text(
                                '${reward.value}pts',
                                style: MPRTextStyles.regularSemiBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      _DatePicker(),
                      SizedBox(height: 18.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorPalette.gunmetal.shade100,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 6.0,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Available Points',
                                          style: MPRTextStyles.regular,
                                        ),
                                        Text(
                                          'Reward Cost',
                                          style: MPRTextStyles.regular,
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Remaining Points',
                                          style: MPRTextStyles.regularSemiBold,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 18.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${availablePoints}pts',
                                          style: MPRTextStyles.regular,
                                        ),
                                        Text(
                                          '${reward.value}pts',
                                          style: MPRTextStyles.regular,
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '${int.parse(availablePoints) - reward.value}pts',
                                          style: MPRTextStyles.regularSemiBold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: MPRButton.primary(
                          height: 40,
                          text: 'Confirm Purchase',
                          onPressed: () async {
                            await cubit.addPurchasedReward();
                          },
                        ),
                      ),
                      if (state.status == PurchaseRewardStatus.failure)
                        MPRFailureText(text: 'Failed to purchase reward'),
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
    final cubit = context.read<PurchaseRewardCubit>();
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
        label: 'Date',
        contentPadding: EdgeInsets.only(left: 8),
        controller: cubit.dateTextController,
        isEnabled: false,
        whiteFill: true,
        suffixIconType: SuffixIconType.calendar,
      ),
    );
  }
}
