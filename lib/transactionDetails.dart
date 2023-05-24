import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';


class TransactionDetailsScreen extends StatelessWidget {
  final dynamic transaction;

  TransactionDetailsScreen({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(transaction['date']));

    return Builder(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;

        return PlatformScaffold(
      appBar: PlatformAppBar(
        title:const Text('TRANSACTION DETAILS'),
       
        cupertino: (_, __) => CupertinoNavigationBarData(
          transitionBetweenRoutes: false,
        ),
      ),
          body: Container(
            height: screenHeight * 0.27, // Adjust the height as needed
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin:const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text('Transaction ID: ${transaction['id']}'),
                  Text(
                    'Type: ${transaction['type']}',
                    style:
                       const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Amount: ${transaction['amount']}',
                    style:
                      const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Currency: ${transaction['currency']}',
                    style:
                      const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Date: $formattedDate',
                    style:
                      const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Description: ${transaction['description']}',
                    style:
                      const  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
