import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/views/bluetooth_classic_connected_data_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BtClassicDevicesScreen extends StatefulWidget {
  const BtClassicDevicesScreen({super.key});

  @override
  State<BtClassicDevicesScreen> createState() => _BtClassicDevicesScreenState();
}

class _BtClassicDevicesScreenState extends State<BtClassicDevicesScreen> {
  // BluetoothConnection? _blueConn;
   //FlutterBluetoothSerial? _bluetoothSerial;
   List<BluetoothDevice> _pairedOrBondedDevices = [];
   List<BluetoothDiscoveryResult> _discoveredDevices = [];

   @override
  void initState() {
    getPairedOrBondedDevices();
    searchDevices();
    // try{
    //   connectToDevice();
    // }catch(e){
    //   print(e);
    // }
    super.initState();
  }

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

  Future<void> pairDevice(
      {
        required String deviceAddress,
        required String? deviceName,
      }
      ) async{
    // final blueConn =
    await FlutterBluetoothSerial.instance.bondDeviceAtAddress(deviceAddress);
    //_blueConn  = blueConn;
     Fluttertoast.showToast(
        msg: "pairing to ${deviceAddress}",
        //  toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.0);

  }

  Future<void> searchDevices() async{
    print("starting discover");
    List<BluetoothDiscoveryResult> discoveredDevices =  await FlutterBluetoothSerial.instance.startDiscovery().toList();
    setState(() {
      _discoveredDevices = discoveredDevices;
    });
    print(_discoveredDevices[0].device.name);
    print("Ended discovery");



  }

   Future<void> getPairedOrBondedDevices() async{
     print("getting paired devices");
     List<BluetoothDevice> pairedOrBondedDevices =  await FlutterBluetoothSerial.instance.getBondedDevices();
     print("paired devices");
     setState(() {
       _pairedOrBondedDevices = pairedOrBondedDevices;

     });
     print("Device type is: ${_pairedOrBondedDevices[0].type}");

   }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
            title: const Text("Bluetooth Classic Test")
        ),
        body:Expanded(
          child:
            Column(
              children: [
                const Text("Paired devices"),
                Expanded(
                  flex: 2,
                  child:
                ListView.builder(
                  itemCount: _pairedOrBondedDevices.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      onTap: () async{
                        try{
                         // final devState = await FlutterBluetoothSerial.instance.state.toString();
                          final blueConn = await connectToDevice(deviceAddress: _pairedOrBondedDevices[index].address, deviceName: _pairedOrBondedDevices[index].name);

                         // _blueConn  = blueConn;
                          print("Connected to device");
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              BluetoothClassicConnectedScreen(
                                  connectedDevice: blueConn,
                                  deviceName: _pairedOrBondedDevices[index].name,
                              )
                          ));

                        }catch(e){

                          Fluttertoast.showToast(
                              msg: "failed to connect to ${_pairedOrBondedDevices[index].name}",
                              //  toastLength: Toast.LENGTH_LONG,
                              // gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 10.0);


                        }




                        //_pairedOrBondedDevices[index]
                      },
                      title: Text(_pairedOrBondedDevices[index].name ?? "Unknown Device"),
                      subtitle: Text(_pairedOrBondedDevices[index].address),
                    );

                  },
                ),
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text("Found devices"),
                Expanded(
                  flex: 1,
                    child:
                //const Text("Found devices"),
                ListView.builder(
                  itemCount: _discoveredDevices.length,
                  itemBuilder: (context, index){
                    if(_discoveredDevices.isEmpty){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      return ListTile(
                        onTap: () async{
                            try {
                              pairDevice(
                                deviceAddress:_discoveredDevices[index].device.address,
                                deviceName:_discoveredDevices[index].device.name,
                              );

                            }
                            catch(e){
                              Fluttertoast.showToast(
                                  msg: "failed  to pair ${_pairedOrBondedDevices[index].name} $e",
                                  //  toastLength: Toast.LENGTH_LONG,
                                  // gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 10.0);


                            }

                        },
                        title: Text(_discoveredDevices[index].device.name ?? "Unknown Device"),
                        subtitle: Text(_discoveredDevices[index].device.address),
                      );
                    }

                  },
                )
                )
              ],
            ),




        )
      // const Text("Paired or bonded devices"),





    ));
  }
}
