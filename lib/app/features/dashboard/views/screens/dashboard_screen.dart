library dashboard;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:kidsadmin/app/config/routes/app_pages.dart';
import 'package:kidsadmin/app/shared_components/async_button.dart';
import 'package:kidsadmin/app/utils/services/service.dart';
import 'package:kidsadmin/app/features/dashboard/views/components/crud/model/crud_category_model.dart';

import '../../../../shared_components/header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/crud/components/home_page.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// component
part '../components/sign_out_button.dart';

class DashboardScreen extends GetView<DashboardController> {
  int selectedService = -1;
  String? selectedCategoryName;
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: selectedService >= 0
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => HomePage(
                        dbName: selectedCategoryName,
                      ));
                  //selectedCategoryName
                  //if you wish to use this style then make the selec index as obserble or rx int
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                backgroundColor: Colors.green,
              )
            : null,
        body: GridView.count(
            crossAxisCount: 2,
            children: CategoryList()
                .categoryList!
                .map((item) => serviceContainer(
                    name: item.name!, image: item.imageURL!, index: item.indx!))
                .toList()));
  }

  Widget _buildSignOutButton() {
    // const HeaderText("CRUD"),
    // const SizedBox(height: 10),
    // _buildSignOutButton(),
    return Obx(
      () => _SignOutButton(
        isLoading: controller.isLoading.value,
        onPressed: () => controller.signOut(),
      ),
    );
  }

  Widget serviceContainer(
      {required String image, required String name, required int index}) {
    return GestureDetector(
      onTap: () {
        if (selectedService == index)
          selectedService = -1;
        else
          selectedService = index;
        selectedCategoryName = name;
      },
      child: InkWell(
        onTap: () {
          Get.to(() => HomePage(
                dbName: name.toString(),
              ));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: selectedService == index
                ? Colors.blue.shade50
                : Colors.grey.shade100,
            border: Border.all(
              color: selectedService == index
                  ? Colors.green
                  : Colors.green.withOpacity(0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                    imageUrl: image,
                    height: 80,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset(
                        'assets/img/age-group.png', //TODO PATH TO LOGO IMAGE
                        height: 80)), //todo
                SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 20),
                )
              ]),
        ),
      ),
    );
  }
}
