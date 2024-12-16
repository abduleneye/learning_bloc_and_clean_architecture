import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class BluetoothClassicRepo{
  Future<BluetoothConnection?> connectToDevice(
      {
        required String deviceAddress,
        required String? deviceName,
      }
      );
  Future<bool?> pairDevice(
      {
        required String deviceAddress,
        required String? deviceName,
      }
      );
  List<BluetoothDiscoveryResult?> discoverOrSearchDevices();
  Future<List<BluetoothDevice>> getPairedOrBondedDevices();

}
