import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  final Function(double) getSpendingAmount1;

  // String getSpendingAmount(double spendingAmount) {
  //   if (spendingAmount / 1000000000 >= 1) {
  //     String temp = (spendingAmount / 1000000000).toStringAsFixed(2);
  //     return '\$${temp}B';
  //   } else if (spendingAmount / 1000000 >= 1) {
  //     String temp = (spendingAmount / 1000000).toStringAsFixed(2);
  //     return '\$${temp}M';
  //   } else if (spendingAmount / 1000 >= 1) {
  //     String temp = (spendingAmount / 1000).toStringAsFixed(2);
  //     return '\$${temp}K';
  //   } else
  //     return '\$${spendingAmount.toStringAsFixed(0)}';
  // }

  ChartBar({
    required this.label,
    required this.spendingAmount,
    required this.spendingPctOfTotal,
    required this.getSpendingAmount1,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            getSpendingAmount1(spendingAmount),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
