

import 'package:flutter/material.dart';
import 'transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transactions App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionScreen(),
    );
  }
}
