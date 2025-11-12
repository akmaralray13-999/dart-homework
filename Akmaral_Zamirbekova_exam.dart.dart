import 'dart:io';

void main() {
  int warm = 0;
  int cool = 0;
  int cold = 0;
  int day = 1;

  while (day <= 7) {
    stdout.write('Enter temperature for day $day:       ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('Please enter a valid number!');
      continue;
    }
    int temp = int.parse(input);

    if (temp > 20) {
      print("It's warm today!");
      warm = warm + 1;
    } else if (temp >= 10 && temp <= 20) {
      print("It's cool today!");
      cool = cool + 1;
    } else {
      print("It's cold today!");
      cold = cold + 1;
    }

    day = day + 1;
  }
  print('\n--- Weekly temperature analysis---');
  print('Warm days: $warm');
  print('Cool days: $cool');
  print('Cold days: $cold');
  print('Weekly temperature analysis completed!!!');
}
