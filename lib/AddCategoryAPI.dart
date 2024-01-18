import 'dart:convert';

import 'package:flutter/material.dart';

import 'Model/successcalss.dart';
import 'package:http/http.dart' as http;

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Future<Success>? _future ;
  
  Future<Success> AddNewCategory(String category, String desc,) async
  {
    var resp = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/category/insertcategory"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "categoryId": 0,
        "category":category,
        "description":desc,
        "createdBy":1
      }),

    );
    return Success.fromJson(jsonDecode(resp.body));

  }
  
  TextEditingController txtCategory =  TextEditingController();
  TextEditingController txtDesc= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_future == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }
  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: txtCategory,
          decoration: const InputDecoration(hintText: 'Enter Category'),
        ),
        TextField(
          controller: txtDesc,
          decoration: const InputDecoration(hintText: 'Enter Desc'),
        ),

        ElevatedButton(
          onPressed: () {
            setState(() {
              _future = AddNewCategory(txtCategory.text,txtDesc.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }
  FutureBuilder<Success> buildFutureBuilder() {
    return FutureBuilder<Success>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.success.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
