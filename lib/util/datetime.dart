import 'package:intl/intl.dart';

DateTime? parseDateTime(dateString) {
  if (dateString == null) return null;
  return _parseRfc822DateTime(dateString) ?? _parseIso8601DateTime(dateString);
}

DateTime? _parseRfc822DateTime(String dateString) {
  const patterns = [
    'EEE, dd MMM yyyy HH:mm:ss Z',
    'dd MMM yyyy HH:mm:ss Z',
  ];
  for (var pattern in patterns) {
    try {
      final num? length = dateString.length.clamp(0, pattern.length);
      final trimmedPattern = pattern.substring(
          0,
          length
              as int?); //Some feeds use a shortened RFC 822 date, e.g. 'Tue, 04 Aug 2020'
      final format = DateFormat(trimmedPattern, 'en_US');
      return format.parse(dateString);
    } on FormatException {
      continue;
    }
  }
  return null;
}

DateTime? _parseIso8601DateTime(dateString) {
  try {
    return DateTime.parse(dateString);
  } on FormatException {
    return null;
  }
}
