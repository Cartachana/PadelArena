import 'dart:async';
import 'package:cork_padel/main.dart';
import 'package:cork_padel/register/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/dash.dart';
import '../src/widgets.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
  emailNotVerified,
  detailsNotEntered,
}

class Authentication extends StatelessWidget {
  Userr _userr = Userr();
  Future<void> currentUser() {
    getDetails();
    final String _email = _userr.email.toString();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_email)
        .get()
        .then((value) {
      _userr.name = value.data()!["first_name"].toString();
      _userr.address = value.data()!["address"].toString();
      _userr.surname = value.data()!["last_name"].toString();
      _userr.city = value.data()!["city"].toString();
      _userr.id = value.data()!["id"].toString();
      _userr.nif = value.data()!["nif"].toString();
      _userr.postCode = value.data()!["postal_code"].toString();
      _userr.role = value.data()!["role"].toString();
    });
  }

  Authentication(
      {required this.loginState,
      required this.email,
      required this.startLoginFlow,
      required this.checkEmail,
      required this.signInWithEmailAndPassword,
      required this.cancelRegistration,
      required this.registerAccount,
      required this.signOut,
      required this.getDetails,
      required this.checkEmailVerified,
      required this.emailVerified});

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final Future<void> checkEmailVerified;
  final bool emailVerified;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) checkEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;
  final void Function() getDetails;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Cork Padel Arena',
                style: TextStyle(
                  fontFamily: 'Roboto Condensed',
                  fontSize: 26,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                ),
                child: const Text(
                  "Comecar",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  startLoginFlow();
                },
              ),
            )
          ],
        );

      case ApplicationLoginState.emailAddress:
        return EmailForm(
          callback: (email) => checkEmail(
              email, (e) => _showErrorDialog(context, 'Email invalido', e)),
        );
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Erro no login', e));
          },
          getDetails: getDetails,
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
              email,
              displayName,
              password,
              (e) => _showErrorDialog(context, 'Failed to create account', e),
            );
          },
          getDetails: getDetails,
        );
      case ApplicationLoginState.detailsNotEntered:
        currentUser();
        return UserDetailsWidget();
      case ApplicationLoginState.emailNotVerified:
        return Verify(checkEmailVerified, emailVerified);
      case ApplicationLoginState.loggedIn:
        {
          currentUser();
          return DashWidget();
        }
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});

  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Entrar',
            style: TextStyle(
              fontFamily: 'Roboto Condensed',
              fontSize: 26,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _controller,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lime, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lime, width: 1.5),
                ),
                labelText: 'Email',
                // errorText: 'Error Text',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Obrigatorio';
                }
                return null;
              },
            ),
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
              ),
              child: const Text(
                "Seguinte",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  widget.callback(_controller.text);
                }
              },
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SignInButton(
          //     Buttons.Facebook,
          //     text: "Entrar com Facebook",
          //     onPressed: () {
          //       widget.facebook();
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SignInButton(
          //     Buttons.Google,
          //     text: "Entrar com Google",
          //     onPressed: () {
          //       widget.google();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm(
      {required this.login, required this.email, required this.getDetails});
  final String email;
  final void Function(String email, String password) login;
  @override
  _PasswordFormState createState() => _PasswordFormState();
  final void Function() getDetails;
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Entrar',
          style: TextStyle(
            fontFamily: 'Roboto Condensed',
            fontSize: 26,
            color: Colors.lime,
          ),
        ),
        Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      labelText: 'Email',
                      // errorText: 'Error Text',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      labelText: 'Password',
                      // errorText: 'Error Text',
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                      ),
                      child: const Text(
                        "Seguinte",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm(
      {required this.registerAccount,
      required this.cancel,
      required this.email,
      required this.getDetails});

  final String email;
  final void Function(String email, String displayName, String password)
      registerAccount;
  final void Function() cancel;
  final void Function() getDetails;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Email nao reconhecido. Por favor Registe-se',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto Condensed',
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
        Text(
          'REGISTO',
          style: TextStyle(
            fontFamily: 'Roboto Condensed',
            fontSize: 26,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      labelText: 'Nome',
                      // errorText: 'Error Text',
                    ),
                    controller: _displayNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      labelText: 'Email',
                      // errorText: 'Error Text',
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
//---------------------------------------//PASSWORD-------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      labelText: 'Password',
                      // errorText: 'Error Text',
                    ),
                    controller: _passController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime, width: 1.5),
                      ),
                      labelText: 'Confirme a Password',
                      // errorText: 'Error Text',
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      if (value != _passController.text) {
                        return 'Passwords nao coincidem';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      "Submeter",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.registerAccount(
                          _emailController.text,
                          _displayNameController.text,
                          _passwordController.text,
                        );
                        widget.getDetails();
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (_) {
                          return UserDetails();
                        }));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Verify extends StatefulWidget {
  final Future<void> checkEmailVerified;
  final bool emailVerified;

  Verify(this.checkEmailVerified, this.emailVerified);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final User? _user = FirebaseAuth.instance.currentUser;
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_user!.emailVerified) {
        timer.cancel();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return MyApp();
        }));
      } else {
        widget.checkEmailVerified;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Um email foi enviado para ${_user!.email}. Por favor visite a sua caixa de email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '\nNao recebeu o email de confirmacao?\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Colors.white,
                  ),
                  child: Text(
                    "Reenviar",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    _user!.sendEmailVerification();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
