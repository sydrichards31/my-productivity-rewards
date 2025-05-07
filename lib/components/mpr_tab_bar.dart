import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class MPRTabBar extends StatelessWidget {
  final List<String>? tabs;
  final int selectedTabIndex;
  final Function(int) onTabIndexChanged;
  final double? maxWidth;
  final bool compact;
  final TabController? tabControllerOverride;
  final List<Widget>? tabWidgetsOverride;

  const MPRTabBar({
    this.tabs,
    super.key,
    required this.selectedTabIndex,
    required this.onTabIndexChanged,
    this.maxWidth,
    this.compact = false,
    this.tabControllerOverride,
    this.tabWidgetsOverride,
  }) : assert(
          (tabs != null || tabWidgetsOverride != null) &&
              !(tabs != null && tabWidgetsOverride != null),
          'Please provide either tabs or tabWidgetsOverride',
        );

  @override
  Widget build(BuildContext context) {
    final length = tabs?.length ?? tabWidgetsOverride!.length;
    final tabWidths =
        tabs != null ? _calculateTabWidths(context, length) : <double>[];
    final bool hasMultipleTabs = length > 1;

    final List<Widget> tabWidgets = tabWidgetsOverride ??
        List.generate(length, (index) {
          return SizedBox(
            width: compact ? null : tabWidths[index],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: compact ? 8.0 : 0.0),
              child: Tab(
                text: tabs![index],
              ),
            ),
          );
        });

    return Column(
      children: [
        Material(
          color: ColorPalette.white,
          child: tabControllerOverride != null
              ? _buildTabBar(
                  tabWidgets: tabWidgets,
                  hasMultipleTabs: hasMultipleTabs,
                  tabControllerOverride: tabControllerOverride,
                )
              : DefaultTabController(
                  length: length,
                  initialIndex: selectedTabIndex,
                  child: _buildTabBar(
                    tabWidgets: tabWidgets,
                    hasMultipleTabs: hasMultipleTabs,
                  ),
                ),
        ),
        MPRDivider(),
      ],
    );
  }

  TabBar _buildTabBar({
    required List<Widget> tabWidgets,
    required bool hasMultipleTabs,
    TabController? tabControllerOverride,
  }) {
    return TabBar(
      controller: tabControllerOverride,
      tabs: tabWidgets,
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      indicatorWeight: 3,
      indicatorColor: ColorPalette.green,
      labelColor: ColorPalette.green,
      unselectedLabelColor: ColorPalette.gunmetal.shade300,
      labelStyle:
          MPRTextStyles.regularSemiBold.copyWith(color: ColorPalette.green),
      unselectedLabelStyle: MPRTextStyles.regularSemiBold
          .copyWith(color: ColorPalette.gunmetal.shade300),
      onTap: hasMultipleTabs ? onTabIndexChanged : null,
      splashFactory: hasMultipleTabs ? null : NoSplash.splashFactory,
      overlayColor:
          hasMultipleTabs ? null : WidgetStateProperty.all(Colors.transparent),
      dividerColor: ColorPalette.white,
      tabAlignment: TabAlignment.start,
    );
  }

  List<double> _calculateTabWidths(BuildContext context, int tabCount) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = maxWidth ?? mediaQuery.size.width;

    final textScaler = mediaQuery.textScaler;
    final noScrollWidth = screenWidth / tabCount;
    const horizontalPadding = 32.0; //tabs have default 16 left & right padding

    Iterable<double> tabWidths = tabs!.map<double>(
      (tabText) => getRequiredWidth(
        text: tabText,
        style: MPRTextStyles.regularBold.copyWith(color: ColorPalette.green),
        textScaler: textScaler,
        horizontalPadding: horizontalPadding,
      ),
    );

    final totalTabsWidth = tabWidths.sum;
    final useDynamicWidths =
        totalTabsWidth > screenWidth || tabWidths.any((e) => e > noScrollWidth);

    // if we are using dynamic widths, but they don't fill the screen space,
    // evenly distribute any remaining space amongst all the tab widths
    if (useDynamicWidths && totalTabsWidth < screenWidth) {
      final stretchAmount = (screenWidth - totalTabsWidth) / tabCount;
      tabWidths = tabWidths.map<double>((width) => width + stretchAmount);
    }

    return useDynamicWidths
        ? tabWidths.toList()
        : List.generate(tabCount, (_) => noScrollWidth);
  }
}
