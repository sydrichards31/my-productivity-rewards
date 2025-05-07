import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  final int? rewardId;
  final String description;
  final int value;
  final String? link;
  final int isGoal;

  const Reward({
    this.rewardId,
    required this.description,
    required this.value,
    this.link,
    this.isGoal = 0,
  });

  @override
  List<Object?> get props => [
        description,
        value,
        isGoal,
      ];
}
