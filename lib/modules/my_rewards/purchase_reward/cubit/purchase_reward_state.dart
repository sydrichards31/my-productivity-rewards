part of 'purchase_reward_cubit.dart';

class PurchaseRewardState {
  final PurchaseRewardStatus status;
  final DateTime? selectedDate;
  final String? totalPoints;

  const PurchaseRewardState({
    required this.status,
    required this.selectedDate,
    this.totalPoints,
  });

  PurchaseRewardState copyWith({
    PurchaseRewardStatus? status,
    DateTime? selectedDate,
    String? totalPoints,
  }) {
    return PurchaseRewardState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }

  List<Object> get props => [
        status,
      ];
}

enum PurchaseRewardStatus {
  initial,
  dateChanged,
  addingTask,
  success,
  failure,
}
