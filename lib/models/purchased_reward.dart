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
}
