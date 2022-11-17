import 'dart:html';

import 'package:firebase/service/firebase_crud.dart';
import 'package:flutter/material.dart';
import 'package:firebase/page/listpage.dart';


class AddPage extends StatefulWidget {
  @override 
  State<StatefulWidget> createState () {
    // TODO : implement Createstate
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _Employee_name = TextEditingController();
  final _Employee_position = TextEditingController();
  final _Employee_contact = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override 
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: _Employee_name,
      autofocus: false,
      validator: (value){
        if (value == null || value.trim().isEmpty) {
          return 'this field is required';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Name",
        border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final posilionField = TextFormField (
      controller: _Employee_position,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty){
          return 'this filed is required';
        }
      },
      decoration: InputDecoration (
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Position",
        border: 
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final contactField = TextFormField(
      controller: _Employee_contact,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Contact Number",
        border: 
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ListPage (),
          ),
          (route) => false); //To disable back fature set to false
      },
      child: const Text('View List of Employee'));
    
    final SaveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.addEmployee(
              name: _Employee_name.text, 
              position: _Employee_position.text, 
              contactno: _Employee_contact.text);
            if (response.code != 200) {
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    content:  Text(response.message.toString()),
                  );
                });
            } else {
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('FreeCode spot'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 25.0),
                  posilionField,
                  const SizedBox(height: 35.0),
                  contactField,
                  const SizedBox(height: 45.0,),
                  SaveButton,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}