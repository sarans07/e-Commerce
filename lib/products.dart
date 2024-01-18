import 'dart:convert';

import 'package:demo_api/TextStyle.dart';
import 'package:demo_api/productDescription.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:badges/badges.dart' as badges;


import 'Model/productClass.dart';



class product extends StatefulWidget {
  const product({super.key});

  @override
  State<product> createState() => _productState();
}

class _productState extends State<product> {

  late Future<List<Product>> _items;

  Future <List<Product>> fetchProductDetails()async{
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = (jsonDecode(res.body));
    return(data as List).map((e) => Product.fromJson(e)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _items = fetchProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Products List',
        style: headings,
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              badgeContent: Text("0"),
                child: Icon(Icons.add_shopping_cart,size: 30,)),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.yellow[100],
            child: Column(
              children: [
                FutureBuilder(
                    future: _items,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        List<Product> list = snapshot.data!;
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>productDescription(
                                          id: list[index].id))
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.3,
                                    width: MediaQuery.of(context).size.width*1,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.grey),
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: MediaQuery.of(context).size.height*0.2,
                                            width: MediaQuery.of(context).size.width*0.3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(list[index].image.toString()),
                                                fit: BoxFit.fill,
                                              )
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 40),
                                                Expanded(
                                                  child: Text(list[index].title.toString(),
                                                  style: headings
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text('₹',
                                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                    ),SizedBox(width: 5),
                                                    Text(list[index].price.toString(),
                                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Ratings ${list[index].rating!.rate.toString()}",
                                                      style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 15),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text('(${list[index].rating!.count.toString()}) reviews',
                                                        style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text('Product Id - ${list[index].id.toString()}',
                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(list[index].category.toString(),
                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                      return CircularProgressIndicator();
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
