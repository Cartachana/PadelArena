import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'register/authentication.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
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
                    checkEmailVerified: appState.checkEmailVerified(),
                    emailVerified: appState.emailVerified,
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
  late FirebaseAuth auth;
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        if (auth.currentUser!.emailVerified) {
          _loginState = ApplicationLoginState.loggedIn;
          //notifyListeners();
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.email.toString())
              .get()
              .then((onexist) {
            onexist.exists ? ok = true : ok = false;
          });
          if (ok) {
            _loginState = ApplicationLoginState.emailNotVerified;
            print('not verif');
            //notifyListeners();
          } else {
            _loginState = ApplicationLoginState.detailsNotEntered;
            print('no details');
            //notifyListeners();
          }
        }
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        //notifyListeners();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;
  Userr _userr = Userr();
  bool ok = false;
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
      await Firebase.initializeApp();
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
      _user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void getUserDetails() async {
    _user = auth.currentUser;
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

  Future<void> checkEmailVerified() async {
    await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
    _user = auth.currentUser!;

    await _user!.reload();
    if (_user!.emailVerified) {
      emailVerified = true;
      _loginState = ApplicationLoginState.loggedIn;
    } else {
      emailVerified = false;
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
