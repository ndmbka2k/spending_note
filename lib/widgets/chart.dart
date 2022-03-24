import 'package:flutter/material.dart';
import 'package:spending_app/models/transaction.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTranactions;

  Chart(this.recentTranactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (int i = 0; i < recentTranactions.length; i++) {
        if (recentTranactions[i].date.day == weekday.day &&
            recentTranactions[i].date.day == weekday.day &&
            recentTranactions[i].date.day == weekday.day) {
          totalSum += recentTranactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Text('${data['day']}: ${data['amount']}');
        }).toList(),
      ),
    );
  }
}
