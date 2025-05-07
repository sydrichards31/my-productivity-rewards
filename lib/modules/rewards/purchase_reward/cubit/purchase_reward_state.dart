part of 'purchase_reward_cubit.dart';

class PurchaseRewardState {
  final PurchaseRewardStatus status;
  final DateTime? selectedDate;

  const PurchaseRewardState({
    required this.status,
    required this.selectedDate,
  });

  PurchaseRewardState copyWith({
    PurchaseRewardStatus? status,
    DateTime? selectedDate,
  }) {
    return PurchaseRewardState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
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
