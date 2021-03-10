import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

/**
 * This class allows to handle the Shipping Address of the user
 * and  store them for the view
 * The single Shipping Address is immutable
 */
class AddressDataManager extends ChangeNotifier {
  final String uidUser; //UID of the user whose addresses you want
  CollectionReference addressShipping =
      FirebaseFirestore.instance.collection('ShippingAddress');

  List<ShippingAddress> _listOfShippingAddress = [];

  AddressDataManager(this.uidUser);

  void obtainShippingAddress() async {
    QuerySnapshot result =
        await addressShipping.where('uidUser', isEqualTo: uidUser).get();

    _listOfShippingAddress = _shippingAddressListFromSnapshot(result);
  }

  /**
   * Add a new Shipping Address in the DB for the user
   */
  void addShippingAddress(String state, String address, String city, String cap,
      String number) async {
    addressShipping.add({
      'address': address,
      'cap': cap,
      'city': city,
      'number': number,
      'state': state,
      'uidUser': uidUser,
    }); //Add the new Address to DB

    obtainShippingAddress(); //Update the list of shipping Address No Stream
  }

  /**
   * Remove a Shipping Address from the DB using the index in input
   * Precondition: the selected address must be exist in the DB
   */
  void removeShippingAddress(int index) async {
    ShippingAddress selected = _listOfShippingAddress
        .elementAt(index); //Take the address from the local list

    //obtain the reference to the address to remove
    QuerySnapshot result = await addressShipping
        .where('uidUser', isEqualTo: uidUser)
        .where('address', isEqualTo: selected.address)
        .where('cap', isEqualTo: selected.cap)
        .where('city', isEqualTo: selected.city)
        .where('number', isEqualTo: selected.number)
        .where('state', isEqualTo: selected.state)
        .get(); //obtain the reference of the selected address from DB

    addressShipping
        .doc(result.docs.elementAt(0).id)
        .delete(); //Remove the selected Address to DB

    obtainShippingAddress(); //Update the list of shipping Address inside the object
  }

  //obtain the stream of the list of address of the user with uid = uidUser from this class
  Stream<List<ShippingAddress>> get address {
    obtainShippingAddress(); //Update the list of shipping Address inside the object
    return addressShipping
        .where('uidUser', isEqualTo: uidUser)
        .snapshots()
        .map(_shippingAddressListFromSnapshot);
  }

  //Convert The querySnapshot that contains the Shipping Address in a list
  //that contains those Shipping Address
  //Precondition: The snapshot must contain the Address with the correct parameters
  List<ShippingAddress> _shippingAddressListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => ShippingAddress(
            doc.data()['state'] ?? '',
            doc.data()['address'] ?? '',
            doc.data()['city'] ?? '',
            doc.data()['cap'] ?? '',
            doc.data()['number'] ?? '',
            doc.data()['uidUser'] ?? ''))
        .toList();
  }

  List<ShippingAddress> get addressS => _listOfShippingAddress;
}
