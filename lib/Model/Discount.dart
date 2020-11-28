import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Product.dart';

class Discount extends Notification {
  double _percentage;
  bool _stillActive;
  Discount(Product referenceProduct) : super(referenceProduct);

  //Getter
  double get percentage => _percentage;
  bool get stillActive => _stillActive;

  //Setter
  set percentage(double percentage) => _percentage = percentage;
  set stillActive(bool value) => _stillActive = value;

  //Change method: Will Swapp the Still active attribute from true to false and viceversa
  change() {
    if (this._stillActive == true)
      this._stillActive = false;
    else
      this._stillActive = true;
  }
}
