import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ObservedProductManager.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = "/product";
  bool isObserved;

  ProductDetail(this.isObserved);
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  Product _product;
  bool observed;
  bool isObserved;
  int counter = 0;
  ProductManager productManager;
  ObservedProductManager observedManager;

  void setCounter(double val) {
    setState(() {
      counter = val.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    //List<Object> obj = ModalRoute.of(context).settings.arguments;
    //_product = obj.elementAt(0);
    //isObserved = obj.elementAt(1);
    _product = Provider.of<Product>(
        context); //Obtain the data of the product from the provider

    isObserved = widget.isObserved;

    observedManager =
        new ObservedProductManager(FirebaseAuth.instance.currentUser.uid);

    productManager = new ProductManager(
        _product, FirebaseAuth.instance.currentUser.uid, isObserved);

    return new MaterialApp(
        home: Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: true,
              title: new Text(_product.name),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // TODO
                    //put the product into the observable product of the user
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'Cart');
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new SizedBox(height: 10),
                      new Text("Name: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                      new Text(_product.name,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      new SizedBox(height: 10),
                      new Text("Type: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                      new Text(_product.type,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      new SizedBox(height: 10),
                      new Text("Supplier: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                      new Text(_product.supplier,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      new SizedBox(height: 10),
                      new Text("Unitary Price",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                      new Text(_product.price.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      new SizedBox(height: 10),
                      new Text("Available Quantity",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                      new Text(_product.quantity.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      new SizedBox(height: 50),
                      new Text("Select Quantity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      Slider(
                          value: counter.toDouble(),
                          activeColor: Colors.blueAccent,
                          inactiveColor: Colors.blueGrey,
                          min: 0,
                          max: _product.quantity.toDouble(),
                          onChanged: setCounter),
                      Container(
                          child: Center(
                              child: Text("$counter",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)))),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(),
                        ),
                        child: FlatButton(
                          textColor: Colors.white,
                          onPressed: () async {
                            productManager.addInTheCart(counter);
                            //POP UP put in the cart
                          }
                          //TODO
                          //send product and quantity to the cart
                          ,
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),
                    ]))));
  }
}
