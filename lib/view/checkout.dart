import 'dart:convert';
import 'package:cork_padel/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cork_padel/models/checkoutValue.dart';

class Checkout extends StatefulWidget {
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Userr _user = Userr();
  Future<void>? _launched;
  checkoutValue _check = checkoutValue();

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 80.0,
                height: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pagamento',
                style: TextStyle(
                  fontFamily: 'Roboto Condensed',
                  fontSize: 26,
                  color: Colors.lime,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Valor total: €' + _check.price.toString(),
                style: TextStyle(
                  fontFamily: 'Roboto Condensed',
                  fontSize: 26,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lime,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/images/mb.png'),
                    iconSize: 75,
                    onPressed: () async {
                      // CODE FOR PAYPAL
                      // var request = BraintreeDropInRequest(
                      //     tokenizationKey: 'sandbox_pg7cvyzn_5zmrfhddbdxxmt33',
                      //     collectDeviceData: true,
                      //     paypalRequest: BraintreePayPalRequest(
                      //         amount: '1.00', displayName: 'Marco'),
                      //     cardEnabled: true);

                      // BraintreeDropInResult? result =
                      //     await BraintreeDropIn.start(request);
                      // if (result != null) {
                      //   print(result.paymentMethodNonce.description);
                      //   print(result.paymentMethodNonce.nonce);

                      //   final http.Response response = await http.post(Uri.parse(
                      //       '$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));

                      //   final payResult = jsonDecode(response.body);
                      //   if (payResult['result'] == 'success') print('payment done');
                      // }

                      // final http.Response response = await http.post(Uri.parse(
                      //     'http:/corkpadel-arena-eb47b.web.app/ifmb.html?ENTIDADE=[12374]&SUBENTIDADE=[137]&ID=[$_user.email]&VALOR=[10,00]'));
                      //'$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'

                      if (await canLaunch(
                          'http:/corkpadel-arena-eb47b.web.app/ifmb.html?ENTIDADE=12375&SUBENTIDADE=610&ID=0000&VALOR=10.00')) {
                        await launch(
                          'http:/corkpadel-arena-eb47b.web.app/ifmb.html?ENTIDADE=12375&SUBENTIDADE=610&ID=0000&VALOR=10.00',
                          forceWebView: false,
                          //headers: <String, String>{'my_header_key': 'my_header_value'},
                        );
                      } else {
                        throw 'Could not launch the store';
                      }
                    },
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lime,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/images/Logo_MBWay.png'),
                    iconSize: 75,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        )),
      ),
    );
  }

  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }

  void payWithMBWay() {
    Uri uri = Uri.parse('/ifthenpaymbw.asmx/SetPedidoJSON HTTP/1.1');
    //'https://us-central1-corkpadel-arena-eb47b.cloudfunctions.net/corkArenas?chave=[CHAVE_ANTI_PHISHING]&referencia=[REFERENCIA]&idpedido=[ID_TRANSACAO]&valor=[VALOR]&datahorapag=[DATA_HORA_PAGAMENTO]&estado=[ESTADO]';
    http.post(uri, body: json.encode({}));
  }
}
