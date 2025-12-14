class UserModel {
  final String fullName;
  final String studentId;
  final String yearOfStudy;
  final String department;
  final String enrollmentStatus;
  final String email;
  final String phone;
  final String password;

  String? profileImageUrl;

  UserModel({
    required this.fullName,
    required this.studentId,
    required this.yearOfStudy,
    required this.department,
    required this.enrollmentStatus,
    required this.email,
    required this.phone,
    required this.password,
    this.profileImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'studentId': studentId,
      'yearOfStudy': yearOfStudy,
      'department': department,
      'enrollmentStatus': enrollmentStatus,
      'email': email,
      'phone': phone,
      'password': password,
      'profileImageUrl': profileImageUrl,
    };
  }
}
