class EmployeeList {
  List<Employee>? message;

  EmployeeList({this.message});

  factory EmployeeList.fromJson(Map<String, dynamic> json) {
    var list = json['message'] as List<dynamic>?;
    return EmployeeList(
      message: list
          ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message?.map((e) => e.toJson()).toList(),
      };
}

class Employee {
  String? employee;
  String? namingSeries;
  String? firstName;
  String? middleName;
  String? lastName;
  String? employeeName;
  String? gender;
  String? dateOfBirth;
  String? salutation;
  String? dateOfJoining;
  String? userId;

  Employee({
    this.employee,
    this.namingSeries,
    this.firstName,
    this.middleName,
    this.lastName,
    this.employeeName,
    this.gender,
    this.dateOfBirth,
    this.salutation,
    this.dateOfJoining,
    this.userId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        employee: json['employee'] as String,
        namingSeries: json['naming_series'] as String,
        firstName: json['first_name'] as String,
        middleName: json['middle_name'] as String?,
        lastName: json['last_name'] as String?,
        employeeName: json['employee_name'] as String,
        gender: json['gender'] as String,
        dateOfBirth: json['date_of_birth'] as String,
        salutation: json['salutation'] as String?,
        dateOfJoining: json['date_of_joining'] as String,
        userId: json['user_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'employee': employee,
        'naming_series': namingSeries,
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'employee_name': employeeName,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'salutation': salutation,
        'date_of_joining': dateOfJoining,
        'user_id': userId,
      };
}
