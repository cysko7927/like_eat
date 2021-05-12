import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/View/Wrapper/HomePage/Catalog/ProductList.dart';

import 'package:direct_select/direct_select.dart';
import 'package:like_eat/ViewModel/SearchManager.dart';
import 'package:provider/provider.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  TextEditingController searchController = TextEditingController();

  String search = '';
  bool _available = true;
  List<Product> products = new List<Product>();

  SearchManager searchManager = new SearchManager();

  bool _visible = false;

  final elements = [
    "All",
    "Cereal",
    "Fruit",
    "Legumes",
    "Vegetables",
  ];
  int selectedIndex = 0;

  List<Widget> _buildItems() {
    return elements
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Catalog'),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 5),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search Product',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (text) async {
                  search = text;
                  await searchManager.searchProduct(
                      search, elements[selectedIndex], _available);
                  setState(() {
                    products = new List<Product>();
                    products.addAll(searchManager.products);
                  });
                },
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 30.0, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FlatButton(
                      textColor: Colors.white,
                      child: Text("Avanced Research"),
                      onPressed: () {
                        setState(() {
                          if (_visible)
                            _visible = false;
                          else
                            _visible = true;
                        });
                      }),
                )
              ],
            ),
            if (_visible)
              Container(
                child: Row(
                  children: [
                    Checkbox(
                        value: _available,
                        onChanged: (value) {
                          setState(() {
                            _available = value;
                          });
                        }),
                    Expanded(
                        child: Container(
                            child: Text("Search only available product"))),
                  ],
                ),
              ),
            if (_visible)
              DirectSelect(
                  itemExtent: 50.0,
                  selectedIndex: selectedIndex,
                  child: MySelectionItem(
                    isForList: false,
                    title: elements[selectedIndex],
                  ),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  items: _buildItems()),
            Container(
              child: SizedBox(
                  height: 200.0,
                  child: StreamProvider<List<Product>>.value(
                      value: searchManager.productsStream,
                      child: ProductList(products))),
            ),
          ],
        )));
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
