abstract class BluetoothClassicEventClass{

}

class DeviceConnectionEvent extends BluetoothClassicEventClass{
  String? deviceName;
  String deviceAddress;
  DeviceConnectionEvent({
   required this.deviceName,
    required this.deviceAddress,

});

}


class StartDiscoveryEvent extends BluetoothClassicEventClass{

}

class GetPairedOrBondedDevicesEvent extends BluetoothClassicEventClass{

}

class PairDeviceEvent extends BluetoothClassicEventClass {

}

class EmitTestStateEvent extends BluetoothClassicEventClass {

}
class DisconnectionEvent extends BluetoothClassicEventClass {

}
