import 'package:flutter/material.dart';
import 'package:spending_app/widgets/chart.dart';
import 'package:spending_app/widgets/new_transaction.dart';
import 'package:spending_app/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   tiltle: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   tiltle: 'Groceries',
    //   amount: 12.34,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  String getSpendingAmount(double spendingAmount) {
    if (spendingAmount / 1000000000 >= 1) {
      String temp = (spendingAmount / 1000000000).toStringAsFixed(2);
      return '\$${temp}B';
    } else if (spendingAmount / 1000000 >= 1) {
      String temp = (spendingAmount / 1000000).toStringAsFixed(2);
      return '\$${temp}M';
    } else if (spendingAmount / 1000 >= 1) {
      String temp = (spendingAmount / 1000).toStringAsFixed(2);
      return '\$${temp}K';
    } else
      return '\$${spendingAmount.toStringAsFixed(0)}';
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime time) {
    final newTx = Transaction(
      amount: txAmount,
      tiltle: txTitle,
      date: time,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: (() {}),
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter App',
        ),
        actions: [
          IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentTransaction, getSpendingAmount),
            TransactionList(
                _userTransaction, _deleteTransaction, getSpendingAmount),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
