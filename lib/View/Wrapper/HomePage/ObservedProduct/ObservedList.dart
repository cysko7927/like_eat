import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ObservedProductManager.dart';
import 'package:provider/provider.dart';

class ObservedList extends StatefulWidget {
  @override
  _ObservedListState createState() => _ObservedListState();
}

class _ObservedListState extends State<ObservedList> {
  @override
  Widget build(BuildContext context) {
    final List<Product> observed = Provider.of<List<Product>>(context);

    if (observed != null) {
      return ListView.builder(
          itemCount: observed.length,
          itemBuilder: (context, index) {
            return ObservedTile(observed.elementAt(index), index);
          });
    } else {
      return ListView.builder(
          itemCount: new List<Product>().length,
          itemBuilder: (context, index) {
            return ObservedTile(observed[index], index);
          });
    }
  }
}

class ObservedTile extends StatelessWidget {
  final Product product;
  final int index;
  ObservedProductManager observedProductManager =
      ObservedProductManager(FirebaseAuth.instance.currentUser.uid);
  ObservedTile(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(product.name),
            subtitle: Text(product.supplier),
            /*trailing: Wrap(
              children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      observedProductManager.insertOrRemoveProduct(
                          product, true);
                    }),
              ],
            ),*/
          ),
        ));
  }
}
