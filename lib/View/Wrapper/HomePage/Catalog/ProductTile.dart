import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              title: Text(product.name),
              subtitle: Text(product.price.toString() +
                  " " +
                  product.quantity.toString() +
                  " " +
                  product.supplier)),
        ));
  }
}
