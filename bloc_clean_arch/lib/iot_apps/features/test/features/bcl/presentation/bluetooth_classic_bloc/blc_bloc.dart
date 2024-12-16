import 'dart:async';

import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/domain/blc_repo.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_events.dart';
import 'package:bloc_clean_arch/iot_apps/features/test/features/bcl/presentation/bluetooth_classic_bloc/blc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BluetoothClassicBloc extends Bloc<BluetoothClassicEventClass, BluetoothClassicState>{
  StreamSubscription<BluetoothDiscoveryResult>? _discoverySubscription;
  final List<BluetoothDiscoveryResult> _discoveredDevices = [];
  final BluetoothClassicRepo bluetoothClassicRepo;

  BluetoothClassicBloc(
  {required this.bluetoothClassicRepo}
      ):super(BluetoothClassicInitialState()){
  on<StartDiscoveryEvent>((event,emit) async{
    print("Emitted Start Discovery Event");
    emit(DiscoveryState(isDiscovering: true,
        discoveredDevices: []));
    try{
      final devices = await start();
      emit(DiscoveryState(isDiscovering: false, discoveredDevices: devices));
      print(devices[0].device.name);


    }catch (e){

    }
   // _startDiscovery(emit);
   // // final discoveredDevices = bluetoothClassicRepo.discoverOrSearchDevices();
   //  List<BluetoothDiscoveryResult> discoveredDevices = List<BluetoothDiscoveryResult>.empty(growable: true);
   //  print("Starting actual discovery");
   //  //print(isDiscovering);
   //  var startDiscovery = await FlutterBluetoothSerial.instance.startDiscovery().listen((r){
   //    // isDiscovering = true;
   //    discoveredDevices.add(r);
   //
   //
   //    print("Dummy result: ${discoveredDevices.length}");
   //
   //
   //
   //  });
   //  startDiscovery.onDone((){
   //    emit(DiscoveryState(isDiscovering: false,
   //        discoveredDevices: discoveredDevices));
   //    startDiscovery.cancel();
   //  });






  });
  on<GetPairedOrBondedDevicesEvent>((event, emit) async{
    emit(PairedOrBondedDevicesState(gettingPairedOrBondedDevices: true,
        pairedOrBondedDevices: []));
    try{
      final pairedOrBondedDevices = await bluetoothClassicRepo.getPairedOrBondedDevices();
      emit(PairedOrBondedDevicesState(gettingPairedOrBondedDevices: false,
          pairedOrBondedDevices: pairedOrBondedDevices));
    }catch(e){

    }


  });
  on<DeviceConnectionEvent>((event,emit) async {
    try{
      final connection = await bluetoothClassicRepo.connectToDevice(deviceAddress: event.deviceAddress,
          deviceName: event.deviceName);
      if(connection!=null){
        emit(NavigateToConnectedDataScreen(connectedDevice: connection,connectedDeviceName: event.deviceName));
      }
      Fluttertoast.showToast(
          msg: "On this event",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
    }catch(e){

    }




  });
  on<EmitTestStateEvent>((event,emit){
   emit(TestState());
  });
  on<DisconnectionEvent>((event,emit){
    emit(DeviceDisconnected());
  });

  }

  void _startDiscovery(Emitter<BluetoothClassicState> emit){
    _discoveredDevices.clear();
    _discoverySubscription?.cancel();

    _discoverySubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r){
      if(!_discoveredDevices.contains(r)){
        _discoveredDevices.add(r);

        if(!emit.isDone){
          emit(DiscoveryState(isDiscovering: false,
              discoveredDevices: List.from(_discoveredDevices)));
        }
      }
      _discoverySubscription?.onDone((){
        if(!emit.isDone){
          emit(DiscoveryState(isDiscovering: false,
              discoveredDevices: _discoveredDevices));
        }

      });
    });

  }

  Future<List<BluetoothDiscoveryResult>> start() async{
    final discoveredDevices = <BluetoothDiscoveryResult>[];

    await for(var result in FlutterBluetoothSerial.instance.startDiscovery()){
      if(!discoveredDevices.contains(result)){
        discoveredDevices.add(result);
        emit(DiscoveryState(isDiscovering: false, discoveredDevices: discoveredDevices));
      }
    }
    return discoveredDevices;
  }
}