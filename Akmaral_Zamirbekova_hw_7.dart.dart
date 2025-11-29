// main.dart

////////// Интерфейс Switchable ////////////////
abstract class Switchable {
  void turnOn();
  void turnOff();
}

/////////// Интерфейс Adjustable//////////////////
abstract class Adjustable {
  void increase();
  void decrease();
}

//////////////// Миксин BatteryPowered //////////////////
mixin BatteryPowered {
  int batteryLevel = 100;

  void showBattery() {
    print('Battery level: $batteryLevel%');
  }
}

///////////////// Абстрактный класс Device ///////////////////
abstract class Device implements Switchable {
  final String name;

  Device(this.name);

  void showInfo() {
    print('Device: $name');
  }
}

////////////////// Класс SmartLamp ///////////////////////////
class SmartLamp extends Device implements Adjustable with BatteryPowered {
  int brightness = 50;

  SmartLamp(String name) : super(name);

  @override
  void turnOn() {
    print('Lamp $name is ON');
  }

  @override
  void turnOff() {
    print('Lamp $name is OFF');
  }

  @override
  void increase() {
    if (brightness < 100) {
      brightness += 10;
      if (brightness > 100) brightness = 100;
    }
    print('Brightness: $brightness');
  }

  @override
  void decrease() {
    if (brightness > 0) {
      brightness -= 10;
      if (brightness < 0) brightness = 0;
    }
    print('Brightness: $brightness');
  }

  @override
  void showInfo() {
    print('Lamp $name, Brightness: $brightness');
  }
}

///////////////////// Класс SmartSpeaker ///////////////////////
class SmartSpeaker extends Device implements Adjustable with BatteryPowered {
  int volume = 30;

  SmartSpeaker(String name) : super(name);

  @override
  void turnOn() {
    print('Speaker $name is ON');
  }

  @override
  void turnOff() {
    print('Speaker $name is OFF');
  }

  @override
  void increase() {
    if (volume < 100) {
      volume += 5;
      if (volume > 100) volume = 100;
    }
    print('Volume: $volume');
  }

  @override
  void decrease() {
    if (volume > 0) {
      volume -= 5;
      if (volume < 0) volume = 0;
    }
    print('Volume: $volume');
  }

  @override
  void showInfo() {
    print('Speaker $name, Volume: $volume');
  }
}

///////////////// Класс SmartThermostat /////////////////////
class SmartThermostat extends Device {
  int temperature = 22;

  SmartThermostat(String name) : super(name);

  @override
  void turnOn() {
    print('Thermostat $name is ON');
  }

  @override
  void turnOff() {
    print('Thermostat $name is OFF');
  }

  @override
  void showInfo() {
    print('Thermostat $name, Temperature: $temperature°');
  }
}

///////////////// Полиморфизм в main() ///////////////////////
void main() {
  List<Device> devices = [
    SmartLamp('Living Room Lamp'),
    SmartSpeaker('Kitchen Speaker'),
    SmartThermostat('Hall Thermostat'),
  ];

  for (var device in devices) {
    device.showInfo();
    device.turnOn();

    if (device is Adjustable) {
      device.increase();
    }

    if (device is BatteryPowered) {
      device.showBattery();
    }

    print('---');
  }

  print('All devices processed.');
}