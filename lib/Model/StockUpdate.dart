import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Product.dart';

class StockUpdate extends Notification {
  bool _stillActive;

  StockUpdate(Product referenceProduct) : super(referenceProduct);

  //Getter
  bool get stillActive => _stillActive;

  //Setter
  set stillActive(bool value) => _stillActive = value;

  //Change method: Will Swapp the Still active attribute from true to false and viceversa
  change() {
    if (this._stillActive == true)
      this._stillActive = false;
    else
      this._stillActive = true;
  }
}
