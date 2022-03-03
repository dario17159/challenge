import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/models/cars_of_owner.dart';
import 'package:pickit_challenge/domain/models/owner.dart';
import 'package:pickit_challenge/domain/models/service.dart';

abstract class ApiRepository {
  Future<bool> registerNewCar(Car car, Owner owner); // Registrar un nuevo auto incluye un propietario
  Future<bool> registerNewOwner( Owner owner); // Registrar un nuevo auto incluye un propietario
  Future<bool> deleteCarByPatent(String patent); // Eliminar un auto
  Future<bool> updateCarInformation(Car car); // Actualizar un auto
  Future<List<CarsOfOwner>>
      getListOfCars(); // Obtener listado de autos con sus propietarios
  Future<CarsOfOwner> getCar(
      String patent); // Obtener un auto con su respectivo propietario

  // Future<bool> registerNewOwner(Owner owner); // Registrar
  Future<bool> registerMultipleServicesOfCar(Car car, List<Service> idServices);
  Future<List<Service>> getServices();
  Future<List<Owner>> getOwners();
  Future<List<Car>> getCarsOfOwners(String dniOwner);
}
