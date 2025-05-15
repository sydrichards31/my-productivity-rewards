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

  DateTime get dateFromFormattedDateString {
    final split = this.split(' ');
    final month = split[1];
    final day = int.parse(split[2].substring(0, split[2].indexOf(',')));
    final year = int.parse(split[3]);
    return DateTime(year, _getMonth(month), day);
  }

  int _getMonth(String month) {
    switch (month) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        return -1;
    }
  }
}
