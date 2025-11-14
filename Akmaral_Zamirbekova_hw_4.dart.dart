int totalCalls = 0;
void greet() {
  totalCalls++;
  print('Hello! Welcome to Dart programming!');
}

void introduce(String name, int age) {
  totalCalls++;
  print('My name is $name and I am $age years old.');
}

int addNumbers(int a, int b) {
  totalCalls++;
  return a + b;
}

double calculateDiscount({
  required double price,
  double discount = 0,
  double tax = 0,
}) {
  totalCalls++;
  double finalPrice = price - (price * discount / 100) + (price * tax / 100);
  return finalPrice;
}

void main() {
  //// greet 3 раза
  greet();
  greet();
  greet();

  //// introduce 3 раза
  introduce('Alex', 25);
  introduce('Maria', 22);
  introduce('John', 30);

  /////// add numbers тож 3 раза
  int sum = addNumbers(5, 8);
  print('Sum of 5 and 8 is $sum.');

  ///// подсчет скидки
  /// только цена
  double final1 = calculateDiscount(price: 100.0);
  print('Final price: \$${final1.toStringAsFixed(2)}');

  //// цена и скидочка

  double final2 = calculateDiscount(price: 120.0, discount: 10.0);
  print('Final price: \$${final2.toStringAsFixed(2)}');

  /// цена, скидочка и налог

  double final3 = calculateDiscount(price: 200.0, discount: 15.0, tax: 5.0);
  print('Final price: \$${final3.toStringAsFixed(2)}');

  //// итог

  print('\nTotal function calls: $totalCalls');
}
