import 'dart:io';

void main() {
  /////////////Прогулка/////////////
  print('Enter your age:');
  int age = int.parse(stdin.readLineSync()!);

  print('Enter temperature:');
  int temperature = int.parse(stdin.readLineSync()!);

  if (age >= 20 && age <= 45 && temperature >= -20 && temperature <= 30) {
    print('You can go for a walk.');
  } else if (age < 20 && temperature >= 0 && temperature <= 28) {
    print('You can go for a walk.');
  } else if (age > 45 && temperature >= -10 && temperature <= 25) {
    print('You can go for a walk.');
  } else {
    print('Stay home.');
  }

  //////////// День недели/////////////

  print('Enter a day of the week');
  String day = stdin.readLineSync()!;
  day = day.toLowerCase();

  switch (day) {
    case 'monday':
      print("It's the start of the week!");
      break;
    case 'tuesday':
    case 'wednesday':
    case 'thursday':
      print("Keep going, almost weekend!");
      break;
    case 'saturday':
    case 'sunday':
      print("Enjoy your weekend!");
      break;
    default:
      print("Invalid day.");
  }

  ///////// Пароль///////////
  print('Enter the passsword');
  String password = stdin.readLineSync()!;

  if (password.isEmpty) {
    print('Password can not be empty.');
  } else if (password.length < 6) {
    print('Password is too short.');
  } else {
    if (password == 'dart123') {
      print('Access granted.');
    } else {
      print('Wrong password.');
    }
  }
}
