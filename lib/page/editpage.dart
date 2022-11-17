import 'dart:async';
import 'dart:ffi';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase/page/listpage.dart';
import 'package:firebase/service/firebase_crud.dart';

import '../models/employee.dart';

class EditPage extends StatefulWidget {
  final Employee? employee;
  EditPage({this.employee});

  @override
  State<StatefulWidget> createState() {
    //TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _Employee_name = TextEditingController();
  final _Employee_position = TextEditingController();
  final _Employee_contact = TextEditingController();
  final _docId = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implemet initState
    _docId.value = TextEditingValue(text: widget.employee!.uid.toString());
    _Employee_name.value =
      TextEditingValue(text: widget.employee!.employeename.toString());
    _Employee_position.value =
      TextEditingValue(text: widget.employee!.position.toString());
    _Employee_contact.value =
      TextEditingValue(text: widget.employee!.contactno.toString());
  }

  @override 
  Widget build(BuildContext context) {
    final DocIdField = TextField(
      controller: _docId,
      readOnly:  true,
      autofocus: false,
      decoration: InputDecoration (
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Name",
        border: 
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    
    final nameField = TextFormField(
      controller: _Employee_name,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Name",
        border: 
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final positionField = TextFormField(
      controller: _Employee_position,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
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
      onPressed: (){
        Navigator.pushAndRemoveUntil<dynamic> (
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ListPage(),
          ),
          (Route) => false,
        );
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
            var response = await FirebaseCrud.updateEmployee(
              name: _Employee_name.text,
              position: _Employee_position.text,
              contactno: _Employee_contact.text,
              docId: _docId.text);
          if (response.code !=200) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });
          }
          }
        },
        child: Text(
          "update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('freeCode Spot'),
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
                  DocIdField,
                  const SizedBox(height: 25.0),
                  nameField,
                  const SizedBox(height: 25.0),
                  positionField,
                  const SizedBox(height: 35.0),
                  contactField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButton,
                  const SizedBox(height: 15.0),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}