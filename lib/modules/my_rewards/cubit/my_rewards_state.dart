part of 'my_rewards_cubit.dart';

class MyRewardsState extends Equatable {
  final MyRewardsStatus status;
  final List<Reward> rewards;
  final List<PurchasedReward> purchasedRewards;
  final String points;
  final RewardsFilterTab selectedTab;

  const MyRewardsState({
    required this.status,
    required this.rewards,
    required this.points,
    required this.purchasedRewards,
    required this.selectedTab,
  });

  MyRewardsState copyWith({
    MyRewardsStatus? status,
    List<Reward>? rewards,
    String? points,
    List<PurchasedReward>? purchasedRewards,
    RewardsFilterTab? selectedTab,
  }) {
    return MyRewardsState(
      status: status ?? this.status,
      rewards: rewards ?? this.rewards,
      points: points ?? this.points,
      purchasedRewards: purchasedRewards ?? this.purchasedRewards,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object> get props => [
        status,
        rewards,
        points,
        purchasedRewards,
        selectedTab,
      ];
}

enum MyRewardsStatus {
  loading,
  loaded,
  rewardsUpdated,
  rewardDeleted,
  editingReward,
  failure,
  rewardPurchased,
}
