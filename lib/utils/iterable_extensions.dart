extension ListOptionalExtensions<T> on List<T>? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
