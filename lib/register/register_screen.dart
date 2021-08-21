import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register_button.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _pass = TextEditingController();

  var _user = new Userr(
      id: null,
      name: '',
      surname: '',
      address: '',
      city: '',
      postCode: '',
      nif: 0,
      email: '',
      password: '');

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    // try{
    //   FirebaseUser userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _user.email, password: _user.password);
    // }
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
                                        _user.name = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
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
                                        _user.surname = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
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
                              _user.address = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
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
                                    _user.city = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                                    _user.postCode = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                              _user.nif = double.parse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
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
                              _user.email = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
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
                              _user.password = value;
                            },
                            controller: _pass,
                            validator: (value) {
                              if (value.isEmpty) {
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
                              if (value.isEmpty) {
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
