import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final theme = ThemeData(
    textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
    fontFamily: 'Quicksand',
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        key: key,
      ),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          background: Colors.deepPurple[50],
          primary: Colors.deepPurple,
          secondary: Colors.deepPurple,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = <Transaction>[];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _removeTransaction(final String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _addTransaction(final String title, final double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(final BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (_) => TransactionForm(onSubmit: _addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    //IMPEDE A ORIENTAÇÃO RETRATO
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            onPressed: () => setState(() {
              _showChart = !_showChart;
            }),
            icon: Icon(_showChart ? Icons.show_chart : Icons.list),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: availableHeight,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Text('Exibir Gráfico'),
              //       Switch(
              //         value: _showChart,
              //         onChanged: (state) => setState(() => _showChart = state),
              //       ),
              //     ],
              //   ),
              if (_showChart || !isLandscape)
                SizedBox(
                  height: availableHeight * (isLandscape ? 0.50 : 0.22),
                  child: Chart(recentTransactions: _recentTransactions),
                ),
              if (!_showChart || !isLandscape)
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: availableHeight * (isLandscape ? 1 : 0.78),
                      child: TransactionList(
                          transactions: _transactions,
                          onRemove: _removeTransaction),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
