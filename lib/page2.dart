import 'package:flutter/material.dart';
class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final _formKey = GlobalKey<FormState>();

  String field1Value = '';
  String field2Value = '';
  String field3Value = '';
  String field4Value = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Table(
            defaultColumnWidth: FixedColumnWidth(150.0),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Field 1'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field 1 is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        field1Value = value!;
                      },
                    ),
                  ),
                  TableCell(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Field 2'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field 2 is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        field2Value = value!;
                      },
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Field 3'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field 3 is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        field3Value = value!;
                      },
                    ),
                  ),
                  TableCell(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Field 4'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field 4 is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        field4Value = value!;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}