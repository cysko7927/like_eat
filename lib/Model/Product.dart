class Product {
  String _supplier;
  String _type;
  String _name;
  double _price;
  int _quantity;

  //Constructor
  Product(this._supplier, this._type, this._name, this._price, this._quantity);

  //Getter
  String get supplier => _supplier;
  String get type => _type;
  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;

  //Setter
  set supplier(String supplier) => _supplier = supplier;
  set type(String type) => _type = type;
  set name(String name) => _name = name;
  set price(double price) => _price = price;
  set quantity(int quantity) => _quantity = quantity;
}
