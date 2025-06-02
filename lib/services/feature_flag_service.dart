enum FeatureFlag {
  dailyChecklist,
  uploadImage,
  selectColorScheme,
  taskCategories,
}

Map<FeatureFlag, bool> _capabilityStatus = {
  FeatureFlag.dailyChecklist: false,
  FeatureFlag.uploadImage: false,
  FeatureFlag.selectColorScheme: false,
  FeatureFlag.taskCategories: false,
};

class FeatureFlagService {
  bool isEnabled(FeatureFlag flag) {
    return _capabilityStatus[flag] ?? false;
  }
}
