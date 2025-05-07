part of 'edit_reward_cubit.dart';

class EditRewardState {
  final EditRewardStatus status;
  final String description;
  final String value;
  final String? link;
  final int isGoal;

  const EditRewardState({
    required this.status,
    required this.description,
    required this.value,
    this.link,
    required this.isGoal,
  });

  EditRewardState copyWith({
    EditRewardStatus? status,
    String? description,
    String? value,
    String? link,
    int? isGoal,
  }) {
    return EditRewardState(
      status: status ?? this.status,
      description: description ?? this.description,
      value: value ?? this.value,
      link: link ?? this.link,
      isGoal: isGoal ?? this.isGoal,
    );
  }

  bool get updateEnabled => description.isNotEmpty && value.isNotEmpty;

  List<Object> get props => [
        status,
        description,
        value,
        isGoal,
      ];
}

enum EditRewardStatus {
  initial,
  descriptionChanged,
  valueChanged,
  linkChanged,
  isGoalChanged,
  addingReward,
  success,
  failure,
}
