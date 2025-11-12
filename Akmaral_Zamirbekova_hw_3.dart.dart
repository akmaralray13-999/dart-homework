void main() {
  ///////////////// Fizz и Buzz /////////////
  int i = 1;
  while (i <= 30) {
    if (i % 3 == 0 && i % 5 == 0) {
      print('FizzBuzz');
    } else if (i % 3 == 0) {
      print('Fizz');
    } else if (i % 5 == 0) {
      print('Buzz');
    } else {
      print(i);
    }
    i = i + 1;
  }

  /////////////// положительные числа /////////////////

  List<int> numbers = [3, -2, 0, 7, -5, 10, 1];
  int positiveCount = 0;
  int positiveSum = 0;

  int i = 0;
  while (i < numbers.length) {
    if (numbers[i] > 0) {
      positiveCount = positiveCount + 1;
      positiveSum = positiveSum + numbers[i];
    }
    i = i + 1;
  }
  if (positiveCount > 0) {
    double average = positiveSum / positiveCount;
    print('Positive numbers count: $positiveCount');
    print('Average of positive numbers: $average');
  } else {
    print('No positive numbers');
  }

  ////////////// фруктики ///////////////

  Map<String, int> fruits = {'Apple': 5, 'Banana': 2, 'Mango': 7, 'Orange': 0};

  print('----forEach----');
  fruits.forEach((key, value) {
    if (value > 0) {
      print('Available: $key ($value pcs)');
    }
  });
}
