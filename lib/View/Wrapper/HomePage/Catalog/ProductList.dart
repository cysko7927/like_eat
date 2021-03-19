import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';

import 'package:like_eat/View/Wrapper/HomePage/Catalog/ProductTile.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;
  ProductList(this.products);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override

  Widget build(BuildContext context) {
    List<Product> products = widget.products;

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductTile(products[index]);
        });
  }
}
