import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/modules/dashboard/dashboard.dart';
import 'package:my_productive_rewards/modules/my_rewards/my_rewards.dart';
import 'package:my_productive_rewards/modules/tabs/bottom_tab_item.dart';
import 'package:my_productive_rewards/modules/tabs/bottom_tab_type.dart';
import 'package:my_productive_rewards/modules/tabs/cubit/bottom_tabs_cubit.dart';
import 'package:my_productive_rewards/modules/task_log/task_log.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/svg_adapter.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    List<BottomTabBarItem> bottomTabBarItems = _buildBottomTabs(context);
    Map<BottomTabType, Widget> tabsWidgets = {
      for (final item in bottomTabBarItems)
        item.tabType: const SizedBox.shrink(),
    };
    return BlocProvider<BottomTabsCubit>(
      create: (_) => BottomTabsCubit(
        tabs: bottomTabBarItems.map((e) => e.tabType).toList(),
      ),
      child: BlocConsumer<BottomTabsCubit, BottomTabsState>(
        listener: (context, state) {
          if (state is ResetAllTabsSuccess) {
            bottomTabBarItems = _buildBottomTabs(context);
            tabsWidgets = {
              for (final item in bottomTabBarItems)
                item.tabType: const SizedBox.shrink(),
            };
          }
        },
        buildWhen: (previous, current) => current is ResetAllTabsSuccess,
        builder: (context, state) {
          return BlocBuilder<BottomTabsCubit, BottomTabsState>(
            buildWhen: (previous, current) =>
                previous.selectedTab != current.selectedTab,
            builder: (context, state) {
              final appTheme = context.read<AppTheme>();
              final tabsCubit = context.read<BottomTabsCubit>();
              final selectedTabIndex = state.tabs.indexOf(state.selectedTab);
              if (tabsWidgets[state.selectedTab] is SizedBox) {
                tabsWidgets[state.selectedTab] =
                    bottomTabBarItems[selectedTabIndex].builder.call(context);
              }
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: IndexedStack(
                  index: selectedTabIndex,
                  children: tabsWidgets.values.toList(),
                ),
                bottomNavigationBar: bottomTabBarItems.length > 1
                    ? BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: ColorPalette.green,
                        items: bottomTabBarItems
                            .map(
                              (e) => _buildBottomNavigationBarItem(
                                icon: e.icon,
                                label: e.label,
                                colorPalette: appTheme.colorPalette,
                              ),
                            )
                            .toList(),
                        currentIndex: selectedTabIndex,
                        onTap: (index) async =>
                            tabsCubit.selectTab(state.tabs[index]),
                        selectedItemColor: ColorPalette.platinum.shade500,
                        selectedLabelStyle: MPRTextStyles.regularSemiBold,
                        unselectedItemColor: Colors.black,
                        unselectedLabelStyle: MPRTextStyles.regular,
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}

List<BottomTabBarItem> _buildBottomTabs(BuildContext context) {
  final appTheme = context.read<AppTheme>();
  return [
    BottomTabBarItem(
      tabType: BottomTabType.dashboard,
      title: "Dashboard",
      icon: appTheme.images.home,
      label: "Dashboard",
      builder: (context) => const Dashboard(),
    ),
    BottomTabBarItem(
      tabType: BottomTabType.taskLog,
      title: "Task Log",
      icon: appTheme.images.taskLog,
      label: "Task Log",
      builder: (context) => const TaskLog(),
    ),
    BottomTabBarItem(
      tabType: BottomTabType.rewards,
      title: "Rewards",
      icon: appTheme.images.reward,
      label: "Rewards",
      builder: (context) => const Rewards(),
    ),
  ];
}

BottomNavigationBarItem _buildBottomNavigationBarItem({
  required String icon,
  required String label,
  required ColorPalette colorPalette,
}) {
  return BottomNavigationBarItem(
    icon: SvgAdapter.asset(icon, width: 25, height: 25, color: Colors.black),
    activeIcon: SvgAdapter.asset(
      icon,
      width: 25,
      height: 25,
      color: ColorPalette.platinum.shade500,
    ),
    label: label,
  );
}
