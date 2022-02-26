import 'package:get/get.dart';
import 'package:pickit_challenge/domain/repository/api_repository.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;

  HomeController({
    required this.apiRepository,
  });

  @override
  void onInit() {
    this._getListOfCars();
    super.onInit();
  }

  Future<void> _getListOfCars() async{
    // await this.apiRepository.getListOfCars();
  }
}
