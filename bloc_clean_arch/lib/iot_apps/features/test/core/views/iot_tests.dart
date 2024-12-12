import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/views/bluetooth_classic_devices_screen.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IotTestsHomeScreen extends StatefulWidget {
  const IotTestsHomeScreen({super.key});

  @override
  State<IotTestsHomeScreen> createState() => _IotTestsHomeScreenState();
}

class _IotTestsHomeScreenState extends State<IotTestsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'T E S T  A P P S',
        style: TextStyle(fontWeight: FontWeight.bold
        ),      )),
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
                          const BtClassicDevicesScreen(
                          )
                      ));
                    },
                    id: 'BCL',
                  ),
                  MyButton(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "Still cooking...",
                          //  toastLength: Toast.LENGTH_LONG,
                          // gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 10.0);
                    },
                    id: 'BLE',
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Still cooking...",
                            //  toastLength: Toast.LENGTH_LONG,
                            // gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 10.0);

                      },
                      id: 'WIFI'),
                  MyButton(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "Still cooking...",
                          //  toastLength: Toast.LENGTH_LONG,
                          // gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 10.0);
                    },
                    id: 'SENSORS',
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
