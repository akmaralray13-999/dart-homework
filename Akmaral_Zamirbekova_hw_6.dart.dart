////////////  в классе  //////////////
class Person {
  String fullName;
  int age;
  bool isMarried;

  Person(this.fullName, this.age, this.isMarried);

  void introduce() {
    print(
      'Hi! My name is $fullName. I am $age years old. Married: ${isMarried ? 'Yes' : 'No'}.',
    );
  }
}

/////////////// предметы ///////////////
enum Subject { math, physics, english, history }

///////////// Класс Student //////////////////
class Student extends Person {
  Map<Subject, double> marks;

  Student(String fullName, int age, bool isMarried, this.marks)
    : super(fullName, age, isMarried);

  void showMarks() {
    print('Student: $fullName');
    for (var entry in marks.entries) {
      print('${entry.key.name}: ${entry.value}');
    }
  }

  double calculateAverage() {
    double sum = 0;
    for (var value in marks.values) {
      sum += value;
    }
    return sum / marks.length;
  }

  @override
  void introduce() {
    print(
      'Hi! My name is $fullName. I am $age years old. Married: ${isMarried ? 'Yes' : 'No'}.',
    );
    print('Average mark: ${calculateAverage()}');
  }
}

///////////////////Класс teacher //////////////////
class Teacher extends Person {
  int experience;
  static double _baseSalary = 50000;

  Teacher(String fullName, int age, bool isMarried, this.experience)
    : super(fullName, age, isMarried);

  double calculateSalary() {
    double salary = _baseSalary;
    if (experience > 3) {
      for (int i = 4; i <= experience; i++) {
        salary *= 1.05;
      }
    }
    if (isMarried) {
      salary += 5000;
    }
    return salary;
  }

  @override
  void introduce() {
    print(
      'Hi! My name is $fullName. I am $age years old. Married: ${isMarried ? 'Yes' : 'No'}.',
    );
    print('Experience: $experience years. Salary: ${calculateSalary()}');
  }
}

//////////  главная функция ////////////////
void main() {
  Teacher teacher = Teacher('John Brown', 40, true, 10);
  teacher.introduce();
  print('Calculated salary: ${teacher.calculateSalary()}');

  Student student1 = Student('Adam White', 17, false, {
    Subject.math: 90,
    Subject.physics: 85,
    Subject.english: 92,
  });
  student1.introduce();
  student1.showMarks();
  print('Average mark: ${student1.calculateAverage()}');

  Student student2 = Student('Emily Green', 18, false, {
    Subject.math: 75,
    Subject.history: 88,
    Subject.english: 80,
  });
  student2.introduce();
  student2.showMarks();
  print('Average mark: ${student2.calculateAverage()}');
}
