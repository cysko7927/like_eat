import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/View/Wrapper/HomePage/Catalog/ProductList.dart';

import 'package:direct_select/direct_select.dart';
import 'package:like_eat/ViewModel/SearchManager.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  TextEditingController searchController = TextEditingController();
  String search = '';
  bool _available = false;
  List<Product> products=new List<Product>();

  SearchManager searchManager = new SearchManager();

  final elements = [
    "Cereal",
    "Fruit",
    "Legumes",
    "casuale",
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Catalog'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'Setting');
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
              
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search Product',
              ),
              onChanged: (text) {
                setState(() {
                  search = text;
                  searchManager.searchProduct(search,elements[selectedIndex],_available);
                  products=new List<Product>();
                  products.addAll(searchManager.products);
                  
                });
              },
            ),
            ),
            Row(
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
              child: SizedBox(height: 200.0, child: ProductList(products)),
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
      height: 100.0,
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


