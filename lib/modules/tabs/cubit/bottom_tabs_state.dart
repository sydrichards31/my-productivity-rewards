part of 'bottom_tabs_cubit.dart';

class BottomTabsState {
  final List<BottomTabType> tabs;
  final BottomTabType selectedTab;

  const BottomTabsState({
    required this.tabs,
    required this.selectedTab,
  });

  BottomTabsState copyWith({
    List<BottomTabType>? tabs,
    BottomTabType? selectedTab,
  }) {
    return BottomTabsState(
      tabs: tabs ?? this.tabs,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  List<Object> get props => [
        tabs,
        selectedTab,
      ];
}

class ResetAllTabsSuccess extends BottomTabsState {
  const ResetAllTabsSuccess({
    required super.tabs,
    required super.selectedTab,
  });

  @override
  List<Object> get props => [
        ...super.props,
        const Uuid().v4(),
      ];
}

class ResetTabSuccess extends BottomTabsState {
  const ResetTabSuccess({
    required super.tabs,
    required super.selectedTab,
  });

  @override
  List<Object> get props => [
        ...super.props,
        const Uuid().v4(),
      ];
}
