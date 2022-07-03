import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled1/Chart.dart';
import 'package:untitled1/newtransaction.dart';
import 'package:untitled1/transactions.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/usertransaction.dart';
import 'dart:async';
import 'transactionList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.green,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
              // button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't2',
      title: 'new dfdf shoes',
      amount: 70.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'new shoes',
      amount: 71.99,
      date: DateTime.now(),
    ),
  ];
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title1, double amount1 , DateTime chosenDate ) {
    final newtx = Transaction(
      title: title1,
      amount: amount1,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newtx);
    });
  }
  void _deletetransaction( String id) {
    setState(() {
      _userTransaction.removeWhere((element){
        return element.id == id;
      });
    });
  }


  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: /,
        title: Text("MY Personal Expence App"),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransaction),
            TransactionList(_userTransaction , _deletetransaction),
            // UserTransaction(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
