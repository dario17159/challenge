import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickit_challenge/constants/custom_constants.dart';
import 'package:pickit_challenge/presentation/pages/home/home_controller.dart';
import 'package:pickit_challenge/presentation/pages/register/register_binding.dart';
import 'package:pickit_challenge/presentation/pages/register/register_page.dart';

class HomePage extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listado de automóviles')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Registrar: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => RegisterPage(),
                        binding: RegisterBinding(),
                        arguments: CustomConstants.TYPE_CAR,
                      );
                    },
                    child: Text(
                      'Auto',
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => RegisterPage(),
                        binding: RegisterBinding(),
                        arguments: CustomConstants.TYPE_OWNER,
                      );
                    },
                    child: Text('Propietario'),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => RegisterPage(),
                        binding: RegisterBinding(),
                        arguments: CustomConstants.TYPE_SERVICE,
                      );
                    },
                    child: Text('Servicio'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
