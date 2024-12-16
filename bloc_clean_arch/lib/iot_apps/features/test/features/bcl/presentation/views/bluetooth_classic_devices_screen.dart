import 'dart:async';


import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_bloc.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_events.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_states.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/views/bluetooth_classic_connected_data_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BtClassicDevicesScreen extends StatefulWidget {
  const BtClassicDevicesScreen({super.key});

  @override
  State<BtClassicDevicesScreen> createState() => _BtClassicDevicesScreenState();
}

class _BtClassicDevicesScreenState extends State<BtClassicDevicesScreen> {
   StreamSubscription<BluetoothDiscoveryResult>?  _resFromSub;
    //late Stream<BluetoothDiscoveryResult> discoveryStream;
    bool isDiscovering = false;
   late Future<List<BluetoothDiscoveryResult>> discoveryFuture;
   List<BluetoothDevice> _pairedOrBondedDevices = [];
   List<BluetoothDiscoveryResult> _discoveredDevices = [];

   @override
  void initState() {
     context
         .read<BluetoothClassicBloc>()
         .add(GetPairedOrBondedDevicesEvent());
     context
         .read<BluetoothClassicBloc>()
         .add(StartDiscoveryEvent());
     // context
     //     .read<BluetoothClassicBloc>()
     //     .add(GetPairedOrBondedDevicesEvent());
     // context
     //     .read<BluetoothClassicBloc>()
     //     .add(EmitTestStateEvent());

     //discoverOrSearchDevices();
     //getPairedOrBondedDevices();
    super.initState();
  }

  // void discoverDev(){
  //    discoveryStream = FlutterBluetoothSerial.instance.startDiscovery().listen((r){
  //
  //    });
  //  }

  Future<BluetoothConnection> connectToDevice(
      {
        required String deviceAddress,
        required String? deviceName,
      }
   )async {
    await FlutterBluetoothSerial.instance.state;
    final connectedDevice = await BluetoothConnection.toAddress(deviceAddress);
     print("Connected to ${deviceName}");
     return connectedDevice;
  }

