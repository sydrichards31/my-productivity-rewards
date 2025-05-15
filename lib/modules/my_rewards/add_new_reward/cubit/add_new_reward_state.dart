part of 'add_new_reward_cubit.dart';

class AddNewRewardState {
  final AddNewRewardStatus status;
  final String description;
  final String value;
  final String? link;
  final int isGoal;

  const AddNewRewardState({
    required this.status,
    required this.description,
    required this.value,
    this.link,
    required this.isGoal,
  });

  AddNewRewardState copyWith({
    AddNewRewardStatus? status,
    String? description,
    String? value,
    String? link,
    int? isGoal,
  }) {
    return AddNewRewardState(
      status: status ?? this.status,
      description: description ?? this.description,
      value: value ?? this.value,
      link: link ?? this.link,
      isGoal: isGoal ?? this.isGoal,
    );
  }

  bool get addEnabled => description.isNotEmpty && value.isNotEmpty;

  List<Object> get props => [
        status,
        description,
        value,
        isGoal,
      ];
}

enum AddNewRewardStatus {
  initial,
  descriptionChanged,
  valueChanged,
  linkChanged,
  isGoalChanged,
  addingReward,
  success,
  failure,
}
