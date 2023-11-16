import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/Http/httphelper.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_login/flutter_login.dart';

class HomePage extends StatefulWidget {
  final String wid;
  const HomePage({super.key, required this.wid});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String? email;
  List<Product> products = [];
  String result = "";
  late HttpHelper helper;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final value = await helper.getMovie();
      final List<dynamic> decodedData = json.decode(value);

      List<Product> productList = [];

      for (var productData in decodedData) {
        productList.add(Product.fromJson(productData));
      }

      setState(() {
        products = productList;
      });
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_sharp),
              tooltip: 'Logout',
              onPressed: () {},
            )
          ],
        ),
        body: Row(
          children: [
            Container(
                child: Column(
              children: [
                Text("Welcome $email"),
                Text("ID ${widget.wid}"),
              ],
            )),
            /*ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].title),
                  subtitle: Text(
                      "Price: \$${products[index].price.toStringAsFixed(2)}"),
                  leading: Image.network(
                      products[index].imageUrl), // Display the image
                );
              },
            ),*/
          ],
        ));
  }
}
