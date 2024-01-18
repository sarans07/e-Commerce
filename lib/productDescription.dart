import 'dart:convert';
import 'package:demo_api/Model/productClass.dart';
import 'package:demo_api/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class productDescription extends StatefulWidget {
  const productDescription({super.key, required this.id});

  final int? id;

  @override
  State<productDescription> createState() => _productDescriptionState();
}

class _productDescriptionState extends State<productDescription> {



  Future<Product> fetchProductDetails() async {
    var resp = await http.get(Uri.parse("https://fakestoreapi.com/products/${widget.id}"));

    return Product.fromJson(jsonDecode(resp.body));

  }

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
        ),
        title: Text("Product Description"),
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
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width*1,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: fetchProductDetails(),
                    builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Column(
                      children: [
                        Text(snapshot.data!.title.toString(),
                        style: TextStyle(fontSize: 50),
                        ),
                        Container(

                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width*0.7,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.image.toString(),
                                  ),fit: BoxFit.fill
                              )
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text('Ratings : ${snapshot.data!.rating!.rate.toString()}- (${snapshot.data!.rating!.count.toString()})',
                            style: pagestyle,
                          ),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height*0.05,
                          thickness: 2,
                          color: Colors.black38,
                        ),
                        Row(
                          children: [
                            Text('Product Name : ',
                              style: headings,
                            ),
                            Expanded(
                              child: Text(snapshot.data!.title.toString(),
                                style: pagestyle,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Product Id : ',
                              style: headings,
                            ),
                            Text(snapshot.data!.id.toString(),
                              style: pagestyle,
                            ),
                          ],
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height*0.05,
                          thickness: 2,
                          color: Colors.black38,
                        ),
                        Row(
                          children: [
                            Text('Category : ',
                              style: headings
                            ),
                            Text(snapshot.data!.category.toString(),
                                style: pagestyle
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Price :  ₹ ',
                              style: headings
                            ),
                            Text(snapshot.data!.price.toString(),
                                style: headings
                            ),
                          ],
                        ),

                        Divider(
                          height: MediaQuery.of(context).size.height*0.05,
                          thickness: 2,
                          color: Colors.black38,
                        ),
                        Row(
                          children: [
                            Text('Description : ',
                              style: headings
                            ),
                            Expanded(
                              child: Text(snapshot.data!.description.toString(),
                                  style: pagestyle
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*1,
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text("Add to Cart",
                            style: headings,
                            ),
                          ),
                        ),
                      ],
                    );

                  }else if(snapshot.hasError){
                    return Text('${snapshot.hasError}');
                  }
                  return CircularProgressIndicator();
                    }
                    )
                // Text(widget.description.title.toString(),
                // style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


