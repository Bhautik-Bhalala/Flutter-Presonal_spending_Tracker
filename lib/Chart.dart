import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/bar.dart';
import 'transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTrabsactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print(totalSum);
      print(DateFormat.E().format(weekDay));
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get mmaxSpending {
    return groupedTrabsactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTrabsactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTrabsactionValues.map((data) {

            return Flexible(
              fit: FlexFit.tight,
              child: Bar(
                  (data['Day'] as String),
                  (data['amount'] as double),
                  mmaxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / mmaxSpending),
            );
            // return Text('${data['Day']} : ${data['amount']}');
          }).toList(),
        ),
      ),
    );
  }
}
