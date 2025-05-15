import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/modules/settings/cubit/settings_cubit.dart';
import 'package:my_productive_rewards/modules/tabs/cubit/bottom_tabs_cubit.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class Settings extends StatelessWidget {
  final BottomTabsCubit tabsCubit;
  const Settings({super.key, required this.tabsCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: MPRAppBar(title: 'Settings'),
              backgroundColor: ColorPalette.gunmetal.shade50,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPRDivider(),
                    MPRSingleLineItem(
                      text: 'Clear All Tasks',
                      iconOnRight: false,
                      textStyleOverride: MPRTextStyles.regularSemiBold
                          .copyWith(color: Colors.red),
                      onPressed: () async {
                        final result = await _showClearConfirmationDialog(
                          context,
                          'clear all tasks',
                          'Clear Tasks',
                        );
                        if (result && context.mounted) {
                          cubit.clearTasks();
                          tabsCubit.resetAllTabs();
                        }
                      },
                      horizontalPadding: 16,
                    ),
                    MPRDivider(),
                    MPRSingleLineItem(
                      text: 'Clear Task Log',
                      iconOnRight: false,
                      textStyleOverride: MPRTextStyles.regularSemiBold
                          .copyWith(color: Colors.red),
                      onPressed: () async {
                        final result = await _showClearConfirmationDialog(
                          context,
                          'clear your task log',
                          'Clear Task Log',
                        );
                        if (result && context.mounted) {
                          cubit.clearTaskLog();
                          tabsCubit.resetAllTabs();
                        }
                      },
                      horizontalPadding: 16,
                    ),
                    MPRDivider(),
                    MPRSingleLineItem(
                      text: 'Clear All Rewards',
                      iconOnRight: false,
                      textStyleOverride: MPRTextStyles.regularSemiBold
                          .copyWith(color: Colors.red),
                      onPressed: () async {
                        final result = await _showClearConfirmationDialog(
                          context,
                          'clear all rewards',
                          'Clear Rewards',
                        );
                        if (result && context.mounted) {
                          cubit.clearRewards();
                          tabsCubit.resetAllTabs();
                        }
                      },
                      horizontalPadding: 16,
                    ),
                    MPRDivider(),
                    MPRSingleLineItem(
                      text: 'Clear Purchased Rewards',
                      iconOnRight: false,
                      textStyleOverride: MPRTextStyles.regularSemiBold
                          .copyWith(color: Colors.red),
                      onPressed: () async {
                        final result = await _showClearConfirmationDialog(
                          context,
                          'clear all purchased reward history',
                          'Clear Purchased Rewards',
                        );
                        if (result && context.mounted) {
                          cubit.clearPurchasedRewards();
                          tabsCubit.resetAllTabs();
                        }
                      },
                      horizontalPadding: 16,
                    ),
                    MPRDivider(),
                    MPRSingleLineItem(
                      text: 'Clear Points',
                      iconOnRight: false,
                      textStyleOverride: MPRTextStyles.regularSemiBold
                          .copyWith(color: Colors.red),
                      onPressed: () async {
                        final result = await _showClearConfirmationDialog(
                          context,
                          'clear all points',
                          'Clear Points',
                        );
                        if (result && context.mounted) {
                          cubit.clearPoints();
                          tabsCubit.resetAllTabs();
                        }
                      },
                      horizontalPadding: 16,
                    ),
                    MPRDivider(),
                    MPRSingleLineItem(
                      text: 'Clear All Data',
                      iconOnRight: false,
                      textStyleOverride: MPRTextStyles.regularSemiBold
                          .copyWith(color: Colors.red),
                      onPressed: () async {
                        final result = await _showClearConfirmationDialog(
                          context,
                          'clear all data',
                          'Clear All Data',
                        );
                        if (result && context.mounted) {
                          cubit.clearAllData();
                          tabsCubit.resetAllTabs();
                        }
                      },
                      horizontalPadding: 16,
                    ),
                    MPRDivider(),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Made in Golden, Colorado',
                        style: MPRTextStyles.small.copyWith(
                          color: ColorPalette.gunmetal.shade500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Center(
                      child: Text(
                        '\u00a92025 Sydney Richards',
                        style: MPRTextStyles.small.copyWith(
                          color: ColorPalette.gunmetal.shade300,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _showClearConfirmationDialog(
    BuildContext context,
    String message,
    String actionButton,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => MPRAlertDialog(
            title: 'Warning',
            message:
                'Are you sure you want to $message? This action cannot be undone.',
            actions: [
              MPRButton.tertiaryCompact(
                style: MPRTextStyles.regular,
                text: 'Cancel',
                greyFont: true,
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              MPRButton.tertiaryCompact(
                text: actionButton,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }
}
