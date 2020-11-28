class Product {
  String _supplier;
  String _type;
  String _name;
  double _price;
  int _quantity;

  Product(this._supplier, this._type, this._name, this._price, this._quantity);

  String get supplierGet => _supplier;
  String get typeGet => _type;
  String get nameGet => _name;
  double get priceGet => _price;
  int get quantityGet => _quantity;

  set supplierSet(String supplier) => _supplier = supplier;
  set typeSet(String type) => _type = type;
  set nameSet(String name) => _name = name;
  set priceSet(double price) => _price = price;
  set quantitySet(int quantity) => _quantity = quantity;
}
