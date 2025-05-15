class PurchasedReward {
  final int? rewardId;
  final String description;
  final int value;
  final String? link;
  final String date;

  const PurchasedReward({
    this.rewardId,
    required this.description,
    required this.value,
    this.link,
    required this.date,
  });

  bool isInList(List<PurchasedReward>? rewards) {
    if (rewards == null) return false;
    bool contains = false;
    for (final reward in rewards) {
      if (reward.date == date &&
          reward.description == description &&
          reward.value == value &&
          reward.link == link) {
        contains = true;
      }
    }
    return contains;
  }
}
