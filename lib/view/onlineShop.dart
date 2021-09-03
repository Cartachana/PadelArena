import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineShop extends StatefulWidget {
  const OnlineShop({Key? key}) : super(key: key);

  @override
  _OnlineShopState createState() => _OnlineShopState();
}

class _OnlineShopState extends State<OnlineShop> {
  Future<void>? _launched;
  var _url = 'https://www.corkpadel.pt/en/store';
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
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
    return Container(
      width: 150,
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
            ),
            child: Text(
              "Submeter",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () => setState(() {
              _launched = _launchInBrowser(_url);
            }),
          ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ],
      ),
    );
  }
}
