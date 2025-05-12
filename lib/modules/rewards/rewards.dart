import 'package:amazon_image/amazon_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/modules/rewards/add_new_reward/add_new_reward.dart';
import 'package:my_productive_rewards/modules/rewards/cubit/my_rewards_cubit.dart';
import 'package:my_productive_rewards/modules/rewards/edit_reward/edit_reward.dart';
import 'package:my_productive_rewards/modules/rewards/purchase_reward/purchase_reward.dart';
import 'package:my_productive_rewards/modules/rewards/rewards_filter_tab.dart';
import 'package:my_productive_rewards/modules/settings/settings.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class Rewards extends StatelessWidget {
  const Rewards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyRewardsCubit>(
      create: (_) => MyRewardsCubit()..initializeMyRewards(),
      child: BlocBuilder<MyRewardsCubit, MyRewardsState>(
        builder: (context, state) {
          Widget bodyWidget = const SizedBox.shrink();
          if (state.status == MyRewardsStatus.loading) {
            bodyWidget = Center(child: MPRLoader.circular());
          } else if (state.status == MyRewardsStatus.failure) {
            bodyWidget = Center(child: Text('Unable to load data'));
          } else if ((state.status == MyRewardsStatus.loaded ||
                  state.status == MyRewardsStatus.rewardsUpdated) &&
              state.rewards.isEmpty) {
            bodyWidget = Center(
              child: Text(
                'No rewards saved',
                style: MPRTextStyles.large,
              ),
            );
          } else if ((state.status != MyRewardsStatus.loading &&
                  state.status != MyRewardsStatus.failure) &&
              state.rewards.isNotNullOrEmpty) {
            bodyWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPRPointsHeader(
                  points: state.points,
                  topText: 'POINTS',
                  bottomText: 'AVAILABLE',
                ),
                MPRTabBar(
                  tabs: RewardsFilterTab.values
                      .map((e) => e.displayValue())
                      .toList(),
                  selectedTabIndex: 0,
                  onTabIndexChanged: (index) async => context
                      .read<MyRewardsCubit>()
                      .selectTab(RewardsFilterTab.values[index]),
                ),
                if (state.selectedTab == RewardsFilterTab.rewards) ...[
                  Expanded(child: _MyRewards(state: state)),
                ],
                if (state.selectedTab == RewardsFilterTab.purchased) ...[
                  Expanded(
                    child: _MyPurchasedRewards(rewards: state.purchasedRewards),
                  ),
                ],
              ],
            );
          }
          return Scaffold(
            appBar: MPRAppBar(
              title: 'Rewards',
              trailingActions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Settings(),
                    ),
                  ),
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            backgroundColor: ColorPalette.gunmetal.shade50,
            body: bodyWidget,
            floatingActionButton: FloatingActionButton(
              heroTag: 'rewards',
              backgroundColor: ColorPalette.green,
              child: const Icon(Icons.add),
              onPressed: () async {
                final result = await showDialog<bool?>(
                  context: context,
                  builder: (context) => AddNewReward(),
                );
                if (context.mounted && result != null && result) {
                  await context.read<MyRewardsCubit>().initializeMyRewards();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _MyRewards extends StatelessWidget {
  final MyRewardsState state;
  const _MyRewards({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return state.rewards.isEmpty
        ? Center(
            child: Text(
              'No rewards',
              style: MPRTextStyles.regular,
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final reward = state.rewards[index];
              final cubit = context.read<MyRewardsCubit>();
              return Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorPalette.gunmetal.shade100),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 10,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (reward.link.isNotNullOrEmpty) ...[
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: AmazonImage(reward.link!),
                              ),
                              const SizedBox(width: 12),
                            ] else ...[
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                  context
                                      .read<AppTheme>()
                                      .images
                                      .placeholderImage,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 2),
                                  child: Text(
                                    reward.description,
                                    style: MPRTextStyles.largeSemiBold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '${reward.value} pts',
                                    style: MPRTextStyles.large,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 52,
                                      height: 32,
                                      child: TextButton(
                                        child: Text(
                                          'EDIT',
                                          style: MPRTextStyles.regularBold
                                              .copyWith(
                                            color: ColorPalette.green,
                                          ),
                                        ),
                                        onPressed: () async {
                                          final cubit =
                                              context.read<MyRewardsCubit>();
                                          cubit.editingReward();
                                          final result =
                                              await showDialog<bool?>(
                                            context: context,
                                            builder: (context) => EditReward(
                                              reward: reward,
                                            ),
                                          );
                                          if (context.mounted &&
                                              result != null) {
                                            await context
                                                .read<MyRewardsCubit>()
                                                .getRewards();
                                            if (context.mounted && result) {
                                              MPRSnackBar(
                                                text: 'Reward updated',
                                                actionLabel: 'Close',
                                                actionOnPressed: () =>
                                                    ScaffoldMessenger.of(
                                                  context,
                                                ).hideCurrentSnackBar(),
                                              ).show(context);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      height: 32,
                                      child: TextButton(
                                        child: Text(
                                          'DELETE',
                                          style: MPRTextStyles.regularBold
                                              .copyWith(color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          final result =
                                              await _showDeleteConfirmationDialog(
                                            context,
                                          );
                                          if (result && context.mounted) {
                                            cubit.deleteReward(reward.rewardId);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: IconButton(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  if (int.parse(state.points) < reward.value) {
                                    await _showNotEnoughPointsDialog(context);
                                  } else {
                                    final result = await showDialog<bool?>(
                                      context: context,
                                      builder: (context) => PurchaseReward(
                                        reward: reward,
                                        availablePoints: state.points,
                                      ),
                                    );
                                    if (context.mounted &&
                                        result != null &&
                                        result) {
                                      await context
                                          .read<MyRewardsCubit>()
                                          .initializeMyRewards();
                                      if (context.mounted) {
                                        MPRSnackBar(
                                          text: 'Reward purchased!',
                                          actionLabel: 'Close',
                                          actionOnPressed: () =>
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar(),
                                        ).show(context);
                                      }
                                    }
                                  }
                                },
                                icon: SvgAdapter.asset(
                                  context.read<AppTheme>().images.buy,
                                  color: ColorPalette.gunmetal,
                                ),
                              ),
                            ),
                            if (reward.isGoal == 1) ...[
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: SvgAdapter.asset(
                                    context.read<AppTheme>().images.goal,
                                    color: ColorPalette.green,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: state.rewards.length,
          );
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => MPRAlertDialog(
            title: 'Delete Reward',
            message:
                'Are you sure you want to delete this reward? This action cannot be undone.',
            actions: [
              MPRButton.tertiaryCompact(
                text: 'Cancel',
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              MPRButton.tertiaryCompact(
                text: 'Delete',
                useSemiBoldFont: true,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _showNotEnoughPointsDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => MPRAlertDialog(
        title: 'Not Enough Points',
        message: 'You do not have enough points saved to purchase this reward.',
        actions: [
          MPRButton.tertiaryCompact(
            text: 'OK',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _MyPurchasedRewards extends StatelessWidget {
  final List<PurchasedReward> rewards;
  const _MyPurchasedRewards({
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    return rewards.isEmpty
        ? Center(
            child: Text(
              'No purchased rewards',
              style: MPRTextStyles.regular,
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorPalette.gunmetal.shade100),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        if (reward.link.isNotNullOrEmpty) ...[
                          const SizedBox(width: 2),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: AmazonImage(reward.link!),
                          ),
                          const SizedBox(width: 12),
                        ] else ...[
                          const SizedBox(width: 2),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              context.read<AppTheme>().images.placeholderImage,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 2),
                              child: Text(
                                reward.description,
                                style: MPRTextStyles.largeSemiBold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '${reward.value} pts',
                                style: MPRTextStyles.large,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 4,
                              ),
                              child: Text(
                                'Purchased on ${reward.date}',
                                style: MPRTextStyles.regular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: rewards.length,
          );
  }
}
