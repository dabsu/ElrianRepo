import 'package:cloud_firestore/cloud_firestore.dart';

class Cars {
  String id = '';
  String manufacturer = '';
  String price = '0';

  Cars(this.manufacturer, this.price);

  Cars.fromMap(Map<String, dynamic> map) {
    manufacturer = map['manufacturer'];
    price = map['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'manufacturer': manufacturer,
      'price': price,
    };
  }
}

class CarsProvider {
  late CollectionReference _carsCollection;

  CarsProvider() {
    _carsCollection = FirebaseFirestore.instance.collection('cars');
  }

  Future<List<Cars>> getCars() async {
    QuerySnapshot snapshot = await _carsCollection.get();
    return snapshot.docs.map((doc) => Cars.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Stream<List<Cars>> streamCars() {
    return _carsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Cars.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<Cars> getCar(String id) async {
    DocumentSnapshot snapshot = await _carsCollection.doc(id).get();
    return Cars.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> addCar(Cars cars) async {
    await _carsCollection.add(cars.toMap());
  }

  Future<void> updateCar(Cars todo) async {
    await _carsCollection.doc(todo.id).update(todo.toMap());
  }

  Future<void> deleteTodo(String id) async {
    await _carsCollection.doc(id).delete();
  }
}



class Phones {
  String id = '';
  String brand = '';
  String origin = '';

  Phones(this.brand, this.origin);

  Phones.fromMap(Map<String, dynamic> map) {
    brand = map['brand'];
    origin = map['origin'];
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'origin': origin,
    };
  }
}

class PhonesProvider {
  late CollectionReference _phonesCollection;

  PhonesProvider() {
    _phonesCollection = FirebaseFirestore.instance.collection('phones');
  }

  Future<List<Phones>> getPhones() async {
    QuerySnapshot snapshot = await _phonesCollection.get();
    return snapshot.docs.map((doc) => Phones.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Stream<List<Phones>> streamPhones() {
    return _phonesCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Phones.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<Phones> getPhone(String id) async {
    DocumentSnapshot snapshot = await _phonesCollection.doc(id).get();
    return Phones.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> addPhone(Phones cars) async {
    await _phonesCollection.add(cars.toMap());
    
  }

  Future<void> updatePhone(Phones todo) async {
    await _phonesCollection.doc(todo.id).update(todo.toMap());
  }

  Future<void> deletePhone(String id) async {
    await _phonesCollection.doc(id).delete();
  }
}
