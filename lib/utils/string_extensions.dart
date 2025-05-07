extension StringOptionalExtensions on String? {
  bool get isNullOrWhitespace => isNullOrEmpty || this!.trim().isEmpty;
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isNotNullOrWhitespace => !isNullOrWhitespace;
  String? get withoutNewlines => this?.replaceAll('\n', ' ');
  bool get isNullOrIsNotEmail => this == null || !this!.isEmail;
  bool get isNullOrIsNotPhone => this == null || !this!.isPhone;
}

extension StringExtensions on String {
  bool get isEmail {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get isPhone {
    return RegExp(
      r'^(\+0?1\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
    ).hasMatch(this);
  }
}
