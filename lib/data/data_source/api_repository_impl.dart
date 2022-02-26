import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickit_challenge/constants/collection.dart';
import 'package:pickit_challenge/domain/models/owner.dart';
import 'package:pickit_challenge/domain/models/cars_of_owner.dart';
import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/repository/api_repository.dart';

class ApiResposotyImpl implements ApiRepository {
  CollectionReference _owner =
      FirebaseFirestore.instance.collection(Collection.OWNER);
  CollectionReference _car =
      FirebaseFirestore.instance.collection(Collection.CAR);
  CollectionReference _service =
      FirebaseFirestore.instance.collection(Collection.SERVICE);

  @override
  Future<bool> deleteCarByPatent(String patent) async {
    // Need update owner data, and delete from cars collection
    try {
      final carData = await this._car.doc(patent).get();
      final car = Car.fromMap(carData.data() as Map<String, dynamic>);
      final ownerData = await this._owner.doc(car.ownerId).get();
      final owner = Owner.fromMap(ownerData.data() as Map<String, dynamic>);
      owner.carsPatents.remove(patent);
      await this._owner.doc(car.ownerId).update(owner.toMap());
      await this._car.doc(patent).delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<CarsOfOwner> getCar(String patent) async {
    final carData = await this._car.doc(patent).get();
    final car = Car.fromMap(carData.data() as Map<String, dynamic>);
    car.patent = carData.id;
    final ownerData = await this._owner.doc(car.ownerId).get();
    final owner = Owner.fromMap(ownerData.data() as Map<String, dynamic>);
    owner.dni = int.parse(ownerData.id);

    return CarsOfOwner(cars: [car], owner: owner);
  }

  @override
  Future<List<CarsOfOwner>> getListOfCars() async {
    final result = await this._car.get();
    for (var doc in result.docs) {
      final car = Car.fromMap(doc.data() as Map<String, dynamic>);
      car.patent = doc.id;
      final ownerData = await this._owner.doc(car.ownerId).get();
      final owner = Owner.fromMap(ownerData.data() as Map<String, dynamic>);
      owner.dni = int.parse(ownerData.id);
      print('');
    }

    return <CarsOfOwner>[];
  }

  @override
  Future<bool> registerMultipleServicesOfCar(
      String patent, List<String> idServices) async {
    return false;
  }

  @override
  Future<bool> registerNewCar(Car car, Owner owner) async {
    try {
      await this._owner.doc(owner.dni.toString()).set(owner);
      await this._car.doc(car.patent).set(car);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateCarInformation(Car car) async {
    try {
      await this._car.doc(car.patent).update(car.toMap());
      return true;
    } catch (_) {
      return false;
    }
  }
}
