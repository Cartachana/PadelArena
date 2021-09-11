import 'package:cork_padel/src/registerSplash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class EditDetails extends StatefulWidget {
  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
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
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80.0,
                  height: 100.0,
                ),
                UserDetailsWidget(),
              ],
            ),
          ),
        ));
  }
}

class UserDetailsWidget extends StatelessWidget {
  Userr _userr = Userr();

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    AddUser(_userr.id, _userr.role, _userr.name, _userr.surname, _userr.address,
            _userr.city, _userr.postCode, _userr.nif, _userr.email)
        .addUser();

    //await newUser.addUser();
  }

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'EDITAR DADOS',
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
                                      color: Theme.of(context).primaryColor,
                                      width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.5),
                                ),
                                labelText: 'Nome',
                                // errorText: 'Error Text',
                              ),
                              onSaved: (value) {
                                _userr.name = value.toString();
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
                                      color: Theme.of(context).primaryColor,
                                      width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.5),
                                ),
                                labelText: 'Sobrenome',
                                // errorText: 'Error Text',
                              ),
                              onSaved: (value) {
                                _userr.surname = value.toString();
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
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      labelText: 'Morada',
                      // errorText: 'Error Text',
                    ),
                    onSaved: (value) {
                      _userr.address = value.toString();
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
                            _userr.city = value.toString();
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
                            labelText: 'Codigo Postal',
                            // errorText: 'Error Text',
                          ),
                          onSaved: (value) {
                            _userr.postCode = value.toString();
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
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      labelText: 'NIF',
                      // errorText: 'Error Text',
                    ),
                    onSaved: (value) {
                      _userr.nif = value.toString();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obrigatorio';
                      }
                      if (double.tryParse(value) == null || value.length < 9) {
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
                      final isValid = _form.currentState!.validate();
                      if (isValid) {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) {
                          return RegisterSplash();
                        }));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddUser {
  final String _id;
  final String _role;
  final String _name;
  final String _surname;
  final String _address;
  final String _city;
  final String _postCode;
  final String _nif;
  final String _email;

  User? _user = FirebaseAuth.instance.currentUser;

  AddUser(this._id, this._role, this._name, this._surname, this._address,
      this._city, this._postCode, this._nif, this._email);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    //Call the user's CollectionReference to add a new user
    return users.doc(_email).set({
      'id': _id,
      'role': 'utilizador',
      'address': _address,
      'city': _city,
      'email': _email,
      'first_name': _name,
      'last_name': _surname,
      'nif': _nif,
      'postal_code': _postCode
    }).then((value) {
      print("User Added");

      _user!.sendEmailVerification();
    }).catchError((error) => print("Failed to add user: $error"));
  }
}
