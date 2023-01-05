import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/cars/firestore.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCar> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String _manufacturer = '';
  String _price = '';
  CarsProvider carsProvider = CarsProvider();
  List<DocumentSnapshot> carsList = [];

  String _brand = '';
  String _origin = '';
  PhonesProvider phonesProvider = PhonesProvider();
  List<DocumentSnapshot> phonesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: Container(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Manufacturer'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => _manufacturer = value!,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Price'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Price';
                        }
                        return null;
                      },
                      onSaved: (value) => _price = value!,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey!.currentState!.validate()) {
                          _formKey!.currentState!.save();
                          // Add the user to the database.
                          // Navigate back to the previous screen.
                          setState(() {
                            carsList = [];
                          });

                          Cars cars = Cars(_manufacturer, _price);
                          await carsProvider.addCar(cars);
                          //   Navigator.pop(context);
                          _formKey.currentState!.reset();
                        }
                      },
                      child: Text('Add'),
                    ),
                    SizedBox(
                      width: 480,
                      height: 400,
                      child: listOfCars(carsList),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey2,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Brand'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a brand';
                        }
                        return null;
                      },
                      onSaved: (value) => _brand = value!,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Origin'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the origin';
                        }
                        return null;
                      },
                      onSaved: (value) => _origin = value!,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey2!.currentState!.validate()) {
                          _formKey2!.currentState!.save();
                          // Add the user to the database.
                          // Navigate back to the previous screen.
                          setState(() {
                            carsList = [];
                          });

                          Phones phones = Phones(_brand, _origin);
                          await phonesProvider.addPhone(phones);
                          //   Navigator.pop(context);
                          _formKey2.currentState!.reset();
                        }
                      },
                      child: Text('Add Phobe'),
                    ),
                    SizedBox(
                      width: 480,
                      height: 400,
                      child: listOfPhones(phonesList),
                    )
                  ],
                ),
              ),
            ])));
  }
}

Widget listOfCars(cars) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return StreamBuilder<QuerySnapshot>(
    stream: firestore.collection('cars').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      ;

      snapshot.data!.docs.forEach((doc) {
        cars.add(doc);
      });

      return ListView.builder(
        shrinkWrap: true,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = cars[index];
          return ListTile(
            tileColor: Colors.amberAccent,
            title: Text((document.data() as dynamic)['manufacturer']),
            subtitle: Text((document.data() as dynamic)['price']),
          );
        },
      );
    },
  );
}

Widget listOfPhones(phones) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return StreamBuilder<QuerySnapshot>(
    stream: firestore.collection('phones').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      ;

      snapshot.data!.docs.forEach((doc) {
        phones.add(doc);
      });

      return ListView.builder(
        shrinkWrap: true,
        itemCount: phones.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = phones[index];
          return ListTile(
            tileColor: Colors.redAccent,
            title: Text((document.data() as dynamic)['brand']),
            subtitle: Text((document.data() as dynamic)['origin']),
          );
        },
      );
    },
  );
}
