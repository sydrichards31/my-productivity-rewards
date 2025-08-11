import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_productive_rewards/modules/daily_checklist.dart/daily_checklist_item.dart';

part 'daily_checklist_state.dart';

final dateFormat = DateFormat('EEE, MMMM dd, yyyy');

class DailyChecklistCubit extends Cubit<DailyChecklistState> {
  // final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  // final PersistentStorageService _persistentStorageService =
  //     GetIt.I<PersistentStorageService>();
  final descriptionTextController = TextEditingController();
  final valueTextController = TextEditingController();
  final linkTextController = TextEditingController();
  final dateTextController =
      TextEditingController(text: dateFormat.format(DateTime.now()));
  final List<DailyChecklistItem> tasks = [];

  DailyChecklistCubit()
      : super(
          DailyChecklistState(
            status: DailyChecklistStatus.initial,
            value: '',
            selectedDate: DateTime.now(),
            tasks: [],
          ),
        ) {
    tasks.add(
      DailyChecklistItem(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        globalKey: _recipientGlobalKey(),
      ),
    );
  }

  void valueChanged(String value) {
    emit(
      state.copyWith(
        value: value,
        status: DailyChecklistStatus.valueChanged,
      ),
    );
  }

  void dateChanged(DateTime? newDate) {
    if (newDate != null) {
      dateTextController.text = dateFormat.format(newDate);
    }
    emit(
      state.copyWith(
        selectedDate: newDate,
        status: DailyChecklistStatus.dateChanged,
      ),
    );
  }

  void addChecklistItem() {
    tasks.add(
      DailyChecklistItem(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        globalKey: _recipientGlobalKey(),
      ),
    );
    emit(
      state.copyWith(
        tasks: tasks.map((e) => e.controller.text).toList(),
      ),
    );
  }

  void deleteChecklistItem(int atIndex) {
    tasks[atIndex].controller.dispose();
    tasks.removeAt(atIndex);
    emit(
      state.copyWith(
        tasks: tasks.map((e) => e.controller.text).toList(),
      ),
    );
  }

  Future<void> addChecklist() async {
    emit(state.copyWith(status: DailyChecklistStatus.addingChecklist));
    try {
      emit(state.copyWith(status: DailyChecklistStatus.success));
    } catch (_) {
      emit(state.copyWith(status: DailyChecklistStatus.failure));
    }
  }

  void resetFocus() {
    _resetRecipientTextFieldFocusNodes();
  }

  GlobalKey _recipientGlobalKey() {
    return GlobalKey(
      debugLabel: 'daily_checklist_iteml_${tasks.length}_textField',
    );
  }

  void _resetRecipientTextFieldFocusNodes() {
    for (var i = 0; i < tasks.length; i++) {
      tasks[i] = DailyChecklistItem(
        controller: tasks[i].controller,
        focusNode: FocusNode(),
        globalKey: tasks[i].globalKey,
      );
    }
  }

  @override
  Future<void> close() async {
    descriptionTextController.dispose();
    valueTextController.dispose();
    linkTextController.dispose();
    super.close();
  }
}
