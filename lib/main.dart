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
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 58, 2, 137),
          primary: const Color.fromARGB(255, 255, 255, 255),
          secondary: const Color.fromARGB(255, 0, 0, 0),
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
  final List<Transaction> transactions = [
    //  Transaction(
    //     id: 't1',
    //     title: 'Novo Tênis de Corrida',
    //     value: 310.76,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'Conta de Luz',
    //     value: 211.3,
    //     date: DateTime.now(),
    //   ),
  ];

  _addTransaction(String tittle, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: tittle,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(fontFamily: 'PlaywriteIN'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => opentransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Center(child: Text('Gráfico')),
              ),
            ),
            TransactionList(transactions),
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
