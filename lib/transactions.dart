import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'transactionDetails.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://64677d7f2ea3cae8dc3091e7.mockapi.io/api/v1/transactions'));
    if (response.statusCode == 200) {
      setState(() {
        transactions = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;

        return PlatformScaffold(
          appBar: PlatformAppBar(
  title:const Center( 
  child:Text('TRANSACTIONS LIST',
  textAlign: TextAlign.center,)),
  trailingActions: <Widget>[
    PlatformIconButton(
      icon: Icon(context.platformIcons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: TransactionSearchDelegate(transactions),
        );
      },
    ),
  ],
  cupertino: (_, __) => CupertinoNavigationBarData(
    transitionBetweenRoutes: false,
    trailing: PlatformIconButton(
      icon: Icon(context.platformIcons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: TransactionSearchDelegate(transactions),
        );
      },
    ),
  ),
),

          body: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final transactionDate = DateTime.parse(transaction['date']);
              final formattedDate = DateFormat('dd/MM/yyyy').format(transactionDate);

              return Container(
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    'Type: ${transaction['type']}',
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount: ${transaction['amount']}',
                        style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Currency: ${transaction['currency']}',
                        style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date: $formattedDate',
                        style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(transaction: transaction),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class TransactionSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> transactions;

  TransactionSearchDelegate(this.transactions);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
  icon: Icon(context.platformIcons.back),
  onPressed: () {
    close(context, '');
  },
),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> filteredTransactions = query.isEmpty
        ? []
        : transactions
            .where((transaction) =>
                transaction['type']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];
        final transactionDate = DateTime.parse(transaction['date']);
        final formattedDate = DateFormat('dd/MM/yyyy').format(transactionDate);

        return Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin:const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              'Type: ${transaction['type']}',
              style:const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount: ${transaction['amount']}',
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Currency: ${transaction['currency']}',
                        style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                Text(
                  'Date: $formattedDate',
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransactionDetailsScreen(transaction: transaction),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
