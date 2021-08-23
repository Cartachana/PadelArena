import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register_button.dart';
import '../models/user.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class RegisterScreen extends StatefulWidget {
  // final ApplicationLoginState loginState;
  // final String? email;
  // final void Function() startLoginFlow;
  // final void Function(
  //   String email,
  //   void Function(Exception e) error,
  // ) verifyEmail;
  // final void Function(
  //   String email,
  //   String password,
  //   void Function(Exception e) error,
  // ) signInWithEmailAndPassword;
  // final void Function() cancelRegistration;
  // final void Function(
  //   String email,
  //   String displayName,
  //   String password,
  //   void Function(Exception e) error,
  // ) registerAccount;
  // final void Function() signOut;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _pass = TextEditingController();

  var _user = new Userr(
      id: '',
      name: '',
      surname: '',
      address: '',
      city: '',
      postCode: '',
      nif: 0,
      email: '',
      password: '');

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

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
              margin: EdgeInsets.all(20),
              width: double.infinity,
              //height: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    width: 80.0,
                    height: 100.0,
                  ),
                  Text(
                    'REGISTO',
                    style: TextStyle(
                      fontFamily: 'Roboto Condensed',
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
//---------------------------------------PRIMEIRO NOME--------------------------------------------------------
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1.5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1.5),
                                        ),
                                        labelText: 'Nome',
                                        // errorText: 'Error Text',
                                      ),
                                      onSaved: (value) {
                                        _user.name = value.toString();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Obrigatorio';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                Expanded(
//---------------------------------------//ULTIMO NOME-------------------------------------------------------------
                                  //padding: EdgeInsets.all(10.0),

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1.5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1.5),
                                        ),
                                        labelText: 'Sobrenome',
                                        // errorText: 'Error Text',
                                      ),
                                      onSaved: (value) {
                                        _user.surname = value.toString();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Obrigatorio';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                        ),
//---------------------------------------//MORADA-------------------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5),
                              ),
                              labelText: 'Morada',
                              // errorText: 'Error Text',
                            ),
                            onSaved: (value) {
                              _user.address = value.toString();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Obrigatorio';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
//---------------------------------------//LOCALIDADE-------------------------------------------------------------
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.5),
                                    ),
                                    labelText: 'Localidade',
                                    // errorText: 'Error Text',
                                  ),
                                  onSaved: (value) {
                                    _user.city = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Obrigatorio';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
//---------------------------------------//CODIGO POSTAL-------------------------------------------------------------

                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.5),
                                    ),
                                    labelText: 'Codigo Postal',
                                    // errorText: 'Error Text',
                                  ),
                                  onSaved: (value) {
                                    _user.postCode = value.toString();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Obrigatorio';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
//---------------------------------------//NIF-------------------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5),
                              ),
                              labelText: 'NIF',
                              // errorText: 'Error Text',
                            ),
                            onSaved: (value) {
                              _user.nif = double.parse(value.toString());
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Obrigatorio';
                              }
                              if (double.tryParse(value) == null ||
                                  value.length < 9) {
                                return 'NIF invalido';
                              }

                              return null;
                            },
                          ),
                        ),
//---------------------------------------//EMAIL-------------------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5),
                              ),
                              labelText: 'Email',
                              // errorText: 'Error Text',
                            ),
                            onSaved: (value) {
                              _user.email = value.toString();
                            },
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
                                borderSide:
                                    BorderSide(color: Colors.lime, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lime, width: 1.5),
                              ),
                              labelText: 'Password',
                              // errorText: 'Error Text',
                            ),
                            onSaved: (value) {
                              _user.password = value.toString();
                            },
                            controller: _pass,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Obrigatorio';
                              }
                              return null;
                            },
                          ),
                        ),
//---------------------------------------//CONFIRM PASSWORD-------------------------------------------------------------
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lime, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lime, width: 1.5),
                              ),
                              labelText: 'Confirme a Password',
                              // errorText: 'Error Text',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Obrigatorio';
                              }
                              if (value != _pass.text) {
                                return 'Passwords nao coincidem';
                              }
                              return null;
                            },
                          ),
                        ),
                        RegisterButton(_saveForm),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
