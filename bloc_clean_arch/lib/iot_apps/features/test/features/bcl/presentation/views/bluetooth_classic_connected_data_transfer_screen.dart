import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_bloc.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_events.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_states.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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

  int count = 0;
  double incomingData = 0.0;
  String ledStatus = "";
  bool deviceConnectionStatus = false;
  double sensorData = 0.0;
  Color bgColor = Colors.blue;
  //flutter pub get percent_indicator


  StreamSubscription<Uint8List>? getIncomingData(){
    return widget.connectedDevice?.input?.listen((Uint8List data){
      setState(() {
        incomingData =  double.parse(ascii.decode(data).trim()) ;
        print("This is ur data: ${incomingData}");
        if(incomingData == "led_off"){
          ledStatus = "LED_OFF";
        }
        if(incomingData == "led_on"){
          ledStatus = "LED_ON";
        }

      });
      setState(() {
        if(incomingData >= 0.0 && incomingData <= 0.3){
          bgColor = Colors.red;
        } else if(incomingData >= 0.3 && incomingData <= 0.6){
          bgColor = Colors.orange;

        }else if(incomingData >= 0.6 && incomingData <= 0.9){
          bgColor = Colors.blue;

        }else if(incomingData == 1.0){
          bgColor = Colors.white;

        }

      });

      print("Incoming data ${ascii.decode(data)}");
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
    //mockSignalGenerator();
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

  void mockSignalGenerator(){
    const maxUpdates = 1000;
    final random = Random();
    Timer.periodic(const Duration(seconds:1),(timer){
      setState(() {
         sensorData = random.nextDouble();
         count++;
         print("Sensor data: ${sensorData}");

      });
      setState(() {
        if(sensorData >= 0.0 && sensorData <= 0.3){
          bgColor = Colors.red;
        } else if(sensorData >= 0.3 && sensorData <= 0.6){
          bgColor = Colors.orange;

        }else if(sensorData >= 0.6 && sensorData <= 0.9){
          bgColor = Colors.blue;

        }else if(sensorData == 1.0){
          bgColor = Colors.white;

        }

      });

      if(count>= maxUpdates){
        timer.cancel();
        print("Sensor simulation ended");
      }
    });

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
                        //color: Colors.wh,
                        height: 500,
                        width: 500,
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            // Text(
                            //     maxLines: 20,
                            //     "data here:\n $incomingData"
                            // ),
                            CircularPercentIndicator(
                              animation: true,
                              radius: 50,
                              lineWidth: 10,
                              percent: incomingData,  //sensorData
                              progressColor: bgColor,
                              backgroundColor: Colors.deepPurple.shade100,
                              circularStrokeCap: CircularStrokeCap.round,
                              center:  Text("${incomingData}%", style: const TextStyle(fontSize: 8)),
                              //(sensorData*100).round()}
                            )
                          ],
                        )
                          ,)
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
