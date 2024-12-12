import 'package:bloc_clean_arch/iot_apps/features/test/core/views/iot_tests.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IotAppsHomeScreen extends StatefulWidget {
  const IotAppsHomeScreen({super.key});

  @override
  State<IotAppsHomeScreen> createState() => _IotAppsHomeScreenState();
}

class _IotAppsHomeScreenState extends State<IotAppsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'I O T  A P P S',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const IotTestsHomeScreen(

                            )
                        ));

                      },
                      id: 'TEST'),
                  MyButton(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "Still cooking",
                          //  toastLength: Toast.LENGTH_LONG,
                          // gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 10.0);

                    },
                    id: 'PROJECTS',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
