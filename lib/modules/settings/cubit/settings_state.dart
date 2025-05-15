part of 'settings_cubit.dart';

class SettingsState {
  final SettingsStatus status;

  const SettingsState({
    required this.status,
  });

  SettingsState copyWith({
    SettingsStatus? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
    );
  }

  List<Object> get props => [
        status,
      ];
}

enum SettingsStatus {
  initial,
  tasksCleared,
  taskLogCleared,
  rewardsCleared,
  purchasedRewardsCleared,
  pointsCleared,
  allDataCleared,
}
