import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickit_challenge/constants/custom_constants.dart';
import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/models/owner.dart';
import 'package:pickit_challenge/presentation/pages/register/register_controller.dart';

class RegisterPage extends GetWidget<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(controller.getAppBarTitle.value))),
      body: Obx(
        () {
          if (controller.gettingData.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.getRegisterType.value == CustomConstants.TYPE_CAR) {
              return _FormRegisterACar(
                controller: controller,
              );
            } else if (controller.getRegisterType.value ==
                CustomConstants.TYPE_OWNER) {
              return _FormRegisterOwner(
                controller: controller,
              );
            } else {
              return _FormRegisterService(controller: controller);
            }
          }
        },
      ),
    );
  }
}

class _FormRegisterService extends StatelessWidget {
  final RegisterController controller;

  _FormRegisterService({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Obx(
            () => DropdownButton<String>(
              value: controller.selectorOwnerValue.value?.dni.toString(),
              isExpanded: true,
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
              hint: Text('Seleccione un propietario'),
              onChanged: controller.changeSelectorOwnerValue,
              items: controller.ownerList
                  .map<DropdownMenuItem<String>>((Owner value) {
                return DropdownMenuItem<String>(
                  value: value.dni?.toString(),
                  child: Text('${value.name} ${value.lastname}'),
                );
              }).toList(),
            ),
          ),
          Obx(
            () => DropdownButton<String>(
              value: controller.selectorCarValue.value?.patent,
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
              isExpanded: true,
              hint: Text('Seleccione su vehículo'),
              onChanged: controller.changeSelectorCarValue,
              items:
                  controller.carList.map<DropdownMenuItem<String>>((Car value) {
                return DropdownMenuItem<String>(
                  value: value.patent,
                  child: Text('${value.brand} ${value.model}'),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.serviceList.length,
                itemBuilder: (context, index) {
                  final service = controller.serviceList[index];
                  return Row(
                    children: [
                      GetBuilder<RegisterController>(
                        id: 'check',
                        builder: (_) {
                          return Checkbox(
                            value: service.isSelected,
                            onChanged: (value) {
                              controller.changeServiceStatusSelected(
                                  index, value ?? false);
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(service.type)
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (this.controller.validateSelectors()) {
                  this.showLoading();
                  final result = await this.controller.registerServices();
                  Get.back();
                  if (result) {
                    Get.back();
                    Get.snackbar('Registro exitoso!',
                        'El propietario ha sido registrado correctamente',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.all(16),
                        backgroundColor: Colors.green,
                        colorText: Colors.white);
                  } else {
                    Get.snackbar(
                      'Ocurrió un error',
                      'No se pudo registrar al propietario, vuelve a intentarlo mas tarde.',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(16),
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Atención',
                    'Revise tener completo todos los campos de forma correcta',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(16),
                    backgroundColor: Colors.lightBlue,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Registrar servicio'),
            ),
          ),
        ],
      ),
    );
  }

  void showLoading() {
    Get.dialog(
      AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Aguarde un momento...'),
            CircularProgressIndicator(),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class _FormRegisterOwner extends StatelessWidget {
  final RegisterController controller;
  const _FormRegisterOwner({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: this.controller.ownerDniController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(label: Text('DNI')),
          ),
          TextField(
            controller: this.controller.ownerNameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(label: Text('Nombre')),
          ),
          TextField(
            controller: this.controller.ownerLastnameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(label: Text('Apellido')),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (this.controller.validateOwnerControllers()) {
                  this.showLoading();
                  final result = await this.controller.registerOwner();
                  Get.back();
                  if (result) {
                    Get.back();
                    Get.snackbar('Registro exitoso!',
                        'El propietario ha sido registrado correctamente',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.all(16),
                        backgroundColor: Colors.green,
                        colorText: Colors.white);
                  } else {
                    Get.snackbar(
                      'Ocurrió un error',
                      'No se pudo registrar al propietario, vuelve a intentarlo mas tarde.',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(16),
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Atención',
                    'Revise tener completo todos los campos de forma correcta',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(16),
                    backgroundColor: Colors.lightBlue,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Registrar'),
            ),
          ),
        ],
      ),
    );
  }

  void showLoading() {
    Get.dialog(
      AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Aguarde un momento...'),
            CircularProgressIndicator(),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class _FormRegisterACar extends StatelessWidget {
  final RegisterController controller;

  const _FormRegisterACar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: this.controller.carBrandController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Marca')),
          ),
          TextField(
            controller: this.controller.carModelController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Modelo')),
          ),
          TextField(
            controller: this.controller.carYearController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Año')),
          ),
          TextField(
            controller: this.controller.carPatentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Patente')),
          ),
          TextField(
            controller: this.controller.carColorController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Color')),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(
            () => DropdownButton<String>(
              value: this.controller.selectorOwnerValue.value?.dni.toString(),
              isExpanded: true,
              hint: Text('Seleccione el propietario'),
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
              onChanged: this.controller.changeSelectorOwnerValue,
              items: this
                  .controller
                  .ownerList
                  .map<DropdownMenuItem<String>>((Owner value) {
                return DropdownMenuItem<String>(
                  value: value.dni.toString(),
                  child: Text('${value.name} ${value.lastname}'),
                );
              }).toList(),
            ),
          ),
          // Owner sera una lista desplegable de los owners en el sistema
          Container(
            margin: EdgeInsets.only(top: 16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (this.controller.validateCarControllers() &&
                    this.controller.selectorOwnerValue.value != null) {
                  this.showLoading();
                  final result = await this.controller.registerCar();
                  Get.back();
                  if (result) {
                    Get.back();
                    Get.snackbar('Registro exitoso!',
                        'Se registró el automóvil correctamente',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.all(16),
                        backgroundColor: Colors.green,
                        colorText: Colors.white);
                  } else {
                    Get.snackbar(
                      'Ocurrió un error',
                      'No se pudo registrar el automóvil, vuelve a intentarlo mas tarde.',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(16),
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                    );
                  }
                } else {
                  this.showInfoDialog();
                }
              },
              child: Text('Registrar'),
            ),
          )
        ],
      ),
    );
  }

  void showLoading() {
    Get.dialog(
      AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Aguarde un momento...'),
            CircularProgressIndicator(),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void showInfoDialog() {
    Get.snackbar(
      'Atención',
      'Revise tener completo todos los campos de forma correcta',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      backgroundColor: Colors.lightBlue,
      colorText: Colors.white,
    );
  }
}
