// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Replace this Text Widget
              // and build the label and switch here
              // as children of the row.
              const Text('Enable Buttons'),
              Switch(
                value: enabled,
                onChanged: (bool onChangedValue) {
                  print('onChangedValue is $onChangedValue');
                  enabled = onChangedValue;
                  setState(() {
                    if (enabled && timesClicked == 0) {
                      msg1 = 'Click Me';
                      print('enabled is true');
                    } else {
                      msg1 = 'Clicked $timesClicked';
                      print('enabled is false');
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the two buttons here
              // as children of the row.
              // For each button use a
              // "Visibility Widget" and its child
              // will be an "ElevatedButton"
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked++;
                      msg1 = 'Clicked $timesClicked';
                      print('clicked $timesClicked');
                    });
                  },
                  child: Text(msg1),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked = 0;
                      msg1 = 'Click Me';
                      print('clicked $timesClicked');
                    });
                  },
                  child: Text('Reset'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //TODO: Build the text form field
                  // here as the first
                  // child of the column.
                  // Include as the second child
                  // of the column
                  // a submit button that will show a
                  // snackbar with the "firstName"
                  // if validation is satisfied.
                  TextFormField(
                    onChanged: (value) {
                      print(value);
                    },
                    onFieldSubmitted: (text) {
                      print('Submitted Name Text = $text');
                      if (formKey.currentState!.validate()) {
                        print('the name input is now valid');
                      }
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty || input.length > 10) {
                        return 'Enter a value between 1 and 10 characters.';
                      }
                      return null;
                    },
                    onSaved: (input) {
                      if (input != null) {
                        print('onSaved name = $input');
                        msg2 = "Hey there, your name is $input";
                      }
                    },
                    
                    maxLength: 10,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.emoji_emotions),
                      labelText: 'First Name',
                      helperText: 'min 1, max 10',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  ),
                  SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            seconds: 5
                          ),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Hello there! Is your name $firstName?'
                          ),
                          action: SnackBarAction(
                            label: 'Click Me',
                            onPressed: () {
                              print('User clicked on the snackbar button $msg2 times.');
                            },
                            textColor: Theme.of(context).dialogBackgroundColor,
                          ),
                        )
                      );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
