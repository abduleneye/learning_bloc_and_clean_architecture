import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/blc_repo.dart';

class BluetoothClassicRepoImplementation implements BluetoothClassicRepo{
  @override
  Future<BluetoothConnection?> connectToDevice({required String deviceAddress, required String? deviceName}) async{
  try{
    await FlutterBluetoothSerial.instance.state;
    final connectedDevice = await BluetoothConnection.toAddress(deviceAddress);
    print("Connected to ${deviceName}");
    Fluttertoast.showToast(
        msg: "connected to ${deviceName}",
        //  toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.0);
    return connectedDevice;
  }catch(e){
    Fluttertoast.showToast(
        msg: "failed to connect to ${deviceName}",
        //  toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.0);
    return null;


  }



  }

  @override
  List<BluetoothDiscoveryResult> discoverOrSearchDevices() {
    List<BluetoothDiscoveryResult> discoveredDevices = [];
    print("Starting actual discovery");
    //print(isDiscovering);
    var startDiscovery = FlutterBluetoothSerial.instance.startDiscovery().listen((r){
       // isDiscovering = true;
        discoveredDevices.add(r);

      print("Dummy result: ${discoveredDevices.length}");

    });
    startDiscovery.onDone((){
      startDiscovery.cancel();
      //print("Done dummy discovery${isDiscovering}");
    });
    return discoveredDevices;
  }

  @override
  Future<List<BluetoothDevice>> getPairedOrBondedDevices() async{
    List<BluetoothDevice> pairedOrBondedDevices = [];
      pairedOrBondedDevices.clear();
    print("getting paired devices");
     pairedOrBondedDevices =  await FlutterBluetoothSerial.instance.getBondedDevices();
    print("paired devices");
    pairedOrBondedDevices = pairedOrBondedDevices.reversed.toList();
    print("Device type is: ${pairedOrBondedDevices[0].type}");
    return pairedOrBondedDevices;
  }

  @override
  Future<bool?> pairDevice({required String deviceAddress, required String? deviceName}) async{
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
  
}