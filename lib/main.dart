import 'package:expenses/components/transaction_user.dart';
import 'package:flutter/material.dart';

main() {
  runApp(AppDespesa());
}

class AppDespesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Center(child: Text('Gráfico')),
            ),
          ),
          TransactionUser(),
        ],
      ),
    );
  }
}
