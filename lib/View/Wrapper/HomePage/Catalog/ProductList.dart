import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';

import 'package:like_eat/View/Wrapper/HomePage/Catalog/ProductTile.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductTile(products[index]);
        });
  }
}
