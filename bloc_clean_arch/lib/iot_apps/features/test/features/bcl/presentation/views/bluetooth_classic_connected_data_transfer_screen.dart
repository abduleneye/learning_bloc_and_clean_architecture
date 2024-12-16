import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_bloc.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_events.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_states.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BluetoothClassicConnectedScreen extends StatefulWidget {
  final BluetoothConnection? connectedDevice;
  final String? deviceName;
  const BluetoothClassicConnectedScreen({
    super.key,
    required this.connectedDevice,
    required this.deviceName
  });

  @override
  State<BluetoothClassicConnectedScreen> createState() => _BluetoothClassicConnectedScreenState();
}

class _BluetoothClassicConnectedScreenState extends State<BluetoothClassicConnectedScreen> {

  String incomingData = "";
  String ledStatus = "";
  bool deviceConnectionStatus = false;
  //flutter pub get percent_indicator


  StreamSubscription<Uint8List>? getIncomingData(){
    return widget.connectedDevice?.input?.listen((Uint8List data){
      setState(() {
        incomingData = ascii.decode(data);
        if(incomingData == "led_off"){
          ledStatus = "LED_OFF";
        }
        if(incomingData == "led_on"){
          ledStatus = "LED_ON";
        }

      });
     // print("Incoming data ${ascii.decode(data)}");
    });

  }

  StreamSubscription<bool?> getConnectionStatus() {
    //return Stream.value('Lawal');
    return Stream.periodic(const Duration(seconds: 1), (value) {
      return widget.connectedDevice?.isConnected;
    }).listen((onData){
      setState(() {
        if(onData == true){
          deviceConnectionStatus = true;
        }else if(onData == false){
         // getConnectionStatus().cancel();
          deviceConnectionStatus = false;
        }
      });

      if(onData == false){
        Fluttertoast.showToast(
            msg: "${widget.deviceName} disconnected",
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0);
        widget.connectedDevice?.dispose();
        getIncomingData()?.cancel();
        sendCommandTextFieldController.dispose();
        getConnectionStatus().cancel();
        context.read<BluetoothClassicBloc>().add(DisconnectionEvent());
      }

    });
  }


  final sendCommandTextFieldController = TextEditingController();

  @override
  void initState() {
    getIncomingData();
    getConnectionStatus();
    super.initState();
  }


  @override
  void dispose() {
    widget.connectedDevice?.dispose();
    getIncomingData()?.cancel();
    sendCommandTextFieldController.dispose();
    getConnectionStatus().cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothClassicBloc, BluetoothClassicState>(builder: (context, state){
      if(state is NavigateToConnectedDataScreen){
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(title: const Text("Data Transfer Screen"),),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        deviceConnectionStatus.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),

                      Text(
                        ledStatus,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "connected to ${widget.deviceName}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),

                      MyTextFieldSocialApp(
                          controller: sendCommandTextFieldController,
                          hintText: "Enter command",
                          obscureText: false),
                      TextButton(onPressed: (){

                        widget.connectedDevice?.output.add(ascii.encode(sendCommandTextFieldController.text));

                      }, child: const Text(
                          "Send"
                      )),
                      TextButton(onPressed: (){
                        getIncomingData();
                      }, child: const Text(
                          "Get data"
                      )),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(child:
                      Container(
                        color: Colors.grey,
                        height: 500,
                        width: 500,
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                            maxLines: 20,
                            "data here:\n $incomingData"
                        ),)
                      )
                      )

                      // Expanded(
                      //     child: Card(
                      //       color: Colors.blueAccent,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12)
                      //       ),
                      //       elevation: 4,
                      //       child:
                      //     )
                      // )
                    ],
                  )

                  ,
                ),
              )
          ),

        );
      }
      return const Center(child: Text("Unavailable"),);

    });
  }
}
