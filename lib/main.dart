import 'dart:async';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'register/authentication.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:square_in_app_payments/models.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
//import 'package:square_in_app_payments/google_pay_constants.dart' as google_pay_constants;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future<void> _initSquarePayment() async {
  //   await InAppPayments.setSquareApplicationId('APPLICATION_ID');
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('pt')],
      title: 'Cork Padel',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: HomePage(),
    );
  }
// Future<void> _initSquarePayment() async {

//       var canUseGooglePay = false;
//       if(Platform.isAndroid) {
//         // initialize the google pay with square location id
//         // use test environment first to quick start
//         await InAppPayments.initializeGooglePay(
//           'UK', google_pay_constants.environmentTest);
//         // always check if google pay supported on that device
//         // before enable google pay
//         canUseGooglePay = await InAppPayments.canUseGooglePay;
//       }
//       setState(() {

//         _googlePayEnabled = canUseGooglePay;

//       });
//     }

//   }
//   void _onStartGooglePay() async {
//     try {
//       await InAppPayments.requestGooglePayNonce(
//         price: '1.00',
//         currencyCode: 'USD',
//         onGooglePayNonceRequestSuccess: _onGooglePayNonceRequestSuccess,
//         onGooglePayNonceRequestFailure: _onGooglePayNonceRequestFailure,
//         onGooglePayCanceled: _onGooglePayCancel, priceStatus: 1);
//     } on InAppPaymentsException catch(ex) {
//       // handle the failure of starting apple pay
//     }
//   }

//   /**
//   * Callback when successfully get the card nonce details for processig
//   * google pay sheet has been closed when this callback is invoked
//   */
//   void _onGooglePayNonceRequestSuccess(CardDetails result) async {
//     try {
//       // take payment with the card nonce details
//       // you can take a charge
//       // await chargeCard(result);

//     } on Exception catch (ex) {
//       // handle card nonce processing failure
//     }
//   }

//   /**
//   * Callback when google pay is canceled
//   * google pay sheet has been closed when this callback is invoked
//   */
//   void _onGooglePayCancel() {
//     // handle google pay canceled
//   }

//   /**
//   * Callback when failed to get the card nonce
//   * google pay sheet has been closed when this callback is invoked
//   */
//   void _onGooglePayNonceRequestFailure(ErrorInfo errorInfo) {
//     // handle google pay failure
//   }

// }
//   /**
//   * An event listener to start card entry flow
//   */
//   Future<void> _onStartCardEntryFlow() async {
//     await InAppPayments.startCardEntryFlow(
//         onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
//         onCardEntryCancel: _onCancelCardEntryFlow);
//   }

//   /**
//   * Callback when card entry is cancelled and UI is closed
//   */
//   void _onCancelCardEntryFlow() {
//     // Handle the cancel callback
//   }

//   /**
//   * Callback when successfully get the card nonce details for processig
//   * card entry is still open and waiting for processing card nonce details
//   */
//   void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
//     try {
//       // take payment with the card nonce details
//       // you can take a charge
//       // await chargeCard(result);

//       // payment finished successfully
//       // you must call this method to close card entry
//       // this ONLY apply to startCardEntryFlow, please don't call this method when use startCardEntryFlowWithBuyerVerification
//       InAppPayments.completeCardEntry(
//           onCardEntryComplete: _onCardEntryComplete);
//     } on Exception catch (ex) {
//       // payment failed to complete due to error
//       // notify card entry to show processing error
//       InAppPayments.showCardNonceProcessingError('error');
//     }
//   }

//   /**
//   * Callback when the card entry is closed after call 'completeCardEntry'
//   */
//   void _onCardEntryComplete() {
//     // Update UI to notify user that the payment flow is finished successfully
//   }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 80.0,
                    height: 100.0,
                  ),
                ),
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => Authentication(
                    email: appState.email,
                    loginState: appState.loginState,
                    startLoginFlow: appState.startLoginFlow,
                    checkEmail: appState.checkEmail,
                    signInWithEmailAndPassword:
                        appState.signInWithEmailAndPassword,
                    cancelRegistration: appState.cancelRegistration,
                    registerAccount: appState.registerAccount,
                    signOut: appState.signOut,
                    getDetails: appState.getUserDetails,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  String? _email;
  String? get email => _email;
  Userr _userr = Userr();
  User? _user;
  bool emailVerified = false;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void checkEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void getUserDetails() async {
    _user = FirebaseAuth.instance.currentUser;
    _userr.id = _user!.uid.toString();
    _userr.email = _user!.email.toString();
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String displayName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      final User? user = credential.user;
      _user = FirebaseAuth.instance.currentUser;
      _userr.id = user!.uid.toString();
      _userr.email = user.email.toString();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

// Note: To start the payment flow with Strong Customer Authentication,
//you should call startCardEntryFlowWithBuyerVerification.
//InAppPayments.completeCardEntry
//is NOT needed for this call.

// Note: To start Strong Customer Authentication for card-on-file,
//you should call startBuyerVerificationFlow. InAppPayments.completeCardEntry
//is NOT needed for this call.

// Note: The chargeCard method in this example shows a typical REST request
//on a backend process that uses the Payments API to take a payment with the
//supplied nonce.
//See BackendQuickStart Sample to learn about building an app that
//processes payment nonces on a server.
