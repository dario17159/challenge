import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pickit_challenge/constants/custom_constants.dart';
import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/models/owner.dart';
import 'package:pickit_challenge/domain/models/service.dart';
import 'package:pickit_challenge/domain/repository/api_repository.dart';

class RegisterController extends GetxController {
  final ApiRepository apiRepository;

  RegisterController({required this.apiRepository});

  RxBool gettingData = true.obs;

  /* Fields to register Car */
  TextEditingController carBrandController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carYearController = TextEditingController();
  TextEditingController carPatentController = TextEditingController();
  TextEditingController carColorController = TextEditingController();

  /* Fields to register Owner */
  TextEditingController ownerDniController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerLastnameController = TextEditingController();

  RxString _registerType = ''.obs;
  RxString get getRegisterType => this._registerType;

  RxString _appBarTitle = ''.obs;
  RxString get getAppBarTitle => this._appBarTitle;

  RxList<Service> serviceList = <Service>[].obs;
  RxList<Owner> ownerList = <Owner>[].obs;
  RxList<Car> carList = <Car>[].obs;

  Rx<Owner?> selectorOwnerValue = Rx<Owner?>(null);
  Rx<Car?> selectorCarValue = Rx<Car?>(null);

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
        await this._getOwners();
        this.gettingData.value = false;
        break;
      case CustomConstants.TYPE_OWNER:
        this._appBarTitle.value = 'Registrar propietario';
        this.gettingData.value = false;
        break;
      case CustomConstants.TYPE_SERVICE:
        this._appBarTitle.value = 'Registrar servicio';
        await this._getServices();
        await this._getOwners();
        this.gettingData.value = false;
        break;
    }
  }

  Future<void> _getServices() async {
    final services = await this.apiRepository.getServices();
    this.serviceList.clear();
    this.serviceList.addAll(services);
  }

  Future<void> _getOwners() async {
    final owners = await this.apiRepository.getOwners();
    this.ownerList.clear();
    this.ownerList.addAll(owners);
  }

  Future<void> _getCarOfOwner(String dniOwner) async {
    final cars = await this.apiRepository.getCarsOfOwners(dniOwner);
    this.carList.clear();
    this.carList.addAll(cars);
  }

  void changeServiceStatusSelected(int index, bool value) {
    this.serviceList[index].isSelected = value;
    update(['check']);
  }

  void changeSelectorOwnerValue(String? value) {
    for (var owner in this.ownerList) {
      if (owner.dni.toString() == value.toString()) {
        this.selectorOwnerValue.value = owner;
        if (this._registerType.value == CustomConstants.TYPE_SERVICE) {
          this._getCarOfOwner(owner.dni.toString());
        }
      }
    }
  }

  void changeSelectorCarValue(String? value) {
    for (var car in this.carList) {
      if (car.patent == value) {
        this.selectorCarValue.value = car;
      }
    }
  }

  Future<bool> registerCar() async {
    final car = Car(
      patent: this.carPatentController.text,
      brand: this.carBrandController.text,
      model: this.carModelController.text,
      year: int.parse(this.carYearController.text),
      color: this.carColorController.text,
      ownerId: this.selectorOwnerValue.value?.dni.toString() ?? '',
    );
    this.selectorOwnerValue.value?.carsPatents.add(car.patent.toString());

    return await this
        .apiRepository
        .registerNewCar(car, this.selectorOwnerValue.value!);
  }

  bool validateCarControllers() {
    if (this.carBrandController.text.isEmpty) {
      return false;
    }

    if (this.carModelController.text.isEmpty) {
      return false;
    }

    if (this.carYearController.text.isEmpty) {
      return false;
    }

    if (this.carPatentController.text.isEmpty) {
      return false;
    }

    if (this.carColorController.text.isEmpty) {
      return false;
    }

    return true;
  }

  bool validateOwnerControllers() {
    if (this.ownerDniController.text.isEmpty) {
      return false;
    }

    if (this.ownerNameController.text.isEmpty) {
      return false;
    }

    if (this.ownerLastnameController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<bool> registerOwner() async {
    final owner = Owner(
      dni: int.parse(this.ownerDniController.text),
      name: this.ownerNameController.text,
      lastname: this.ownerLastnameController.text,
      carsPatents: [],
    );
    return await this.apiRepository.registerNewOwner(owner);
  }

  bool validateSelectors(){
    if(this.selectorCarValue.value == null){
      return false;
    }
    if(this.selectorOwnerValue.value == null){
      return false;
    }
    bool serviceSelected = false;
    for(var service in this.serviceList){
      if(service.isSelected){
        serviceSelected = true;
      }
    }
    if(!serviceSelected){
      return false;
    }
    return true;
  }

  Future<bool> registerServices() async{
    final servicesSelected = <Service>[];
    for(var service in this.serviceList){
      if(service.isSelected){
        servicesSelected.add(service);
      }
    }
    return await this.apiRepository.registerMultipleServicesOfCar(this.selectorCarValue.value!, servicesSelected);
  }
}
