import 'package:timeago/timeago.dart';

/// Esperanto Messages
class EoMessages implements LookupMessages {
  @override
  String prefixAgo() => 'antaŭ';

  @override
  String prefixFromNow() => 'post';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'momento';

  @override
  String aboutAMinute(int minutes) => 'unu minuto';

  @override
  String minutes(int minutes) => '$minutes minutoj';

  @override
  String aboutAnHour(int minutes) => 'unu horo';

  @override
  String hours(int hours) => '$hours horoj';

  @override
  String aDay(int hours) => 'unu tago';

  @override
  String days(int days) => '$days tagoj';

  @override
  String aboutAMonth(int days) => 'unu monato';

  @override
  String months(int months) => '$months monatoj';

  @override
  String aboutAYear(int year) => 'unu jaro';

  @override
  String years(int years) => '$years jaroj';

  @override
  String wordSeparator() => ' ';
}

/// Esperanto short Messages
class EoShortMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'nun';

  @override
  String aboutAMinute(int minutes) => '1 min';

  @override
  String minutes(int minutes) => '$minutes min';

  @override
  String aboutAnHour(int minutes) => '~1 hr';

  @override
  String hours(int hours) => '$hours hr';

  @override
  String aDay(int hours) => '~1 tago';

  @override
  String days(int days) => '$days tagoj';

  @override
  String aboutAMonth(int days) => '~1 mon';

  @override
  String months(int months) => '$months mon';

  @override
  String aboutAYear(int year) => '~1 jar';

  @override
  String years(int years) => '$years jar';

  @override
  String wordSeparator() => ' ';
}
