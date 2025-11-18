class Student {
  /////////////// студенты ///////////////////
  String _name;
  int _grade;
  double _averageScore = 0.0;

  Student(this._name, this._grade);
  Student.withScore(this._name, this._grade, this._averageScore);

  String get name => _name;
  int get grade => _grade;
  double get averageScore => _averageScore;

  set averageScore(double score) {
    if (score >= 0 && score <= 100) {
      _averageScore = score;
    } else {
      print('Ошибка: средний балл должен быть от 0 до 100.');
    }
  }

  void displayInfo() {
    print('Name: $_name, Grade: $_grade, Average Score: $_averageScore');
  }
}

/////////// Курс ///////////
class Course {
  String title;
  List<Student> students = [];

  Course(this.title);

  void addStudent(Student s) {
    students.add(s);
  }

  void showStudents() {
    print('Course: $title');
    print('Enrolled students:');
    for (var i = 0; i < students.length; i++) {
      print('${i + 1}. ${students[i].name}');
    }
  }
}

//////////// работа с main ///////////////
void main() {
  Student student1 = Student('Alice', 10);
  Student student2 = Student.withScore('Bob', 11, 88.5);
  Student student3 = Student('Charlie', 9);
  student3.averageScore = 75.0;

  Course dartCourse = Course('Dart Basics');
  dartCourse.addStudent(student1);
  dartCourse.addStudent(student2);
  dartCourse.addStudent(student3);
  dartCourse.showStudents();
  print('Total students in course: ${dartCourse.students.length}');
}
