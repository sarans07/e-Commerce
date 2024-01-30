import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Catclass.dart';
class cat extends StatefulWidget {
  const cat({super.key});

  @override
  State<cat> createState() => _catState();
}

class _catState extends State<cat> {

  Future<Cat> fetchCatDetails()async{
    var res = await http.get(Uri.parse("https://catfact.ninja/fact"));
    return Cat.fromJson(jsonDecode(res.body));

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details form API"),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<Cat>(
              future: fetchCatDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.fact.toString()),
                      Text(snapshot.data!.length.toString()),
                    ],
                  );
                }else if (snapshot.hasError){
                  return Text('${snapshot.hasError}');
                }
                return const CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
