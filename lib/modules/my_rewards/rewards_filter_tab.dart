enum RewardsFilterTab {
  rewards,
  purchased,
}

extension RewardsFilterTabToString on RewardsFilterTab {
  String displayValue() {
    switch (this) {
      case RewardsFilterTab.rewards:
        return 'My Rewards';
      case RewardsFilterTab.purchased:
        return 'Purchased Rewards';
    }
  }
}
