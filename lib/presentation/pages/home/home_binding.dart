import 'package:get/get.dart';
import 'package:pickit_challenge/data/data_source/api_repository_impl.dart';
import 'package:pickit_challenge/presentation/pages/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        apiRepository: ApiResposotyImpl(),
      ),
    );
  }
}
