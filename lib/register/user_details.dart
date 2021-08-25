import 'package:cork_padel/register/registerSplash.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDetails extends StatefulWidget {
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
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _form = GlobalKey<FormState>();
  String _id = '';
  String _role = 'utilisador';
  String _name = '';
  String _surname = '';
  String _address = '';
  String _city = '';
  String _postCode = '';
  num _nif = 0;
  String _email = '';

  var _user = new Userr(
    id: '',
    role: 'utilisador',
    name: '',
    surname: '',
    address: '',
    city: '',
    postCode: '',
    nif: 0,
    email: '',
  );

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
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    width: 80.0,
                    height: 100.0,
                  ),
                  Text(
                    'DADOS PESSOAIS',
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
                                        _name = value.toString();
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
                                        _surname = value.toString();
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
                              _address = value.toString();
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
                                    _city = value.toString();
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
                                    _postCode = value.toString();
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
                              _nif = double.parse(value.toString());
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
//---------------------------------------//BOTAO-------------------------------------------------------------
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
                              _saveForm();
                              Navigator.of(
                                context,
                              ).push(MaterialPageRoute(builder: (_) {
                                return RegisterSplash();
                              }));
                            },
                          ),
                        ),
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