  Future<bool?> pairDevice(
      {
        required String deviceAddress,
        required String? deviceName,
      }
      ) async{
    Fluttertoast.showToast(
        msg: "pairing to ${deviceName}",
        //  toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.0);
    var pairStatus = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(deviceAddress);
    return pairStatus;


  }

   void discoverOrSearchDevices() {
     List<BluetoothDiscoveryResult> dummyRes= [];
     print("Starting actual discovery");
     print(isDiscovering);
     var startDiscovery = FlutterBluetoothSerial.instance.startDiscovery().listen((r){
       setState(() {
         isDiscovering = true;
         _discoveredDevices.add(r);

       });
       print("Dummy result: ${_discoveredDevices.length}");

     });
     startDiscovery.onDone((){
       setState(() {

         isDiscovering = false;

       });
       startDiscovery.cancel();
       print("Done dummy discovery${isDiscovering}");
     });
   }

   void restartDiscovery(){

     if(isDiscovering == true){
       Fluttertoast.showToast(
           msg: "still discovering",
           //  toastLength: Toast.LENGTH_LONG,
           // gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 10.0);
     }

     if(isDiscovering == false){
       setState(() {
         _discoveredDevices.clear();
       });
       discoverOrSearchDevices();
     }
   }

   Future<void> getPairedOrBondedDevices() async{
     setState(() {
       _pairedOrBondedDevices.clear();
     });
     print("getting paired devices");
     List<BluetoothDevice> pairedOrBondedDevices =  await FlutterBluetoothSerial.instance.getBondedDevices();
     print("paired devices");
    // setState(() {
       _pairedOrBondedDevices = pairedOrBondedDevices.reversed.toList();

     //});
     //return pairedOrBondedDevices;
     print("Device type is: ${_pairedOrBondedDevices[0].type}");

   }

   @override
  void dispose() {
     FlutterBluetoothSerial.instance.cancelDiscovery();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothClassicBloc, BluetoothClassicState>(builder: (context, state){
      if(state is NavigateToConnectedDataScreen){
        Fluttertoast.showToast(
            msg: "On nav estate",
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0);
        return  BluetoothClassicConnectedScreen(connectedDevice: state.connectedDevice,
            deviceName: state.connectedDeviceName);

        // if(state.connectedDevice != null){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //        BluetoothClassicConnectedScreen(
        //          connectedDevice: state.connectedDevice,
        //          deviceName: "Meh",
        //        )
        //    ));
        // }
      }
      if(state is DeviceDisconnected){
        return SafeArea(child: Scaffold(
          appBar: AppBar(
            title: const Text("Bluetooth Classic Test"),
            actions: [
              IconButton(onPressed: (){
                // context
                //     .read<BluetoothClassicBloc>()
                //     .add(EmitTestStateEvent());
                context
                    .read<BluetoothClassicBloc>()
                    .add(StartDiscoveryEvent());
                context
                    .read<BluetoothClassicBloc>()
                    .add(GetPairedOrBondedDevicesEvent());

              }, icon: const Icon(Icons.refresh)
              )
            ],
          ),
          body: Column(
            children: [
              const Text("Paired devices"),

              Expanded(
                  child: BlocBuilder<BluetoothClassicBloc, BluetoothClassicState>(
                    buildWhen: (previous, current) => current is PairedOrBondedDevicesState || current is NavigateToConnectedDataScreen,
                    builder: (context, state){
                      if(state is PairedOrBondedDevicesState){
                        if(state.gettingPairedOrBondedDevices){
                          return Center(child: CircularProgressIndicator());

                        }else if (state.gettingPairedOrBondedDevices == false && state.pairedOrBondedDevices.isNotEmpty){
                          return ListView.builder(
                            itemCount: state.pairedOrBondedDevices.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                onTap: () {
                                  // try{
                                  context
                                      .read<BluetoothClassicBloc>()
                                      .add(DeviceConnectionEvent(
                                      deviceName: state.pairedOrBondedDevices[index].name,
                                      deviceAddress: state.pairedOrBondedDevices[index].address));
                                },
                                title: Text(state.pairedOrBondedDevices[index].name ?? "Unknown Device"),
                                subtitle: Text(state.pairedOrBondedDevices[index].address),
                              );

                            },
                          );

                        }
                      }
                      return const Center(child: Text("No Paired device(s) found"),);
                    },
                  )

              ),

              const SizedBox(
                height: 10,
              ),
              const Text("Found devices"),
              Expanded(
                  child: BlocBuilder<BluetoothClassicBloc, BluetoothClassicState>(
                      buildWhen: (previous, current) => current is DiscoveryState,
                      builder: (context, state){
                        if(state is DiscoveryState){
                          if(state.isDiscovering == false){
                            return ListView.builder(
                              // itemCount: _discoveredDevices.length,
                              itemCount: state.discoveredDevices.length,
                              itemBuilder: (context, index){
                                final device = state.discoveredDevices[index];
                                return ListTile(
                                  onTap: () async{
                                    try {

                                      // var status =  await pairDevice(
                                      //   deviceAddress:device.device.address,
                                      //   deviceName:device.device.name,
                                      // );
                                      //
                                      // if(status!){
                                      //   setState(() {
                                      //     getPairedOrBondedDevices();
                                      //   });
                                      //   Fluttertoast.showToast(
                                      //       msg: "pairing  Successful",
                                      //       //  toastLength: Toast.LENGTH_LONG,
                                      //       // gravity: ToastGravity.CENTER,
                                      //       timeInSecForIosWeb: 1,
                                      //       backgroundColor: Colors.red,
                                      //       textColor: Colors.white,
                                      //       fontSize: 10.0);
                                      //
                                      // }
                                    }
                                    catch(e){
                                      Fluttertoast.showToast(
                                          msg: "failed  to pair ${device.device.name} $e",
                                          //  toastLength: Toast.LENGTH_LONG,
                                          // gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 10.0);

                                    }

                                  },
                                  title: Text(device?.device.name ?? "Unknown Device"),
                                  subtitle: Text(device!.device.address),
                                );


                              },
                            );
                          }
                          else if(state.isDiscovering == true){
                            return const Center(child: CircularProgressIndicator());

                          }
                        }
                        return const Center(child: Text("No device found"));

                      }

                  )
              )




            ],
          ),





          // const Text("Paired or bonded devices"),





        ));
      }

      return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: const Text("Bluetooth Classic Test"),
          actions: [
            IconButton(onPressed: (){
              // context
              //     .read<BluetoothClassicBloc>()
              //     .add(EmitTestStateEvent());
              context
                  .read<BluetoothClassicBloc>()
                  .add(StartDiscoveryEvent());
              context
                  .read<BluetoothClassicBloc>()
                  .add(GetPairedOrBondedDevicesEvent());

            }, icon: const Icon(Icons.refresh)
            )
          ],
        ),
        body: Column(
          children: [
            const Text("Paired devices"),

            Expanded(
                child: BlocBuilder<BluetoothClassicBloc, BluetoothClassicState>(
                  buildWhen: (previous, current) => current is PairedOrBondedDevicesState || current is NavigateToConnectedDataScreen,
                  builder: (context, state){
                    if(state is PairedOrBondedDevicesState){
                      if(state.gettingPairedOrBondedDevices){
                        return Center(child: CircularProgressIndicator());

                      }else if (state.gettingPairedOrBondedDevices == false && state.pairedOrBondedDevices.isNotEmpty){
                        return ListView.builder(
                          itemCount: state.pairedOrBondedDevices.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              onTap: () {
                                // try{
                                context
                                    .read<BluetoothClassicBloc>()
                                    .add(DeviceConnectionEvent(
                                    deviceName: state.pairedOrBondedDevices[index].name,
                                    deviceAddress: state.pairedOrBondedDevices[index].address));
                              },
                              title: Text(state.pairedOrBondedDevices[index].name ?? "Unknown Device"),
                              subtitle: Text(state.pairedOrBondedDevices[index].address),
                            );

                          },
                        );

                      }
                    }
                    return const Center(child: Text("No Paired device(s) found"),);
                  },
                )

            ),

            const SizedBox(
              height: 10,
            ),
            const Text("Found devices"),
            Expanded(
                child: BlocBuilder<BluetoothClassicBloc, BluetoothClassicState>(
                    buildWhen: (previous, current) => current is DiscoveryState,
                    builder: (context, state){
                      if(state is DiscoveryState){
                        if(state.isDiscovering == false){
                          return ListView.builder(
                            // itemCount: _discoveredDevices.length,
                            itemCount: state.discoveredDevices.length,
                            itemBuilder: (context, index){
                              final device = state.discoveredDevices[index];
                              return ListTile(
                                onTap: () async{
                                  try {

                                    // var status =  await pairDevice(
                                    //   deviceAddress:device.device.address,
                                    //   deviceName:device.device.name,
                                    // );
                                    //
                                    // if(status!){
                                    //   setState(() {
                                    //     getPairedOrBondedDevices();
                                    //   });
                                    //   Fluttertoast.showToast(
                                    //       msg: "pairing  Successful",
                                    //       //  toastLength: Toast.LENGTH_LONG,
                                    //       // gravity: ToastGravity.CENTER,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red,
                                    //       textColor: Colors.white,
                                    //       fontSize: 10.0);
                                    //
                                    // }
                                  }
                                  catch(e){
                                    Fluttertoast.showToast(
                                        msg: "failed  to pair ${device.device.name} $e",
                                        //  toastLength: Toast.LENGTH_LONG,
                                        // gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 10.0);

                                  }

                                },
                                title: Text(device?.device.name ?? "Unknown Device"),
                                subtitle: Text(device!.device.address),
                              );


                            },
                          );
                        }
                        else if(state.isDiscovering == true){
                          return const Center(child: CircularProgressIndicator());

                        }
                      }
                      return const Center(child: Text("No device found"));

                    }

                )
            )




          ],
        ),





        // const Text("Paired or bonded devices"),





      ));
    });
  }
}









