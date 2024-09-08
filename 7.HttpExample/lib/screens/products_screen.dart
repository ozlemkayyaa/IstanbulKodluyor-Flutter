import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpexample/models/product_response.dart';
import 'package:httpexample/widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductResponse> productList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    Uri url = Uri.https("dummyjson.com", "products");
    // http istekleri ASYNC'dır
    // await keywordü
    final response = await http.get(url);
    final data = json.decode(response.body);
    final products = data["products"];
    List<ProductResponse> productsFromWebAPI = [];

    for (final item in products) {
      ProductResponse product = ProductResponse(
          id: item["id"],
          title: item["title"],
          description: item["description"],
          price: item["price"],
          imgUrl: item["thumbnail"]);
      productsFromWebAPI.add(product);
    }

    setState(() {
      productList = productsFromWebAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (ctx, index) => ProductItem(
            imgUrl: productList[index].imgUrl, title: productList[index].title),
      ),
    );
  }
}
