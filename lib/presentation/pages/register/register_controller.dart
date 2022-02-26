import 'package:get/get.dart';
import 'package:pickit_challenge/constants/custom_constants.dart';
import 'package:pickit_challenge/domain/repository/api_repository.dart';

class RegisterController extends GetxController {
  final ApiRepository apiRepository;

  RegisterController({required this.apiRepository});

  RxString _registerType = ''.obs;
  RxString get getRegisterType => this._registerType;

  RxString _appBarTitle = ''.obs;
  RxString get getAppBarTitle => this._appBarTitle;

  @override
  void onInit() {
    this._registerType.value = Get.arguments;
    this._init();
    super.onInit();
  }

  Future<void> _init() async {
    switch (this._registerType.value) {
      case CustomConstants.TYPE_CAR:
        this._appBarTitle.value = 'Registrar automóvil';
        break;
      case CustomConstants.TYPE_OWNER:
        this._appBarTitle.value = 'Registrar propietario';
        break;
      case CustomConstants.TYPE_SERVICE:
        this._appBarTitle.value = 'Registrar servicio';
        break;
    }
  }
}
