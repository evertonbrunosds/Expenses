import 'package:expenses/models/day.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Day> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      DateFormat.E().format(weekDay)[0];
      double totalSum = 0.0;
      for (var transaction in recentTransactions) {
        final bool sameDay = transaction.date.day == weekDay.day;
        final bool sameMonth = transaction.date.month == weekDay.month;
        final bool sameYear = transaction.date.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }
      return Day(
        name: DateFormat.E().format(weekDay)[0],
        value: totalSum,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
