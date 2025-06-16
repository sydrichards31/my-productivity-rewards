part of 'purchase_reward_cubit.dart';

class PurchaseRewardState {
  final PurchaseRewardStatus status;
  final DateTime? selectedDate;
  final String? totalPoints;
  final String? exception;

  const PurchaseRewardState({
    required this.status,
    required this.selectedDate,
    this.totalPoints,
    this.exception,
  });

  PurchaseRewardState copyWith({
    PurchaseRewardStatus? status,
    DateTime? selectedDate,
    String? totalPoints,
    String? exception,
  }) {
    return PurchaseRewardState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      totalPoints: totalPoints ?? this.totalPoints,
      exception: exception ?? this.exception,
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
