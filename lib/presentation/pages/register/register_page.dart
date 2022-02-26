import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickit_challenge/constants/custom_constants.dart';
import 'package:pickit_challenge/presentation/pages/register/register_controller.dart';

class RegisterPage extends GetWidget<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(controller.getAppBarTitle.value))),
      body: Obx(
        () {
          if (controller.getRegisterType.value == CustomConstants.TYPE_CAR) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(label: Text('Marca')),
                  ),
                  TextField(
                    decoration: InputDecoration(label: Text('Modelo')),
                  ),
                  TextField(
                    decoration: InputDecoration(label: Text('Año')),
                  ),
                  TextField(
                    decoration: InputDecoration(label: Text('Patente')),
                  ),
                  TextField(
                    decoration: InputDecoration(label: Text('Color')),
                  ),

                  // Owner sera una lista desplegable de los owners en el sistema
                ],
              ),
            );
          } else if (controller.getRegisterType.value ==
              CustomConstants.TYPE_OWNER) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
