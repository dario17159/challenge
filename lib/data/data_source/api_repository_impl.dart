import 'package:pickit_challenge/domain/models/owner.dart';
import 'package:pickit_challenge/domain/models/cars_of_owner.dart';
import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/repository/api_repository.dart';

class ApiResposotyImpl implements ApiRepository {
  @override
  Future<bool> deleteCarByPatent(String patent) async {
    return false;
  }

  @override
  Future<CarsOfOwner> getCard(String patent) async {
    // TODO: implement getCard
    throw UnimplementedError();
  }

  @override
  Future<List<CarsOfOwner>> getListOfCars() async {
    return <CarsOfOwner>[];
  }

  @override
  Future<bool> registerMultipleServicesOfCar(
      String patent, List<String> idServices) async {
    return false;
  }

  @override
  Future<bool> registerNewCar(Car car, Owner owner) async {
    return false;
  }

  @override
  Future<bool> updateCarInformation(Car car) async {
    return false;
  }
}
