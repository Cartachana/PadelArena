import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatefulWidget {
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var url =
      'https://us-central1-corkpadel-arena-eb47b.cloudfunctions.net/paypalPayment';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text("Pagamento"),
          backgroundColor: Theme.of(context).primaryColor),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 80.0,
                height: 100.0,
              ),
            ),
            Text(
              'Pagamento',
              style: TextStyle(
                fontFamily: 'Roboto Condensed',
                fontSize: 26,
                color: Colors.lime,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
              ),
              child: Text(
                "Pagar",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () async {
                var request = BraintreeDropInRequest(
                    tokenizationKey: 'sandbox_pg7cvyzn_5zmrfhddbdxxmt33',
                    collectDeviceData: true,
                    paypalRequest: BraintreePayPalRequest(
                        amount: '1.00', displayName: 'Marco'),
                    cardEnabled: true);

                BraintreeDropInResult? result =
                    await BraintreeDropIn.start(request);
                if (result != null) {
                  print(result.paymentMethodNonce.description);
                  print(result.paymentMethodNonce.nonce);

                  final http.Response response = await http.post(Uri.parse(
                      '$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));

                  final payResult = jsonDecode(response.body);
                  if (payResult['result'] == 'success') print('payment done');
                }
              },
            ),
          ],
        )),
      ),
    );
  }
}
