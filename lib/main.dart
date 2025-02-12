import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/transaction_list.dart';
import './models/transaction.dart';

main() {
  runApp(AppDespesa());
}

class AppDespesa extends StatelessWidget {
  AppDespesa({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: false,
        appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 58, 2, 137),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 106, 0, 255),
          primary: const Color.fromARGB(255, 0, 21, 255),
          secondary: Color.fromARGB(255, 251, 255, 0),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [];
  bool _showChart = false;

  List<Transaction> get recentTransactions {
    return transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  removeTransaction(String id) {
    setState(() {
      transactions.removeWhere((tr) => tr.id == id);
    });
  }

  opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontFamily: 'PlaywriteIN',
          fontSize: 20 * MediaQuery.of(context).textScaler.scale(1),
        ),
      ),
      actions: [
        if (isLandscape)
          IconButton(
              icon: Icon(_showChart ? Icons.list : Icons.add_chart),
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              }),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => opentransactionFormModal(context),
        ),
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 0.8 : 0.3),
                  child: Chart(recentTransactions)),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(transactions, removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
