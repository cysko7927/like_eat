import 'package:flutter/material.dart';
import 'package:like_eat/Model/Order.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);

    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderTile(orders[index]);
        });
  }
}
class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              title: Text(order.productAndQuantity.toString()),
              subtitle: Text(order.time)),
        ));
  }
}

