import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class BluetoothClassicState{
}

class BluetoothClassicInitialState extends BluetoothClassicState {}

class DiscoveryState extends BluetoothClassicState{
  final bool isDiscovering;
  final List<BluetoothDiscoveryResult?> discoveredDevices;
  DiscoveryState(
  {
    required this.isDiscovering,
    required this.discoveredDevices
  }
      );

}

class PairedOrBondedDevicesState extends BluetoothClassicState {
  bool gettingPairedOrBondedDevices;
  List<BluetoothDevice> pairedOrBondedDevices;
  PairedOrBondedDevicesState({required this.gettingPairedOrBondedDevices,
    required this.pairedOrBondedDevices});
}

class ConnectedState extends BluetoothClassicState{
  final BluetoothConnection? connectedDevice;
  ConnectedState(
  {
    required this.connectedDevice,
  }
      );
}

class TestState extends BluetoothClassicState{

  TestState();

}

class NavigateToConnectedDataScreen extends BluetoothClassicState{
  final BluetoothConnection? connectedDevice;
  final String? connectedDeviceName;


  NavigateToConnectedDataScreen(
  {
    required this.connectedDevice,
    required this.connectedDeviceName

  }
      );
}

class DeviceDisconnected extends BluetoothClassicState{}


