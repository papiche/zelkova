import 'package:timeago/timeago.dart';

/// Euskara Messages
class EuMessages implements LookupMessages {
  @override
  String prefixAgo() => 'duela';

  @override
  String prefixFromNow() => 'hemendik';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => 'ra';

  @override
  String lessThanOneMinute(int seconds) => 'momentu bat';

  @override
  String aboutAMinute(int minutes) => 'minutu bat';

  @override
  String minutes(int minutes) => '$minutes minutu';

  @override
  String aboutAnHour(int minutes) => 'ordu bat';

  @override
  String hours(int hours) => '$hours ordu';

  @override
  String aDay(int hours) => 'egun bat';

  @override
  String days(int days) => '$days egun';

  @override
  String aboutAMonth(int days) => 'hilabete bat';

  @override
  String months(int months) => '$months hilabete';

  @override
  String aboutAYear(int year) => 'urte bat';

  @override
  String years(int years) => '$years urte';

  @override
  String wordSeparator() => ' ';
}

/// Euskara short Messages
class EuShortMessages implements LookupMessages {
  @override
  String prefixAgo() => 'd.';

  @override
  String prefixFromNow() => 'h.';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => 'r.';

  @override
  String lessThanOneMinute(int seconds) => 'orain';

  @override
  String aboutAMinute(int minutes) => '1 min';

  @override
  String minutes(int minutes) => '$minutes min';

  @override
  String aboutAnHour(int minutes) => '~1 ord.';

  @override
  String hours(int hours) => '$hours ord.';

  @override
  String aDay(int hours) => '~1 eg.';

  @override
  String days(int days) => '$days eg.';

  @override
  String aboutAMonth(int days) => '~1 hil.';

  @override
  String months(int months) => '$months hil.';

  @override
  String aboutAYear(int year) => '~1 urt.';

  @override
  String years(int years) => '$years urt.';

  @override
  String wordSeparator() => ' ';
}
