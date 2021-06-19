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

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  void initState() {
    super.initState();

    loadProduct().then((_product) {
      setState(() {
        this._product = _product;
      });
    });
  }

  Future loadProduct() async {
    _product =
        new Product("", "", "", 0, 0); // load your data from SharedPreferences
    return _product;
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

    if (_product == null) {
      loadProduct();
      return LoadingScreen();
    } else {
      return new MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.lightBlue[100],
              appBar: new AppBar(
                automaticallyImplyLeading: true,
                title: new Text(_product.name),
                leading: IconButton(
                  key: ValueKey("Product_backIcon"),
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                ),
                actions: <Widget>[
                  IconButton(
                    key: ValueKey("Product_observed_icon"),
                    icon: Icon(
                      Icons.favorite,
                      color: isObserved ? Colors.red : Colors.white,
                    ),
                    onPressed: () async {
                      // TODO
                      //put the product into the observable product of the user
                      await productManager.modifyObservable();
                      setState(
                          () => widget.isObserved = productManager.isObserved);
                    },
                  ),
                  IconButton(
                    key: ValueKey("Product_cart_icon"),
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
                  key: ValueKey("pageview"),
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
                            key: ValueKey("Product_quantity_slider"),
                            value: counter.toDouble(),
                            activeColor: Colors.blueAccent,
                            inactiveColor: Colors.blueGrey,
                            min: 0,
                            max: _product.quantity.toDouble(),
                            onChanged: setCounter),
                        Container(
                            key: ValueKey("Product_quantity_text"),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: FlatButton(
                            key: ValueKey("Product_addToCart_button"),
                            textColor: Colors.white,
                            onPressed: () async {
                              //if we have something to insert...
                              if (counter != 0) {
                                productManager.addInTheCart(counter);
                                resetCounter();
                                //POP UP put in the cart
                              }
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
}

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Paint the area where the inner widgets are loaded with the
            /// background to keep consistency with the screen background
            new Container(
              decoration: BoxDecoration(color: Colors.black),
            ),

            /// Render the Title widget, loader and messages below each other
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Loader Animation Widget
                      CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      Text("Loading Product"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
