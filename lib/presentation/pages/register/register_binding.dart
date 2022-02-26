import 'package:get/get.dart';
import 'package:pickit_challenge/data/data_source/api_repository_impl.dart';
import 'package:pickit_challenge/presentation/pages/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterController(
        apiRepository: ApiResposotyImpl(),
      ),
    );
  }
}
