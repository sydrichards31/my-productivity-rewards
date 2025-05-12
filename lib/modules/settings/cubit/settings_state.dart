part of 'settings_cubit.dart';

class SettingsState {
  final SettingsStatus status;
  final String goalPoints;

  const SettingsState({
    required this.status,
    required this.goalPoints,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    String? goalPoints,
  }) {
    return SettingsState(
      status: status ?? this.status,
      goalPoints: goalPoints ?? this.goalPoints,
    );
  }

  List<Object> get props => [
        status,
        goalPoints,
      ];
}

enum SettingsStatus {
  initial,
  goalPointsChanged,
  loaded,
  tasksCleared,
  taskLogCleared,
  rewardsCleared,
  purchasedRewardsCleared,
  allDataCleared,
  failure,
}
