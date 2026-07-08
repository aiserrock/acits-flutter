import 'package:acits_flutter/util/datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimeX', () {
    final date = DateTime(2022, 4, 1, 22, 7, 15);

    test('toIsoDateOnly formats yyyy-MM-dd', () {
      expect(date.toIsoDateOnly(), '2022-04-01');
      expect(DateTime(2022, 12, 31).toIsoDateOnly(), '2022-12-31');
    });

    test('toDateShortOnly formats dd.MM.yyyy', () {
      expect(date.toDateShortOnly, '01.04.2022');
      expect(DateTime(2022, 12, 5).toDateShortOnly, '05.12.2022');
    });

    test('toPatchApiDate formats yyyy-MM-dd', () {
      expect(date.toPatchApiDate, '2022-04-01');
      expect(DateTime(2022, 1, 4).toPatchApiDate, '2022-01-04');
    });

    test('mergeTime keeps the date and applies the given time', () {
      final merged = date.mergeTime(const TimeOfDay(hour: 9, minute: 30));
      expect(merged, DateTime(2022, 4, 1, 9, 30));
      expect(merged.year, 2022);
      expect(merged.month, 4);
      expect(merged.day, 1);
      expect(merged.hour, 9);
      expect(merged.minute, 30);
    });

    test('mergeTime drops seconds present in the original date', () {
      final merged = date.mergeTime(const TimeOfDay(hour: 0, minute: 0));
      expect(merged.second, 0);
      expect(merged, DateTime(2022, 4, 1, 0, 0));
    });
  });

  group('DateTimeStringX.toDateShortOnlyParse', () {
    test('parses dd.MM.yyyy into a DateTime', () {
      final parsed = '01.04.2022'.toDateShortOnlyParse;
      expect(parsed.year, 2022);
      expect(parsed.month, 4);
      expect(parsed.day, 1);
    });

    test('round-trips with toDateShortOnly', () {
      final date = DateTime(2022, 4, 1);
      expect(date.toDateShortOnly.toDateShortOnlyParse, date);
    });

    test('round-trips for another date', () {
      final date = DateTime(2000, 12, 31);
      expect(date.toDateShortOnly.toDateShortOnlyParse, date);
    });
  });

  group('TimeOfDayX.timeSort', () {
    test('returns negative when current is earlier', () {
      const a = TimeOfDay(hour: 8, minute: 0);
      const b = TimeOfDay(hour: 9, minute: 0);
      expect(TimeOfDayX.timeSort(a, b), isNegative);
    });

    test('returns positive when current is later', () {
      const a = TimeOfDay(hour: 10, minute: 15);
      const b = TimeOfDay(hour: 10, minute: 0);
      expect(TimeOfDayX.timeSort(a, b), isPositive);
    });

    test('returns zero for equal times', () {
      const a = TimeOfDay(hour: 12, minute: 30);
      const b = TimeOfDay(hour: 12, minute: 30);
      expect(TimeOfDayX.timeSort(a, b), 0);
    });

    test('compares by minutes when hours are equal', () {
      const a = TimeOfDay(hour: 7, minute: 5);
      const b = TimeOfDay(hour: 7, minute: 45);
      expect(TimeOfDayX.timeSort(a, b), isNegative);
    });

    test('orders a list ascending', () {
      final times = <TimeOfDay>[
        const TimeOfDay(hour: 9, minute: 0),
        const TimeOfDay(hour: 7, minute: 45),
        const TimeOfDay(hour: 7, minute: 5),
        const TimeOfDay(hour: 23, minute: 59),
      ]..sort(TimeOfDayX.timeSort);
      expect(times, <TimeOfDay>[
        const TimeOfDay(hour: 7, minute: 5),
        const TimeOfDay(hour: 7, minute: 45),
        const TimeOfDay(hour: 9, minute: 0),
        const TimeOfDay(hour: 23, minute: 59),
      ]);
    });
  });
}
