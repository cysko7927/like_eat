import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Product.dart';

class StockUpdate extends Notification {
  bool _stillActive;

  StockUpdate(Product referenceProduct) : super(referenceProduct);

  bool get stillActiveGet => _stillActive;
  set stillActiveSet(bool value) => _stillActive = value;

  change() {
    if (this._stillActive == true)
      this._stillActive = false;
    else
      this._stillActive = true;
  }
}
