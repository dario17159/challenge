import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickit_challenge/constants/collection.dart';
import 'package:pickit_challenge/domain/models/owner.dart';
import 'package:pickit_challenge/domain/models/cars_of_owner.dart';
import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/models/service.dart';
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
    try {
      final owners = await this._owner.get();
      final listOfData = <CarsOfOwner>[];
      for (var doc in owners.docs) {
        final owner = Owner.fromMap(doc.data() as Map<String, dynamic>);
        owner.dni = int.parse(doc.id);
        final carsOfOwner = await this
            ._car
            .where('ownerId', isEqualTo: owner.dni.toString())
            .get();
        final cars = <Car>[];
        for (var doc in carsOfOwner.docs) {
          final car = Car.fromMap(doc.data() as Map<String, dynamic>);
          car.patent = doc.id;
          cars.add(car);
        }
        listOfData.add(CarsOfOwner(cars: cars, owner: owner));
      }
      return listOfData;
    } catch (_) {
      return <CarsOfOwner>[];
    }
  }

  @override
  Future<bool> registerMultipleServicesOfCar(
      Car car, List<Service> services) async {
    try {
      for (var service in services) {
        car.servicesId!.add(service.idService!);
      }

      await this._car.doc(car.patent).update(car.toMap());

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> registerNewCar(Car car, Owner owner) async {
    try {
      await this._owner.doc(owner.dni.toString()).update(owner.toMap());
      await this._car.doc(car.patent).set(car.toMap());
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

  @override
  Future<List<Service>> getServices() async {
    try {
      final serviceList = <Service>[];
      final result = await this._service.get();
      for (var doc in result.docs) {
        final service = Service.fromMap(doc.data() as Map<String, dynamic>);
        service.idService = doc.id;
        serviceList.add(service);
      }
      return serviceList;
    } catch (_) {
      return <Service>[];
    }
  }

  @override
  Future<List<Owner>> getOwners() async {
    try {
      final ownerList = <Owner>[];
      final result = await this._owner.get();
      for (var doc in result.docs) {
        final owner = Owner.fromMap(doc.data() as Map<String, dynamic>);
        owner.dni = int.parse(doc.id);
        ownerList.add(owner);
      }
      return ownerList;
    } catch (_) {
      return <Owner>[];
    }
  }

  @override
  Future<List<Car>> getCarsOfOwners(String dniOwner) async {
    try {
      final carList = <Car>[];
      final result =
          await this._car.where('ownerId', isEqualTo: dniOwner).get();
      for (var doc in result.docs) {
        final car = Car.fromMap(doc.data() as Map<String, dynamic>);
        car.patent = doc.id;
        carList.add(car);
      }
      return carList;
    } catch (_) {
      return <Car>[];
    }
  }

  @override
  Future<bool> registerNewOwner(Owner owner) async {
    try {
      await this._owner.doc(owner.dni.toString()).set(owner.toMap());
      return true;
    } catch (_) {
      return false;
    }
  }
}
