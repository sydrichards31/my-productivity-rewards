// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/modules/tabs/bottom_tab_type.dart';
import 'package:uuid/uuid.dart';

part 'bottom_tabs_state.dart';

class BottomTabsCubit extends Cubit<BottomTabsState> {
  BottomTabsCubit({
    required List<BottomTabType> tabs,
  }) : super(
          BottomTabsState(
            tabs: tabs,
            selectedTab: tabs.first,
          ),
        );

  Future<void> selectTab(BottomTabType tab) async {
    if (!state.tabs.contains(tab)) return;
    emit(state.copyWith(selectedTab: tab));
  }

  void resetAllTabs({
    BottomTabType? selectedTab,
  }) {
    emit(
      ResetAllTabsSuccess(
        tabs: state.tabs,
        selectedTab: selectedTab ?? state.selectedTab,
      ),
    );
  }
}
