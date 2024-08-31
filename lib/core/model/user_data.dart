class UserData {
  String? id;
  String? isStudent;
  String? name;
  String? email;
  String? password;

  UserData({this.id, this.isStudent, this.name, this.email, this.password});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'] as String?,
        isStudent: json['isStudent'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isStudent': isStudent,
        'name': name,
        'email': email,
        'password': password,
      };
}
