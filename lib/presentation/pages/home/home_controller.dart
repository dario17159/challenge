import 'package:get/get.dart';
import 'package:pickit_challenge/domain/models/cars_of_owner.dart';
import 'package:pickit_challenge/domain/repository/api_repository.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;

  HomeController({
    required this.apiRepository,
  });

  RxList<CarsOfOwner> cars = <CarsOfOwner>[].obs;

  @override
  void onInit() {
    this._getListOfCars();
    super.onInit();
  }

  Future<void> _getListOfCars() async{
    final result =  await this.apiRepository.getListOfCars();
    this.cars.clear();
    this.cars.addAll(result);
  }
}
